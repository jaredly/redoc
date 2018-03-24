
let unwrap = (m, x) => switch x { | None => failwith(m) | Some(x) => x };

let main = (source, cmt, mlast, output) => {
  let text = Files.readFile(source) |> unwrap("Unable to read source file");
  let structure = ReadMlast.read_ast(mlast);
  let highlighted = Highlighting.highlight(text, structure);
  Files.writeFile(output, Template.make(highlighted)) |> ignore;



  open Cmt_format;
  let {cmt_annots, cmt_comments, cmt_imports} = read_cmt(cmt);
  switch cmt_annots {
    | Implementation(structure) => {
      Printtyped.implementation(Format.str_formatter, structure);
      Files.writeFile("log_types.txt", Format.flush_str_formatter()) |> ignore;
      ()
    }
    | _ => ()
  };
};

let main = () => {
  switch (Sys.argv) {
  | [|_, source, cmt, mlast, output|] => main(source, cmt, mlast, output)
  | _ => {
    print_endline({|
Usage: docre some.re some.cmt some.mlast output.html
|});
  }
  }
};

main();
