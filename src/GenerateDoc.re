
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

/* let appendToPath = ((name, inner), items) => (name, inner @ items); */

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

let rec generateDoc = (~skipDoc=false, formatHref, stampsToPaths, path, (name, docstring, content)) => {
  open PrepareDocs.T;
  let id = makeId(path @ [name]);
  let printer = printer(formatHref, stampsToPaths);
  "<div class='doc-item'>" ++
  switch content {
  | Module(items) => {
    open PrepareDocs.T;
    let (post, body) = switch items {
    | Items(items) =>
      ("", "<div class='body module-body'>" ++
      docsForModule(~skipDoc, formatHref, stampsToPaths, path @ [name], name, switch docstring {
        | None => defaultMain(name)
        | Some(doc) => doc
        }, items) ++ "</div>")
    | Alias(path) => {
      let t = printer.path(printer, path, PModule) |> prettyString;
      (" : " ++ t, switch docstring {
      | None => ""
      | Some(doc) => "<div class='body module-body'>" ++ Omd.to_html(Omd.of_string(doc)) ++ "</div>"
      })
    }
    };
    Printf.sprintf({|<h4 class='item module'> module <a href="#%s" id="%s">%s</a>%s</h4>%s|}, id(PModule), id(PModule), name, post, body)
  }
  | Include(maybePath, contents) => {
    /* TODO hyperlink the path */
    let name = switch maybePath {
    | None => ""
    | Some(path) => Path.name(path)
    };
    Printf.sprintf({|<h4 class='item module'> include %s</h4><div class='body module-body include-body'>|}, name) ++
    docsForModule(~skipDoc=true, formatHref, stampsToPaths, path, name, switch docstring {
    | None => "@all"
    | Some(doc) => doc
    }, contents) ++ "</div>"
  }
  | Value(typ) => {
    let link = Printf.sprintf({|<a href="#%s" id="%s">%s</a>|}, id(PValue), id(PValue), name);
    let t = printer.value(printer, name, link, typ) |> prettyString;
    Printf.sprintf("<h4 class='item'>%s</h4>\n\n<div class='body %s'>", t, docstring == None ? "body-empty" : "")
     ++ switch docstring {
    | None => skipDoc ? "" : "<span class='missing'>No documentation for this value</span>"
    | Some(doc) => Omd.to_html(Omd.of_string(doc))
    } ++ "</div>"
  }
  | Type(typ) => {
    let link = Printf.sprintf({|<a href="#%s" id="%s">%s</a>|}, id(PType), id(PType), name);
    let t = printer.decl(printer, name, link, typ) |> prettyString;
    "<h4 class='item'>" ++ String.trim(t) ++ "</h4>\n\n<div class='body " ++ (docstring == None ? "body-empty" : "") ++ "'>" ++ switch docstring {
    | None => skipDoc ? "" : "<span class='missing'>No documentation for this type</span>"
    | Some(doc) => Omd.to_html(Omd.of_string(doc))
    } ++ "</div>"
  }
  | StandaloneDoc(doc) => Omd.to_html(Omd.of_string(doc))
  } ++ "</div>"
}

and docsForModule = (~skipDoc=false, formatHref, stampsToPaths, path, name, main, contents) => {
  let html = Omd.of_string(main) |> Omd.to_html;

  let html = Str.global_substitute(Str.regexp_string("<p>@all</p>"), text => {
    List.map(generateDoc(~skipDoc, formatHref, stampsToPaths, path), List.rev(contents)) |> String.concat("\n\n")
  }, html);

  let html = Str.global_substitute(Str.regexp("<p>@doc [^<]+</p>"), text => {
    let text = Str.matched_string(text);
    let raw = String.sub(text, 8, String.length(text) - 8 - 4);
    let items = Str.split(Str.regexp_string(","), raw) |> List.map(String.trim);
    items |> List.map(name => switch (findByName(contents, name)) {
    | None => failwith("Invalid doc item referenced: " ++ name)
    | Some(doc) => generateDoc(~skipDoc, formatHref, stampsToPaths, path, doc)
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
.body-empty,
.include-body .body {
  margin-bottom: 16px;
}
.missing {
  font-style: italic;
  font-size: 16px;
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

.doc-item {
  font-size: 16px;
}

#error-message {
  display: none;
  background-color: #fde6e6;
  padding: 8px 16px;
  border-radius: 4px;
  box-shadow: 0px 1px 3px #d8a2a2;
  margin-bottom: 32px;
}

</style>
<script>
var checkHash = () => {
  var id = window.location.hash.slice(1)
  if (id && !document.getElementById(id)) {
    document.getElementById("error-message").style.display = 'block'
    var parts = id.split('-')
    document.querySelector('#error-message span').textContent = parts[0]
    document.querySelector('#error-message code').textContent = parts[1]
  }
}
window.onload = () => {
  checkHash()
}
window.onhashchange = checkHash
</script>
<title>%s</title>
<body>
<div id='error-message'>
  ⚠️ Oops! This page doesn't appear to define a <span>type</span> called <code>_</code>.
</div>
|}, name);