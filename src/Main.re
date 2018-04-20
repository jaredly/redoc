
open MainAux;
open Infix;

switch (parse(args)) {
| Minimist.Error(err) => fail(Minimist.report(err))
| Ok({Minimist.strings, multi: multiMap, presence}) =>
  open Minimist;
  if (has("help", presence)) {
    print_endline(help); exit(0);
  } else {
    let root = get(strings, "root") |? Unix.getcwd();
    let bsRoot = get(strings, "bs-root") |? (root /+ "node_modules/bs-platform");
    let target = get(strings, "target") |? (root /+ "docs");
    let projectName = get(strings, "name") |? String.capitalize(Filename.dirname(root));
    let sourceDirectories = multi(multiMap, "cmi-directory");
    generateProject(~selfPath, ~root, ~target, ~projectName, ~test=has("doctest", presence), ~sourceDirectories, ~bsRoot)
  }
};


/* let main = () => {
  switch (Sys.argv |> Array.to_list) {
  | [_] => generateProject(String.capitalize(Filename.dirname(Unix.getcwd())), ".")
  | [_, "-h"] => print_endline(docs)
  | [_, thing, ..._] when thing != "" && thing.[0] == '-' => print_endline(docs)
  | [_, name] => generateProject(name, ".")
  | [_, name, base] => generateProject(name, base)
  /* | [_, "cmts", dest, ...rest] => generateMultiple(None, None, dest, rest, []) */
  | [_, "annotate", source, cmt, mlast, output] => annotateSourceCode(source, cmt, mlast, output)
  | _ => print_endline(docs)
  }
};

main(); */
