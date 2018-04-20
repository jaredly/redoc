open Infix;

let linkifyMarkdown = (curPath, basePath, addTocs, tocLevel, override, element) => {
  let rel = Files.relpath(Filename.dirname(curPath));
  switch element {
  | Omd.Url(href, contents, title) when String.length(href) > 0 => {
    let contents = Omd.to_html(~override, contents);
    if (href.[0] == '.' || href.[0] == '/' || href.[0] == '#' || href.[0] == '?') {
      let href = if (href.[0] == '/') {
        rel(basePath /+ href)
      } else if (href.[0] == '?' || href.[0] == '#') {
        href
      } else {
        Filename.dirname(curPath) /+ href
      };
      Some(Printf.sprintf({|<a href="%s" title="%s">%s</a>|}, href, title, contents))
    } else {
      Some(Printf.sprintf({|<a href="%s" target="_blank" rel="noopener nofollow" title="%s" class="external-link">%s</a>|}, href, title, contents))
    }
  }
  | _ => None
  }
};

let sliceToEnd = (s, num) => String.length(s) < num ? s : String.sub(s, num, String.length(s) - num);
let slice = (s, pre, post) => String.sub(s, pre, String.length(s) - pre + post);

let startsWith = (prefix, string) => {
  let lp = String.length(prefix);
  lp <= String.length(string) && String.sub(string, 0, lp) == prefix
};


let makeTokenCollector = (base) => {
  let tokens = ref([]);
  let addToken = n => tokens := [n, ...tokens^];
  open PrintType.T;
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

let makeDocStringProcessor = (dest, outerOverride) => {
  let searchables = ref([]);
  let addSearchable = (file, hash, title, contents, rendered, breadcrumb) => {
    let href = Files.relpath(dest, file) ++ fold(hash, "", h => "#" ++ h);
    searchables := [(href, title, contents, rendered, breadcrumb), ...searchables^];
  };

  /** All to make things searchable */
  let processDocString = (searchPrinter, fileName, fileTitle, ~override=?, path, name, typ, mdNode) => {
    let override = switch override {
    | None => outerOverride
    | Some(inner) => el => switch (inner(el)) {
    | None => outerOverride(el)
    | x => x
    }
    };
    /* let id = GenerateDoc.makeId(path @ [name], typ); */
    let title = path == [] ? fileTitle : String.concat(".", path);
    open State.Model.Docs;
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

    let mdNode = Omd.Representation.visit(el => switch el {
    | Omd.Html_comment(text) when startsWith(text, "<!--!") => {
      Some(Omd.of_string(slice(text, 5, -3)))
    }
    /* | Html_comment(text) => {
      print_endline("Got a comment here " ++ text);
      None
    } */
    | _ => None
    }, mdNode);

    /** Docstring paragraphs */
    /** TODO track headings within this for better breadcrumb */
    let _ = Omd.Representation.visit(el => {
      switch el {
      | Omd.Paragraph(t) => {
        let text = Omd.to_text(t);
        if (String.trim(text) == "@all" || String.length(text) > 4 && String.sub(text, 0, 4) == "@doc") {
          ()
        } else {
          addSearchable(fileName, hash, title, text, Omd.to_html(~override, t), fileTitle)
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
    }, mdNode);
    Omd.to_html(~override, mdNode)
  };

  (searchables, processDocString)
};