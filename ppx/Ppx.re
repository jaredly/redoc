
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

let getCodeBlocks = (docString, loc) => [];

let parseCodeBlock = (codeBlock) => Ast_helper.Str.eval(Ast_helper.Exp.constant(Asttypes.Const_int(10)));

let main = structure => {
  let docStrings = ref([]);
  ignore(DocMapper.map((newStrings) => {
    docStrings := List.append(newStrings, docStrings^);
    []
  }, structure));
  let docStrings = docStrings^;
  let docASTs = Hashtbl.create(List.length(docStrings));
  docStrings |> List.iter(((docString, loc)) => {
    let codeBlocks = getCodeBlocks(docString, loc);
    let codeBlockAsts = List.map(parseCodeBlock, codeBlocks);
    Hashtbl.replace(docASTs, (docString, loc), codeBlockAsts)
  });
  DocMapper.map((docStrings) => {
    let codeBlockAsts = docStrings |> List.map(pair => Hashtbl.find(docASTs, pair)) |> List.concat;
    codeBlockAsts
  }, structure)
};
