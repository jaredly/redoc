
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
    /* Printtyped.implementation(Format.str_formatter, s);
    let out = Format.flush_str_formatter();
    Files.writeFile("debug_" ++ name ++ ".typ.inft", out) |> ignore; */

    let stamps = PrepareDocs.organizeTypes((name, []), str_items);
    let (topdoc, allDocs) = PrepareDocs.findAllDocs(str_items);
    (stamps, topdoc, allDocs)
  }
  | Cmt_format.Interface({sig_items} as s) => {
    /* Printtyped.interface(Format.str_formatter, s);
    let out = Format.flush_str_formatter();
    Files.writeFile("debug_" ++ name ++ ".typ.inft", out) |> ignore; */

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

let linkifyMarkdown = (curPath, basePath, addTocs, tocLevel, override, element) => {
  let rel = Files.relpath(Filename.dirname(curPath));
  switch element {
  | Omd.Url(href, contents, title) when String.length(href) > 0 => {
    let contents = Omd.to_html(~override, contents);
    if (href.[0] == '.' || href.[0] == '/' || href.[0] == '#' || href.[0] == '?') {
      let href = if (href.[0] == '/') {
        rel(Filename.concat(basePath, href))
      } else if (href.[0] == '?' || href.[0] == '#') {
        href
      } else {
        Filename.concat(Filename.dirname(curPath), href)
      };
      Some(Printf.sprintf({|<a href="%s" title="%s">%s</a>|}, href, title, contents))
    } else {
      Some(Printf.sprintf({|<a href="%s" target="_blank" rel="noopener nofollow" title="%s" class="external-link">%s</a>|}, href, title, contents))
    }
  }
  | _ => None
  }
};

open Infix;

let replace = (one, two, text) => Str.global_replace(Str.regexp_string(one), two, text);
let escape = text => replace("\\", "\\\\", text) |> replace("\n", "\\n") |> replace("\"", "\\\"");

let serializeSearchable = ((href, title, contents, rendered, breadcrumb)) => {
  Printf.sprintf({|{"href": "%s", "title": "%s", "contents": "%s", "rendered": "%s", "breadcrumb": "%s"}|}, escape(href), escape(title), escape(contents), escape(rendered), escape(breadcrumb))
};

let serializeSearchables = searchables => "[" ++ String.concat(",\n", List.map(serializeSearchable, searchables)) ++ "]";

let makeTokenCollector = (base) => {
  let tokens = ref([]);
  let addToken = n => tokens := [n, ...tokens^];
  open PrintType.T;
  /* let base = PrintType.default; */
  /* TODO collect arg labels from expressions */
  (tokens, {
    ...base,
    expr: (printer, expr) => {
      switch (expr.Types.desc) {
      | Tarrow(label, arg, result, _) => {
        let (args, _) = PrintType.collectArgs([(label, arg)], result);
        args |> List.iter(((label, _)) => {
          let label = label != "" && label.[0] == '?' ? String.sub(label, 1, String.length(label) - 1) : label;
          addToken(label)
        });
      }
      | _ => ()
      };
      base.expr(printer, expr)
    },
    path: (printer, path, pathType) => {
      switch path {
      | Path.Pident({name})
      | Pdot(_, name, _) => addToken(name)
      | Papply(_, _) => ()
      };
      base.path(printer, path, pathType)
    },
    ident: (printer, {Ident.name} as i) => {
      addToken(name);
      base.ident(printer, i)
    }
  })
};


let makeDocStringProcessor = (dest) => {
  let searchables = ref([]);
  let addSearchable = (file, hash, title, contents, rendered, breadcrumb) => {
    let href = Files.relpath(dest, file) ++ fold(hash, "", h => "#" ++ h);
    searchables := [(href, title, contents, rendered, breadcrumb), ...searchables^];
  };

  /** All to make things searchable */
  let processDocString = (searchPrinter, fileName, fileTitle, ~override=?, path, name, typ, rawText) => {
    /* let id = GenerateDoc.makeId(path @ [name], typ); */
    let title = path == [] ? fileTitle : String.concat(".", path);
    open PrepareDocs.T;
    /** The representation of the value itself */
    let makeId = t => path == [] ? None : Some(GenerateDoc.makeId(path, t));
    /* print_endline(name); */
    let hash = switch typ {
    | None => None
    | Some(t) => switch t {
      | Module(_) =>  makeId(PModule)
      | Value(typ) => {
        /** TODO use the other printer for nice linking of things. also want to highlight fn argument labels. */
        let (tokens, printer) = makeTokenCollector(searchPrinter);
        let text = "<h4 class='item'>" ++ GenerateDoc.prettyString(printer.PrintType.T.value(printer, name, name, typ)) ++ "</h4>";
        let tokens = name ++ " " ++ String.concat(" ", tokens^);
        addSearchable(fileName, Some(GenerateDoc.makeId(path, PValue)), title, tokens, text, fileTitle);
        makeId(PValue)
      }
      | Type(typ) => {
        /* print_endline("making a search for type"); */
        let (tokens, printer) = makeTokenCollector(searchPrinter);
        let text = "<h4 class='item'>" ++ GenerateDoc.prettyString(printer.PrintType.T.decl(printer, name, name, typ)) ++ "</h4>";
        let tokens = name ++ " " ++ String.concat(" ", tokens^);
        addSearchable(fileName, Some(GenerateDoc.makeId(path, PType)), title, tokens, text, fileTitle);
        makeId(PType)
      }
      | StandaloneDoc(_) | Include(_) => None
      }
    };

    if (rawText == "") {
      ""
    } else {
      /** Docstring paragraphs */
      let md = Omd.of_string(rawText);
      /** TODO track headings within this for better breadcrumb */
      let _ = Omd.Representation.visit(el => {
        switch el {
        | Omd.Paragraph(t) => {
          let text = Omd.to_text(t);
          if (String.trim(text) == "@all" || String.length(text) > 4 && String.sub(text, 0, 4) == "@doc") {
            ()
          } else {
            addSearchable(fileName, hash, title, text, Omd.to_html(~override?, t), fileTitle)
          }
        }
        | Code_block(lang, contents) => {
          /** TODO parse the contents & provide better tokens */
          addSearchable(fileName, None, "code block", contents, "<pre><code>" ++ contents ++ "</code></pre>", fileTitle);
        }
        | H1(t) | H2(t) | H3(t) | H4(t) | H5(t) => {
          let title = Omd.to_text(t);
          addSearchable(fileName, Some(GenerateDoc.cleanForLink(title)), title, "", "", fileTitle)
        }
        | _ => ()
        };
        None
      }, md);
      Omd.to_html(~override?, md)
    }
  };

  (searchables, processDocString)
};
open Infix;

let generateMultiple = (base, compiledBase, url, dest, cmts, markdowns) => {
  Files.mkdirp(dest);

  let cmts = filterDuplicates(cmts);

  let cssLoc = Filename.concat(dest, "styles.css");
  let jsLoc = Filename.concat(dest, "script.js");

  Files.writeFile(cssLoc, DocsTemplate.styles) |> ignore;
  Files.writeFile(jsLoc, DocsTemplate.script) |> ignore;

  let names = List.map(getName, cmts);

  let (searchables, processDocString) = makeDocStringProcessor(dest);

  let searchHref = (names, doc) => {
    switch (Docs.formatHref("", names, doc)) {
    | None => None
    /* | Some(href) when href != "" && href.[0] == '#' => Some(href) */
    | Some(href) => Some("./api/" ++ href)
    }
  };

  let codeBlocks = CodeSnippets.process(markdowns, cmts, base);


  let api = dest /+ "api";
  Files.mkdirp(api);
  cmts |> List.iter(cmt => {
    let name = getName(cmt);
    let output = dest /+ "api" /+ name ++ ".html";
    let rel = Files.relpath(Filename.dirname(output));

    let markdowns = List.map(((path, contents, name)) => (rel(path), name), markdowns);

    let (stamps, topdoc, allDocs) = processCmt(name, cmt);
    let searchPrinter = GenerateDoc.printer(searchHref(names), stamps);
    let sourceUrl = url |?> (url => {
      let relative = Files.relpath(compiledBase, cmt) |> Filename.chop_extension;
      let isInterface = Filename.check_suffix(cmt, "i");
      let re = Filename.concat(base, relative) ++ (isInterface ? ".rei" : ".re");
      let ml = Filename.concat(base, relative) ++ (isInterface ? ".mli" : ".ml");
      if (Files.exists(re)) {
        Some(url ++ relative ++ (isInterface ? ".rei" : ".re"))
      } else if (Files.exists(ml)) {
        Some(url ++ relative ++ (isInterface ? ".mli" : ".ml"))
      } else {
        None
      }
    });
    let text = Docs.generate(~sourceUrl, ~relativeToRoot=rel(dest), ~cssLoc=Some(rel(cssLoc)), ~jsLoc=Some(rel(jsLoc)), ~processDocString=processDocString(searchPrinter, output, name), name, topdoc, stamps, allDocs, names, markdowns);

    Files.writeFile(output, text) |> ignore;
  });

  markdowns |> List.iter(((path, contents, name)) => {
    let rel = Files.relpath(Filename.dirname(path));
    let (tocItems, override) = GenerateDoc.trackToc(~lower=true, 0, linkifyMarkdown(path, dest));
    let searchPrinter = GenerateDoc.printer(searchHref(names), []);
    let main = processDocString(searchPrinter, path, name, ~override, [], name, None, contents);
    /* Omd.to_html(~override, Omd.of_string(contents)); */

    let sourceUrl = url |?> (url => {
      let relative = Files.relpath(dest, path |> Filename.chop_extension |> x => x ++ ".md");
      Some(url ++ "docs/" ++ relative)
    });

    let markdowns = List.map(((path, contents, name)) => (rel(path), name), markdowns);
    let projectListing = names |> List.map(name => (rel(api /+ name ++ ".html"), name));
    let html = Docs.page(~sourceUrl, ~relativeToRoot=rel(dest), ~cssLoc=Some(rel(cssLoc)), ~jsLoc=Some(rel(jsLoc)), name, List.rev(tocItems^), projectListing, markdowns, main);

    Files.writeFile(path, html) |> ignore;
  });

  {
    let path = dest /+ "search.html";
    let rel = Files.relpath(Filename.dirname(path));
    let markdowns = List.map(((path, contents, name)) => (rel(path), name), markdowns);
    let projectListing = names |> List.map(name => (rel(api /+ name ++ ".html"), name));
    let main = Printf.sprintf({|
      <input placeholder="Search the docs" id="search-input"/>
      <style>%s</style>
      <div id="search-results"></div>
      <link rel=stylesheet href="search.css">
      <script defer src="searchables.json.index.js"></script>
      <script defer src="elasticlunr.js"></script>
      <script defer src="search.js"></script>
    |}, DocsTemplate.searchStyle);
    let html = Docs.page(~sourceUrl=None, ~relativeToRoot=rel(dest), ~cssLoc=Some(rel(cssLoc)), ~jsLoc=Some(rel(jsLoc)), "Search", [], projectListing, markdowns, main);
    Files.writeFile(path, html) |> ignore;
    Files.writeFile(dest /+ "search.js", DocsTemplate.searchScript) |> ignore;
    Files.writeFile(dest /+ "elasticlunr.js", ElasticRaw.raw) |> ignore;
    Files.writeFile(dest /+ "searchables.json", serializeSearchables(searchables^)) |> ignore;
    MakeIndex.run(dest /+ "elasticlunr.js", dest /+ "searchables.json")
  };
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

/** TODO use this somewhere */
let escapePath = path => Str.global_replace(Str.regexp("[^a-zA-Z0-9_.-]"), "-", path);

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

let absify = path => {
  if (path == "") {
    Unix.getcwd()
  } else if (path.[0] == '/') {
    path
  } else {
    Filename.concat(Unix.getcwd(), path)
  }
};

let startsWith = (full, prefix) => String.length(full) >= String.length(prefix) && String.sub(full, 0, String.length(prefix)) == prefix;
let isCmt = name => {
  !startsWith(Filename.basename(name), CodeSnippets.codeBlockPrefix) && (Filename.check_suffix(name, ".cmt") || Filename.check_suffix(name, ".cmti"));
};

let generateProject = (projectName, base) => {
  let compiledRoot = base /+ "lib/bs/js/";
  let compiledRoot = if (!Files.exists(compiledRoot)) {
    let compiledRoot = base /+ "lib/bs/";
    if (!Files.exists(compiledRoot)) {
      print_endline("You must run bucklescript first to generate the artifacts. " ++ compiledRoot ++ " not found.");
      exit(1);
    } else {
      compiledRoot
    }
  } else {
    compiledRoot
  };
  let found = Files.collect(compiledRoot, isCmt);
  let markdowns = getMarkdowns(projectName, base);
  let url = ParseConfig.getUrl(base);
  generateMultiple(base, compiledRoot, url, base /+ "docs", found, markdowns);
  let localUrl = "file://" ++ absify(base) /+ "docs" /+ "index.html";
  print_newline();
  print_endline("Complete! Docs are available in " ++ (base /+ "docs") ++ "\nOpen " ++ localUrl ++ " in your browser to view");
  print_newline();
};

let docs = {|
Usage:
      docre [project title = directory name] [base directory = .] [output directory = ./docs]
        When run with no arguments, the current directory is used.
        You must run bucklescript first to generate the necessary artifacts.

      docre -h
        show this help
|};

let main = () => {
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

main();
