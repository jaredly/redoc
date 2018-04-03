
let unwrap = (m, x) => switch x { | None => failwith(m) | Some(x) => x };

let annotateSourceCode = (source, cmt, mlast, output) => {
  let annots = Cmt_format.read_cmt(cmt).Cmt_format.cmt_annots;
  let (types, bindings, externals, all_opens, locToPath) = Typing.collectTypes(annots);
  let text = Files.readFile(source) |> unwrap("Unable to read source file");
  let structure = ReadMlast.structure(mlast);
  let (highlighted, typeText) = Highlighting.highlight(text, structure, types, bindings, externals, all_opens, locToPath);
  Files.writeFile(output, Template.make(highlighted, typeText)) |> ignore;
};

let getName = x => Filename.basename(x) |> Filename.chop_extension;

let generateDocs = (~cssLoc, ~jsLoc, cmt, output, projectNames) => {
  let name = getName(cmt);
  let annots = Cmt_format.read_cmt(cmt).Cmt_format.cmt_annots;

  let text = switch annots {
  | Cmt_format.Implementation(structure) => {

    Printtyped.implementation(Format.str_formatter, structure);
    let out = Format.flush_str_formatter();
    Files.writeFile("./_build/" ++ name ++ ".typ.inft", out) |> ignore;

    Docs.implementation(~cssLoc, ~jsLoc, name, structure, projectNames)
  }
  | Cmt_format.Interface(signature) => {

    Printtyped.interface(Format.str_formatter, signature);
    let out = Format.flush_str_formatter();
    Files.writeFile("./_build/" ++ name ++ ".typ.inft", out) |> ignore;

    Docs.interface(~cssLoc, ~jsLoc, name, signature, projectNames)
  }
  | _ => failwith("Not a valid cmt file")
  };

  Files.writeFile(output, text) |> ignore;
};

let generateProject = (dest, cmts) => {
  Files.mkdirp(dest);

  /* Remove .cmt's that have .cmti's */
  let intfs = Hashtbl.create(100);
  cmts |> List.iter(path => if (Filename.check_suffix(path, ".cmti")) {
    Hashtbl.add(intfs, getName(path), true)
  });
  let cmts = cmts |> List.filter(path => {
    !(Filename.check_suffix(path, ".cmt") && Hashtbl.mem(intfs, getName(path)))
  });

  let cssLoc = Filename.concat(dest, "styles.css");
  let jsLoc = Filename.concat(dest, "script.js");

  Files.writeFile(cssLoc, DocsTemplate.styles) |> ignore;
  Files.writeFile(jsLoc, DocsTemplate.script) |> ignore;

  let names = List.map(getName, cmts);
  cmts |> List.iter(cmt => {
    let name = Filename.basename(cmt) |> Filename.chop_extension;
    generateDocs(~cssLoc=Some("./styles.css"), ~jsLoc=Some("./script.js"), cmt, Filename.concat(dest, name ++ ".html"), names)
  })
};

let main = () => {
  switch (Sys.argv |> Array.to_list) {
  | [_, "project", dest, ...rest] => generateProject(dest, rest)
  | [_, source, cmt, mlast, output] => annotateSourceCode(source, cmt, mlast, output)
  | [_, cmt, output] => generateDocs(~cssLoc=None, ~jsLoc=None, cmt, output, [])
  | _ => {
    print_endline("\n\nUsage: docre some.re some.cmt some.mlast output.html");
  }
  }
};

main();
