
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

/* let module Awesomee =  Reason_toolchain.Reason_pprint_ast; */
/* let reasonFormatter = Reason.Reason_pprint_ast.createFormatter(); */

let isUpperCase = t => t >= 'A' && t <= 'Z';

let appendToPath = ((name, inner), items) => (name, inner @ items);

let rec processPath = (stampsToPaths, collector, path, ptype) => {
  switch path {
  | Path.Pident({name, stamp: 0}) => (name, collector, ptype)
  | Path.Pident({name, stamp}) => switch (List.assoc(stamp, stampsToPaths)) {
  | exception Not_found => ("<global>", [name], ptype)
  | (modName, inner, pp) => (modName, inner @ collector, ptype)
  }
  | Path.Pdot(inner, name, _) => processPath(stampsToPaths, collector @ [name], inner, PModule)
  | Papply(_, _) => assert(false)
  }
};

let printer = (formatHref, stampsToPaths) => {
  ...PrintType.default,
  path: (printer, path) => {
    let (@!) = Pretty.append;
    let fullPath = processPath(stampsToPaths, [], path, PType);
    let full = formatHref(fullPath);
    let show = name => {
      let tag = Printf.sprintf({|<a href="%s">%s</a>|}, full, name);
      Pretty.text(~len=String.length(name), tag)
    };
    switch path {
    | Pident({name}) => show(name)
    | Pdot(inner, name, _) => {
      printer.path(printer, inner) @! Pretty.text(".") @! show(name)}
    | Papply(_, _) => Pretty.text("<papply>")
    };
  }
};

let makeId = (items, ptype) => {
  open PrepareDocs.T;
  switch ptype {
  | PModule => "module-"
  | PType => "type-"
  | PValue => "value-"
  | PModuleType => "module-type-"
  } ++ String.concat(".", items)
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

let rec generateDoc = (formatHref, stampsToPaths, path, (name, docstring, content)) => {
  open PrepareDocs.T;
  let id = makeId(path @ [name]);
  switch content {
  | Module(items) => Printf.sprintf({|<h4 class='item module'> module <a href="#%s" id="%s">%s</a></h4><div class='body module-body'>|}, id(PModule), id(PModule), name) ++
  docsForModule(formatHref, stampsToPaths, path @ [name], name, switch docstring {
    | None => defaultMain(name)
    | Some(doc) => doc
    }, items) ++ "</div>"
  | Value(typ) => {
    let printer = printer(formatHref, stampsToPaths);
    let link = Printf.sprintf({|<a href="#%s" id="%s">%s</a>|}, id(PValue), id(PValue), name);
    let t = printer.value(printer, name, link, typ) |> prettyString;
    Printf.sprintf("<h4 class='item'>%s</h4>\n\n<div class='body '>", t)
     ++ switch docstring {
    | None => "<span class='missing'>No documentation for this value</span>"
    | Some(doc) => Omd.to_html(Omd.of_string(doc))
    } ++ "</div>"
  }
  | Type(typ) => {
    let link = Printf.sprintf({|<a href="#%s" id="%s">%s</a>|}, id(PType), id(PType), name);
    let printer = printer(formatHref, stampsToPaths);
    let t = printer.decl(printer, name, link, typ) |> prettyString;
    "<h4 class='item'>" ++ String.trim(t) ++ "</h4>\n\n<div class='body'>" ++ switch docstring {
    | None => "<span class='missing'>No documentation for this value</span>"
    | Some(doc) => Omd.to_html(Omd.of_string(doc))
    } ++ "</div>"
  }
  | StandaloneDoc(doc) => Omd.to_html(Omd.of_string(doc))
  }
}

and docsForModule = (formatHref, stampsToPaths, path, name, main, contents) => {
  let md = Omd.of_string(main);
  let html = Omd.to_html(md);

  let html = Str.global_substitute(Str.regexp_string("<p>@all</p>"), text => {
    List.map(generateDoc(formatHref, stampsToPaths, path), List.rev(contents)) |> String.concat("\n\n")
  }, html);

  let html = Str.global_substitute(Str.regexp("<p>@doc [^<]+</p>"), text => {
    let text = Str.matched_string(text);
    let raw = String.sub(text, 8, String.length(text) - 8 - 4);
    let items = Str.split(Str.regexp_string(","), raw) |> List.map(String.trim);
    items |> List.map(name => switch (findByName(contents, name)) {
    | None => failwith("Invalid doc item referenced: " ++ name)
    | Some(doc) => generateDoc(formatHref, stampsToPaths, path, doc)
    }) |> String.concat("\n\n");
  }, html);

  html
};


let head = name => Printf.sprintf({|
<!doctype html>
<meta charset=utf8>
<style>
body {
  font-family: system-ui;
  font-weight: 200;
  max-width: 600px;
  margin: 48px auto;
}
.body {
  margin-left: 24px;
  margin-bottom: 48px;
  line-height: 1.5em;
  font-size: 20px;
  letter-spacing: 1px;
}
.missing {
  font-style: italic;
  color: #777;
}
h1, h2 {
  margin-top: 24px;
}
h4.item {
  font-family: sf mono, monospace;
  font-weight: 400;
  padding-top: 8px;
  border-top: 1px solid #ddd;
  white-space: pre;
}
h4.module {
  font-size: 110%%;
  font-weight: 600;
}
.module-body {
  border-left: 5px solid #ddd;
  padding-left: 24px;
}

p code {
  padding: 1px 4px;
  background: #eee;
  border-radius: 3px;
  font-family: 'sf mono', monospace;
  font-size: 0.9em;
}

a {
  text-decoration: none;
}
a:hover, a:focus {
  text-decoration: underline;
}

</style>
<title>%s</title>
<body>
|}, name);