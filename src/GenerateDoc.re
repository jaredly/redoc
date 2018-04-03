
open PrepareDocs.T;

let rec findByName = (allDocs, name) => {
  switch allDocs {
  | [] => None
  | [(n, _, _) as doc, ...rest] when n == name => Some(doc)
  | [_, ...rest] => findByName(rest, name)
  }
};

let rec findTypeByName = (allDocs, name) => {
  switch allDocs {
  | [] => None
  | [(n, _, Type(_)) as doc, ...rest] when n == name => Some(doc)
  | [_, ...rest] => findByName(rest, name)
  }
};

let rec findValueByName = (allDocs, name) => {
  switch allDocs {
  | [] => None
  | [(n, _, Value(_)) as doc, ...rest] when n == name => Some(doc)
  | [_, ...rest] => findByName(rest, name)
  }
};

let isUpperCase = t => t >= 'A' && t <= 'Z';

let rec processPath = (stampsToPaths, collector, path, ptype) => {
  switch path {
  | Path.Pident({name, stamp: 0}) => (name, collector, ptype)
  | Path.Pident({name, stamp}) => switch (List.assoc(stamp, stampsToPaths)) {
  | exception Not_found => ("<global>", [name], ptype)
  | (modName, inner, pp) => (modName, inner @ collector, ptype)
  }
  | Path.Pdot(inner, name, _) => processPath(stampsToPaths, [name, ...collector], inner, ptype)
  | Papply(_, _) => assert(false)
  }
};

let printer = (formatHref, stampsToPaths) => {
  ...PrintType.default,
  path: (printer, path, pathType) => {
    let (@!) = Pretty.append;
    let fullPath = processPath(stampsToPaths, [], path, pathType);
    let full = formatHref(fullPath);
    let show = name => {
      let tag = Printf.sprintf({|<a href="%s">%s</a>|}, full, name);
      Pretty.text(~len=String.length(name), tag)
    };
    switch path {
    | Pident({name}) => show(name)
    | Pdot(inner, name, _) => {
      printer.path(printer, inner, PModule) @! Pretty.text(".") @! show(name)}
    | Papply(_, _) => Pretty.text("<papply>")
    };
  }
};

let ptypePrefix = ptype => {
  switch ptype {
  | PModule => "module-"
  | PType => "type-"
  | PValue => "value-"
  | PModuleType => "module-type-"
  }
};

let makeId = (items, ptype) => {
  open PrepareDocs.T;
  ptypePrefix(ptype) ++ String.concat(".", items)
};

let defaultMain = name => "<span class='missing'>This module does not have a toplevel documentation block.</span>\n\n@all";

let prettyString = doc => {
  let buffer = Buffer.create(100);
  Pretty.print(~width=60, ~output=(text => {
    Buffer.add_string(buffer, text)
  }), ~indent=(num => {
    Buffer.add_string(buffer, "\n");
    for (i in 1 to num) {
      Buffer.add_string(buffer, " ")
    }
  }), doc);
  Buffer.to_bytes(buffer) |> Bytes.to_string
};

let cleanForLink = text => Str.global_replace(Str.regexp("[^a-zA-Z0-9_.-]"), "-", text);

let uniqueItems = items => {
  let m = Hashtbl.create(100);
  items |> List.filter(((name, _, t)) => {
    switch t {
    | Value(_) => {
      if (Hashtbl.mem(m, name)) {
        false
      } else {
        Hashtbl.add(m, name, true);
        true
      }
    }
    | _ => true
    }
  })
};

let rec generateDoc = (~skipDoc=false, formatHref, stampsToPaths, path, tocLevel, (name, docstring, content)) => {
  open PrepareDocs.T;
  /* let tocLevel = List.length(path); */
  let id = makeId(path @ [name]);
  let printer = printer(formatHref, stampsToPaths);
  let (middle, tocs) = switch content {
  | Module(items) => {
    open PrepareDocs.T;
    let (post, body, tocs) = switch items {
    | Items(items) => {
      let (html, tocs) = docsForModule(~skipDoc, formatHref, stampsToPaths, path @ [name], tocLevel + 1, name, switch docstring {
        | None => defaultMain(name)
        | Some(doc) => doc
        }, items);
      ("", "<div class='body module-body'>" ++ html ++ "</div>", tocs)
    }
    | Alias(path) => {
      let t = printer.path(printer, path, PModule) |> prettyString;
      (" : " ++ t, switch docstring {
      | None => ""
      | Some(doc) => "<div class='body module-body'>" ++ Omd.to_html(Omd.of_string(doc)) ++ "</div>"
      }, [])
    }
    };
    (Printf.sprintf({|<h4 class='item module'> module <a href="#%s" id="%s">%s</a>%s</h4>%s|}, id(PModule), id(PModule), name, post, body),
    tocs @ [(tocLevel, name, id(PModule))]
    )
  }
  | Include(maybePath, contents) => {
    /* TODO hyperlink the path */
    let name = switch maybePath {
    | None => ""
    | Some(path) => Path.name(path)
    };
    let (html, tocs) = docsForModule(~skipDoc=true, formatHref, stampsToPaths, path, tocLevel, name, switch docstring {
    | None => "@all"
    | Some(doc) => doc
    }, contents);
    (Printf.sprintf({|<h4 class='item module'> include %s</h4><div class='body module-body include-body'>|}, name) ++
    html ++ "</div>",
    tocs)
  }
  | Value(typ) => {
    let link = Printf.sprintf({|<a href="#%s" id="%s">%s</a>|}, id(PValue), id(PValue), name);
    let t = printer.value(printer, name, link, typ) |> prettyString;
    (Printf.sprintf("<h4 class='item'>%s</h4>\n\n<div class='body %s'>", t, docstring == None ? "body-empty" : "")
     ++ switch docstring {
    | None => skipDoc ? "" : "<span class='missing'>No documentation for this value</span>"
    | Some(doc) => Omd.to_html(Omd.of_string(doc))
    } ++ "</div>", [(tocLevel, name, id(PValue))])
  }
  | Type(typ) => {
    let link = Printf.sprintf({|<a href="#%s" id="%s">%s</a>|}, id(PType), id(PType), name);
    let t = printer.decl(printer, name, link, typ) |> prettyString;
    ("<h4 class='item'>" ++ String.trim(t) ++ "</h4>\n\n<div class='body " ++ (docstring == None ? "body-empty" : "") ++ "'>" ++ switch docstring {
    | None => skipDoc ? "" : "<span class='missing'>No documentation for this type</span>"
    | Some(doc) => Omd.to_html(Omd.of_string(doc))
    } ++ "</div>", [(tocLevel, name, id(PType))])
  }
  | StandaloneDoc(doc) => (Omd.to_html(Omd.of_string(doc)), [])
  };
  ("<div class='doc-item'>" ++ middle ++ "</div>", tocs)
}

and docsForModule = (~skipDoc=false, formatHref, stampsToPaths, path, tocLevel, name, main, contents) => {
  open Omd;
  let tocItems = ref([]);
  let addToc = item => tocItems := [item, ...tocItems^];
  let addTocs = items => tocItems := items @ tocItems^;
  let lastLevel = ref(0);

  let addHeader = (num, inner) => {
    lastLevel := num + 1;
    let id = cleanForLink(Omd.to_text(inner));
    let html = Omd.to_html(inner);
    addToc((tocLevel + num, html, id));
    Printf.sprintf({|<a href="#%s" id="%s"><h%d>%s</h%d></a>|}, id, id, num, html, num)
  };

  let html = Omd.of_string(main) |> Omd.to_html(~override=element => switch element {
  | H1(inner) => Some(addHeader(1, inner))
  | H2(inner) => Some(addHeader(2, inner))
  | H3(inner) => Some(addHeader(3, inner))
  | H4(inner) => Some(addHeader(4, inner))
  | H5(inner) => Some(addHeader(5, inner))
  /* Special replacements for @all and @doc */
  | Paragraph([Text(t)]) => {
    if (String.trim(t) == "@all") {
      Some((List.map(doc => {
        let (html, tocs) = generateDoc(~skipDoc, formatHref, stampsToPaths, path, tocLevel + lastLevel^, doc);
        addTocs(tocs);
        html
      }, List.rev(uniqueItems(contents))) |> String.concat("\n\n")) ++ "\n")
    } else if (Str.string_match(Str.regexp("^@doc [^\n]+"), t, 0)) {
      Some({
        let text = Str.matched_string(t);
        let raw = String.sub(text, 5, String.length(text) - 5);
        let items = Str.split(Str.regexp_string(","), raw) |> List.map(String.trim);
        items |> List.map(name => switch (findByName(contents, name)) {
        | None => "Invalid doc item referenced: " ++ name
        | Some(doc) => {
          let (html, tocs) = generateDoc(~skipDoc, formatHref, stampsToPaths, path, tocLevel + lastLevel^, doc);
          addTocs(tocs);
          html
        }
        }) |> String.concat("\n\n");
      })
    } else {
      None
    }
  }
  | _ => None
  });

  (html, tocItems^)
};
