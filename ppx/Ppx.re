
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

let rec white = num => if (num <= 0) { "" } else {" " ++ white(num - 1)};

let splitLines = text => Str.split(Str.regexp_string("\n"), text);

let getCodeBlocks = (docString, loc) => {
  let (offset, markdown) = docString.[0] == ' ' ? (1, String.sub(docString, 1, String.length(docString) - 1)) : (0, docString);
  let mst = Omd.of_string(markdown);
  let codeBlocks = ref([]);
  let pos = ref(0);
  let _mst = Omd.Representation.visit(el => {
    open Omd.Representation;
    switch el {
    | Code_block(lang, body) => {
      if (lang == "parse") {
        print_endline("BlocK " ++ lang ++ " - " ++ body);
        let found = Str.search_forward(Str.regexp_string(body), markdown, pos^);
        pos := found + String.length(body);

        /* Ok I now need to pad with spaces n stuff to make it at the right place relative to the start of the docblock */
        let totalOffset = found + loc.Location.loc_start.Lexing.pos_cnum + offset + 3;
        print_endline("Offset " ++ string_of_int(totalOffset));
        let paddedBody = white(totalOffset - 6) ++ "()=>{\n" ++ body ++ "}";
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
  let tmp = Filename.get_temp_dir_name();
  let txt = Filename.concat(tmp, string_of_float(Random.float(100.)));
  let astFile = txt ++ ".ast";
  /* TODO get a real tmpfile */
  Files.writeFile(txt, codeBlock) |> ignore;
  let (_, _success) = Commands_native.execSync(~cmd="refmt --print binary --parse re < " ++ txt ++ " > " ++ astFile, ());
  let ic = open_in_bin(astFile);
  let ast: Parsetree.structure = ReadMlast.read_ml_ast(ic);
  close_in(ic);
  Unix.unlink(txt);
  Unix.unlink(astFile);
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