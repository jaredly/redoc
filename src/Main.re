
let unwrap = (m, x) => switch x { | None => failwith(m) | Some(x) => x };

let main = (source, cmt, mlast) => {
  let text = Files.readFile(source) |> unwrap("Unable to read source file");
  let structure = ReadMlast.read_ast(mlast);
  let highlighted = Highlighting.highlight(text, structure);
  print_endline(Template.make(highlighted))

  /* open Cmt_format;
  let {cmt_annots, cmt_comments, cmt_imports} = read_cmt(cmt);
  switch cmt_annots {
    | Implementation(structure) => {
      ()
    }
    | _ => ()
  }; */
};

let main = () => {
  switch (Sys.argv) {
  | [|_, source, cmt, mlast|] => main(source, cmt, mlast)
  | _ => {
    print_endline({|
Usage: docre some.re some.cmt some.mlast
|});
  }
  }
};

main();
