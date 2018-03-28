
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


let main = structure => {
  let codeBlocks = Hashtbl.create(50);

};
