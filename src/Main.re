
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

let processCmt = (name, cmt) => {
  let annots = Cmt_format.read_cmt(cmt).Cmt_format.cmt_annots;

  switch annots {
  | Cmt_format.Implementation({str_items} as s) => {
    Printtyped.implementation(Format.str_formatter, s);
    let out = Format.flush_str_formatter();
    Files.writeFile("./_build/" ++ name ++ ".typ.inft", out) |> ignore;

    let stamps = PrepareDocs.organizeTypes((name, []), str_items);
    let (topdoc, allDocs) = PrepareDocs.findAllDocs(str_items);
    (stamps, topdoc, allDocs)
  }
  | Cmt_format.Interface({sig_items} as s) => {
    Printtyped.interface(Format.str_formatter, s);
    let out = Format.flush_str_formatter();
    Files.writeFile("./_build/" ++ name ++ ".typ.inft", out) |> ignore;

    let stamps = PrepareDocs.organizeTypesIntf((name, []), sig_items);
    let (topdoc, allDocs) = PrepareDocs.findAllDocsIntf(sig_items);
    (stamps, topdoc, allDocs)
  }
  | _ => failwith("Not a valid cmt file")
  };
};

let (/+) = Filename.concat;

let filterDuplicates = cmts => {
  /* Remove .cmt's that have .cmti's */
  let intfs = Hashtbl.create(100);
  cmts |> List.iter(path => if (Filename.check_suffix(path, ".cmti")) {
    Hashtbl.add(intfs, getName(path), true)
  });
  cmts |> List.filter(path => {
    !(Filename.check_suffix(path, ".cmt") && Hashtbl.mem(intfs, getName(path)))
  });
};

let generateMultiple = (dest, cmts, markdowns) => {
  Files.mkdirp(dest);

  let cmts = filterDuplicates(cmts);

  let cssLoc = Filename.concat(dest, "styles.css");
  let jsLoc = Filename.concat(dest, "script.js");

  Files.writeFile(cssLoc, DocsTemplate.styles) |> ignore;
  Files.writeFile(jsLoc, DocsTemplate.script) |> ignore;

  let api = dest /+ "api";
  Files.mkdirp(api);
  let names = List.map(getName, cmts);
  cmts |> List.iter(cmt => {
    let name = getName(cmt);
    let output = dest /+ "api" /+ name ++ ".html";
    let rel = Files.relpath(Filename.dirname(output));

    let markdowns = List.map(((path, contents, name)) => (rel(path), name), markdowns);

    let (stamps, topdoc, allDocs) = processCmt(name, cmt);
    let text = Docs.generate(~cssLoc=Some(rel(cssLoc)), ~jsLoc=Some(rel(jsLoc)), name, topdoc, stamps, allDocs, names, markdowns);

    Files.writeFile(output, text) |> ignore;
  })
};

let unwrap = (m, n) => switch n { | None => failwith(m) | Some(n) => n };
let optOr = (d, o) => switch o { | None => d | Some(n) => n };

let stripNumber = name => {
  if (name.[0] <= '9' && name.[0] >= '0' && name.[1] == '_') {
    String.sub(name, 2, String.length(name) - 2)
  } else {
    name
  }
};

let asHtml = path => Filename.chop_extension(path) ++ ".html";

let isReadme = path => Filename.check_suffix(String.lowercase(path), "/readme.md");

let htmlName = path => {
  if (isReadme(path)) {
    String.sub(path, 0, String.length(path) - String.length("/readme.md")) /+ "index.html"
  } else {
    asHtml(path)
  }
};

let getOrder = path => {
  if (isReadme(path)) {
    ""
  } else {
    path
  }
};

let getTitle = (path, base) => {
  if (isReadme(path)) {
    let dir = Filename.dirname(path);
    if (dir == base) {
      "Home"
    } else {
      Filename.basename(dir)
    }
  } else {
    getName(path) |> stripNumber
  }
};

let getMarkdowns = (projectName, base) => {
  let docsBase = base /+ "docs";
  let files = Files.collect(docsBase, name => Filename.check_suffix(name, ".md"));
  let files = files |> List.map(path => {
    (getOrder(path), htmlName(path), Files.readFile(path) |> unwrap("Unable to read markdown file " ++ path), getTitle(path, docsBase))
  });
  let files = if (!List.exists(((_, path, _, _)) => String.lowercase(path) == String.lowercase(docsBase) /+ "readme.md", files)) {
    let readme = base /+ "Readme.md";
    let contents = Files.readFile(readme) |> optOr("# " ++ projectName ++ "\n\nWelcome to the documentation!");
    [("", base /+ "docs" /+ "index.html", contents, "Home"), ...files]
  } else {
    files
  };
  List.sort(compare, files) |> List.map(((_, html, contents, name)) => (html, contents, name))
};

let generateProject = (projectName, base) => {
  let compiledRoot = base /+ "lib/bs/js/";
  let found = Files.collect(compiledRoot, name => Filename.check_suffix(name, ".cmt") || Filename.check_suffix(name, ".cmti"));
  let markdowns = getMarkdowns(projectName, base);
  generateMultiple(base /+ "docs", found, markdowns);
};

let generateDocs = (cmt) => {
  let name = getName(cmt);
  let (stamps, topdoc, allDocs) = processCmt(name, cmt);
  Docs.generate(~cssLoc=None, ~jsLoc=None, name, topdoc, stamps, allDocs, [], []);
};

let main = () => {
  switch (Sys.argv |> Array.to_list) {
  | [_, "project", name, base] => generateProject(name, base)
  | [_, "multiple", dest, ...rest] => generateMultiple(dest, rest, [])
  | [_, source, cmt, mlast, output] => annotateSourceCode(source, cmt, mlast, output)
  | [_, cmt, output] => Files.writeFile(output, generateDocs(cmt)) |> ignore
  | _ => {
    print_endline("\n\nUsage: docre some.re some.cmt some.mlast output.html");
  }
  }
};

main();
