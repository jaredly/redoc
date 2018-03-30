
open Parsetree;

/* TODO should I hang on to location? */
let rec findDocAttribute = attributes => {
  switch attributes {
  | [] => None
  | [({Asttypes.txt: "ocaml.doc"}, PStr([{pstr_desc: Pstr_eval({pexp_desc: Pexp_constant(Const_string(doc, _))}, _)}])), ...rest] => Some(doc)
  | [_, ...rest] => findDocAttribute(rest)
  }
};

let rec findMainDoc = (structure) => {
  switch structure {
  | [] => None
  | [{pstr_desc: Pstr_attribute(({txt: "ocaml.doc"}, PStr([{pstr_desc: Pstr_eval({pexp_desc: Pexp_constant(Const_string(doc, _))}, _)}])))}, ...rest] => Some(doc)
  | [{pstr_desc: Pstr_value(_)}, ..._] => None
  | [item, ...rest] => findMainDoc(rest)
  }
};

let defaultMain = name => "# " ++ name ++ "\n\nThis module does not have a toplevel documentation block.\n\n@all";

type docItem = Value(Types.type_desc) | Type(Types.type_declaration) | Module(list(doc)) | StandaloneDoc(string)
and doc = (string, option(string), docItem);

let foldOpt = (fn, items, base) => List.fold_left((items, item) => switch (fn(item)) { | None => items | Some(x) => [x, ...items]}, base, items);

let rec findAllDocs = (structure, typesByLoc) => {
  open Parsetree;
  List.fold_left((items, item) => switch (item.pstr_desc) {
  | Pstr_value(_, bindings) => foldOpt(({pvb_loc, pvb_expr, pvb_pat, pvb_attributes}) =>
    switch (pvb_pat.ppat_desc) {
    | Ppat_var({Asttypes.txt}) => switch (List.assoc(pvb_loc, typesByLoc)) {
      | exception Not_found => {print_endline("Unable to find binding type by loc"); None}
      | `Type(_) => {print_endline("Expected a value, not a type declaration"); None}
      | `Value(typ) => Some((txt, findDocAttribute(pvb_attributes), Value(typ)))
      }
    | _ => None
    }, bindings, items)
  | Pstr_attribute(({Asttypes.txt: "ocaml.doc"}, PStr([{pstr_desc: Pstr_eval({pexp_desc: Pexp_constant(Const_string(doc, _))}, _)}]))) => {
    [("", None, StandaloneDoc(doc)), ...items]
  }
  | Pstr_type(decls) => foldOpt(({ptype_name: {txt}, ptype_loc, ptype_attributes}) =>
    switch (List.assoc(ptype_loc, typesByLoc)) {
    | exception Not_found => {print_endline("unable to find bindings type by loc"); None}
    | `Value(_) => {print_endline("expected tyep, nto value"); None}
    | `Type(typ) => Some((txt, findDocAttribute(ptype_attributes), Type(typ)))
    }, decls, items)
  | Pstr_module({pmb_attributes, pmb_loc, pmb_name: {txt}, pmb_expr: {pmod_desc: Pmod_structure(structure)}}) => {
    [(txt, findDocAttribute(pmb_attributes), Module(findAllDocs(structure, typesByLoc))), ...items]
  }
  | _ => items
  }, [], structure);
};

let generateDoc = doc => "";

let rec organizeTypes = types => {
  open Typedtree;
  List.fold_left(
    (typs, item) => {
      switch (item.str_desc) {
      | Tstr_value(_rec, bindings) => (
        List.map(({vb_loc, vb_expr: {exp_type: {desc}}}) => (vb_loc, `Value(desc)), bindings) @ typs
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

let generate = (name, structure, types) => {
  let mainMarkdown = switch (findMainDoc(structure)) {
  | None => defaultMain(name)
  | Some(doc) => doc
  };
  let types = switch types {
  | Cmt_format.Implementation(structure) => structure.Typedtree.str_items
  | _ => failwith("Not a valid cmt file")
  };

  let typesByLoc = organizeTypes(types);

  let allDocs = findAllDocs(structure, typesByLoc);

  let mainMarkdown = Str.global_substitute(Str.regexp_string("\n@all\n"), text => {
    "\nNOPE" /* OK have to get the things now */
  }, mainMarkdown);
  let mainMarkdown = Str.global_substitute(Str.regexp_string("\n@doc [\n]+"), text => {
    let raw = String.sub(text, 6, String.length(text) - 6);
    let items = Str.split(Str.regexp_string(","), raw) |> List.map(String.trim);
    items |> List.map(name => switch (findByName(allDocs, name)) {
    | None => failwith("Invalid doc item referenced: " ++ name)
    | Some(doc) => generateDoc(doc)
    }) |> String.concat("\n\n");
  }, mainMarkdown);
  mainMarkdown
};
