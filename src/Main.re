
let unwrap = (m, x) => switch x { | None => failwith(m) | Some(x) => x };

let main = (source, cmt, mlast, output) => {
  let annots = Cmt_format.read_cmt(cmt).Cmt_format.cmt_annots;
  let (types, bindings, externals, all_opens, locToPath) = Typing.collectTypes(annots);

  /*
  /** Example: showing usages: */
  Hashtbl.iter((key, (({Ident.name, stamp}, loc), uses)) => {
    Printf.printf("%s (%d-%d)\n", name, loc.Location.loc_start.pos_cnum, loc.Location.loc_end.pos_cnum);
    uses |> List.iter(((path, loc)) => {
      Printf.printf("  %d-%d\n", loc.Location.loc_start.pos_cnum, loc.Location.loc_end.pos_cnum)
    })
  }, bindings); */

  let text = Files.readFile(source) |> unwrap("Unable to read source file");
  let structure = ReadMlast.read_ast(mlast);
  let (highlighted, typeText) = Highlighting.highlight(text, structure, types, bindings, externals, all_opens, locToPath);
  Files.writeFile(output, Template.make(highlighted, typeText)) |> ignore;
};

let main = () => {
  switch (Sys.argv) {
  | [|_, source, cmt, mlast, output|] => main(source, cmt, mlast, output)
  | _ => {
    print_endline("\n\nUsage: docre some.re some.cmt some.mlast output.html");
  }
  }
};

main();
