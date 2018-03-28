
/*
 * Game plan:
 * - find `ocaml.doc` attributes on `let` structure items
 * - parse the markdown
 * - crawl through and find `Code` and `CodeBlock` instances. (probably only the CodeBlocks tbh)
 * - for each: make a file that has just that code block, positioned such that the cnum & linenums will line up
 * - pass that to refmt, and read in the AST
 * - dump that after each `let` in a function so it will be type checked, but wont execute
 * - from there, everything should just work?? in terms of picking up tokens & types & stuff....
*/

let stripStars = str => {
  Str.split(Str.regexp_string("\n"), str) |> List.map(line => {
    if (line == " *") {
      ""
    } else if (String.length(line) >= 3) {
      if (String.sub(line, 0, 3) == " * ") {
        String.sub(line, 3, String.length(line) - 3)
      } else {
        line
      }
    } else {
      line
    }
  }) |> String.concat("\n")
};

let rec white = num => if (num <= 0) { "" } else {" " ++ white(num - 1)};

let splitLines = text => Str.split(Str.regexp_string("\n"), text);

let getCodeBlocks = (docString, loc) => {
  let markdown = stripStars(docString);
  let mst = Omd.of_string(markdown);
  let codeBlocks = ref([]);
  let pos = ref(0);
  let _mst = Omd_representation.visit(el => {
    open Omd_representation;
    switch el {
    | Code_block(lang, body) => {
      if (lang == "parse") {
        print_endline("BlocK " ++ lang ++ " - " ++ body);
        let found = Str.search_forward(Str.regexp_string(body), markdown, pos^);
        pos := found + String.length(body);

        let markLines = splitLines(String.sub(markdown, 0, found));
        let num = List.length(markLines);
        let origLines = splitLines(docString);

        let rec loop = (i, lines) => {
          if (i >= num) {
            0
          } else {
            switch lines {
            | [] => assert(false)
            | [line, ...rest] => min(3, String.length(line)) + loop(i + 1, rest)
            }
          }
        };
        let offset = loop(0, origLines);

        let spaced = splitLines(body) |> List.map(line => {
          "   " ++ line
        }) |> String.concat("\n");

        /* let offset = String.sub(markdown, 0, found) |> splitLines |> List.length; */

        /* Ok I now need to pad with spaces n stuff to make it at the right place relative to the start of the docblock */
        let totalOffset = 1 + found + loc.Location.loc_start.Lexing.pos_cnum + 3 + offset;
        print_endline("Offset " ++ string_of_int(totalOffset));
        let paddedBody = white(totalOffset - 6) ++ "()=>{\n" ++ spaced ++ "}";
        codeBlocks := [paddedBody, ...codeBlocks^]
      };
      None
    }
    | _ => None
    }
  }, mst);
  codeBlocks^
};

let parseCodeBlock = (codeBlock) => {
  Files.writeFile("./code.re", codeBlock) |> ignore;
  let (_, success) = Commands_native.execSync(~cmd="refmt --print binary < code.re > code.ast", ());
  let ic = open_in_bin("./code.ast");
  let ast: Parsetree.structure = ReadMlast.read_ml_ast(ic);
  close_in(ic);
  /* Ast_helper.Str.eval(Ast_helper.Exp.constant(Asttypes.Const_int(10))); */
  ast
};

let main = structure => {
  let docStrings = ref([]);
  ignore(DocMapper.map((newStrings) => {
    print_endline("Got a docstring");
    docStrings := List.append(newStrings, docStrings^);
    []
  }, structure));
  let docStrings = docStrings^;
  let docASTs = Hashtbl.create(List.length(docStrings));
  docStrings |> List.iter(((docString, loc)) => {
    let codeBlocks = getCodeBlocks(docString, loc);
    let codeBlockAsts = List.map(parseCodeBlock, codeBlocks) |> List.concat;
    Hashtbl.replace(docASTs, (docString, loc), codeBlockAsts)
  });
  DocMapper.map((docStrings) => {
    let codeBlockAsts = docStrings |> List.map(pair => Hashtbl.find(docASTs, pair)) |> List.concat;
    codeBlockAsts
  }, structure)
};

let justStructure = fn => {
  ...Ast_mapper.default_mapper,
  structure: (mapper, structure) => fn(structure)
};

let () = Ast_mapper.register("docre.ppx", args => justStructure(main))