
open Parsetree;

/* TODO should I hang on to location? */
let rec findDocAttribute = attributes => {
  switch attributes {
  | [] => None
  | [({Asttypes.txt: "ocaml.doc"}, PStr([{pstr_desc: Pstr_eval({pexp_desc: Pexp_constant(Const_string(doc, _))}, _)}])), ...rest] => Some(doc)
  | [_, ...rest] => findDocAttribute(rest)
  }
};

let rec hasNoDoc = attributes => {
  switch attributes {
  | [] => false
  | [({Asttypes.txt: "nodoc"}, _), ...rest] => true
  | [_, ...rest] => hasNoDoc(rest)
  }
};

let defaultMain = name => "<span class='missing'>This module does not have a toplevel documentation block.</span>\n\n@all";

type docItem = Value(Types.type_expr) | Type(Types.type_declaration) | Module(list(doc)) | StandaloneDoc(string)
and doc = (string, option(string), docItem);

let foldOpt = (fn, items, base) => List.fold_left((items, item) => switch (fn(item)) { | None => items | Some(x) => [x, ...items]}, base, items);

let rec findAllDocs = (structure, typesByLoc) => {
  open Parsetree;
  List.fold_left(((global, items), item) => switch (item.pstr_desc) {
  | Pstr_value(_, bindings) => foldOpt(({pvb_loc, pvb_expr, pvb_pat, pvb_attributes}) =>
    if (!hasNoDoc(pvb_attributes)) {
      switch (pvb_pat.ppat_desc) {
      | Ppat_var({Asttypes.txt}) => switch (List.assoc(pvb_loc, typesByLoc)) {
        | exception Not_found => {print_endline("Unable to find binding type for value by loc " ++ txt); None}
        | `Type(_) => {print_endline("Expected a value, not a type declaration"); None}
        | `Value(typ) => Some((txt, findDocAttribute(pvb_attributes), Value(typ)))
        }
      | _ => None
      }
    } else {None}
    , bindings, items) |> a => (global, a)
  | Pstr_attribute(({Asttypes.txt: "ocaml.doc"}, PStr([{pstr_desc: Pstr_eval({pexp_desc: Pexp_constant(Const_string(doc, _))}, _)}]))) => {
    if (items == [] && global == None) {
      (Some(doc), [])
    } else {
      (global, [("", None, StandaloneDoc(doc)), ...items])
    }
  }
  | Pstr_type(decls) => foldOpt(({ptype_name: {txt}, ptype_loc, ptype_attributes}) =>
    if (!hasNoDoc(ptype_attributes)) {
      switch (List.assoc(ptype_loc, typesByLoc)) {
      | exception Not_found => {print_endline("unable to find bindings type by loc " ++ txt); None}
      | `Value(_) => {print_endline("expected tyep, nto value"); None}
      | `Type(typ) => Some((txt, findDocAttribute(ptype_attributes), Type(typ)))
      }
    } else {None}, decls, items) |> a => (global, a)
  | Pstr_module({pmb_attributes, pmb_loc, pmb_name: {txt}, pmb_expr: {pmod_desc: Pmod_structure(structure)}}) => {
    if (hasNoDoc(pmb_attributes)) {
      (global, items)
    } else {
      let (docc, contents) = findAllDocs(structure, typesByLoc);
      (global, [(txt, docc, Module(contents)), ...items])
    }
  }
  | _ => (global, items)
  }, (None, []), structure);
};

let rec organizeTypes = types => {
  open Typedtree;
  List.fold_left(
    (typs, item) => {
      switch (item.str_desc) {
      | Tstr_value(_rec, bindings) => (
        List.map(({vb_loc, vb_expr: {exp_type}}) => (vb_loc, `Value(exp_type)), bindings) @ typs
      )
      | Tstr_type(decls) => List.map(({typ_type, typ_loc}) => (typ_loc, `Type(typ_type)), decls) @ typs
      | Tstr_module({mb_expr: {mod_type, mod_desc: Tmod_structure(structure)}}) => {
        organizeTypes(structure.str_items) @ typs
      }
      | _ => typs
      }
    },
    [],
    types
  )
};

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
let reasonFormatter = Reason.Reason_pprint_ast.createFormatter();

let printType = expr => {
  Printtyp.type_expr(Format.str_formatter, expr);
  Format.flush_str_formatter();
};

let rec generateDoc = (path, (name, docstring, content)) => {
  let id = String.concat(".", path @ [name]);
  switch content {
  | Module(items) => Printf.sprintf({|<h4 class='module'> module <a href="#module-%s" id="module-%s">%s</a></h4><div class='body module-body'>|}, id, id, name) ++
  docsForModule(path, name, switch docstring {
    | None => defaultMain(name)
    | Some(doc) => doc
    }, items) ++ "</div>"
  | Value(typ) => {
    Printtyp.type_expr(Format.str_formatter, typ);
    let t = Format.flush_str_formatter();
    Printf.sprintf({| <h4> let <a href="#value-%s" id="value-%s">%s</a> : %s </h4> |}, id, id, name, String.trim(t)) ++ "\n\n<div class='body '>" ++ switch docstring {
    | None => "<span class='missing'>No documentation for this value</span>"
    | Some(doc) => Omd.to_html(Omd.of_string(doc))
    } ++ "</div>"
  }
  | Type(typ) => {
    Printtyp.type_declaration({Ident.name, stamp: 0, flags: 0}, Format.str_formatter, typ);
    let t = Format.flush_str_formatter();
    let link = Printf.sprintf({|<a href="#type-%s" id="type-%s">%s</a>|}, id, id, name);
    let t = Str.replace_first(Str.regexp_string(name), link, t);
    /* TODO parse out the (name) so I can highlight it n stuff */
    "<h4>" ++ String.trim(t) ++ "</h4>\n\n<div class='body'>" ++ switch docstring {
    | None => "<span class='missing'>No documentation for this value</span>"
    | Some(doc) => Omd.to_html(Omd.of_string(doc))
    } ++ "</div>"
  }
  | StandaloneDoc(doc) => Omd.to_html(Omd.of_string(doc))
  }
}

and docsForModule = (path, name, main, contents) => {
  let childPath = path @ [name];
  let md = Omd.of_string(main);
  let html = Omd.to_html(md);

  let html = Str.global_substitute(Str.regexp_string("<p>@all</p>"), text => {
    List.map(generateDoc(childPath), List.rev(contents)) |> String.concat("\n\n")
  }, html);

  let html = Str.global_substitute(Str.regexp("<p>@doc [^<]+</p>"), text => {
    let text = Str.matched_string(text);
    let raw = String.sub(text, 8, String.length(text) - 8 - 4);
    let items = Str.split(Str.regexp_string(","), raw) |> List.map(String.trim);
    items |> List.map(name => switch (findByName(contents, name)) {
    | None => failwith("Invalid doc item referenced: " ++ name)
    | Some(doc) => generateDoc(childPath, doc)
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
}
h4.module {
  font-size: 110%%;
  font-weight: 600;
}
.module-body {
  border-left: 5px solid #ddd;
  padding-left: 24px;
}

</style>
<title>%s</title>
<body>
|}, name);

let generate = (name, structure, types) => {
  let types = switch types {
  | Cmt_format.Implementation(structure) => structure.Typedtree.str_items
  | _ => failwith("Not a valid cmt file")
  };

  let typesByLoc = organizeTypes(types);
  let (toplevel, allDocs) = findAllDocs(structure, typesByLoc);
  let mainMarkdown = switch (toplevel) {
  | None => defaultMain(name)
  | Some(doc) => doc
  };

  head(name) ++
  docsForModule([], name, mainMarkdown, allDocs)
};
