
open Parsetree;

let rec findMainDoc = (structure) => {
  switch structure {
  | [] => None
  | [{pstr_desc: Pstr_attribute(({txt: "ocaml.doc"}, PStr([{pstr_desc: Pstr_eval({pexp_desc: Pexp_constant(Const_string(doc, _))}, _)}])))}, ...rest] => Some(doc)
  | [{pstr_desc: Pstr_value(_)}, ..._] => None
  | [item, ...rest] => findMainDoc(rest)
  }
};

let defaultMain = name => "# " ++ name ++ "\n\nThis module does not have a toplevel documentation block.\n\n@all";

/* type doc('a) = Value('a) | Type('a) | Module(list((string, doc('a)))); */

type docItem = Value(Types.type_desc) | Type(Types.type_declaration) | Module(list(doc))
and doc = (string, option(string), docItem);

let findAllDocs = (structure, valueTypes, typeTypes) => [];

let generateDoc = doc => "";

let rec organizeTypes = types => {
  open Typedtree;
  List.fold_left(
    ((vals, typs), item) => {
      switch (item.str_desc) {
      | Tstr_value(_rec, bindings) => (
        (List.map(({vb_loc, vb_expr: {exp_type}}) => (vb_loc, exp_type), bindings) @ vals, typs)
      )
      | Tstr_type(decls) => (vals, List.map(({typ_type, typ_loc}) => (typ_loc, typ_type), decls) @ typs)
      | Tstr_module({mb_expr: {mod_type, mod_desc: Tmod_structure(structure)}}) => {
        let (a, b) = organizeTypes(structure.str_items);
        (a @ vals, b @ typs)
      }
      | _ => (vals, typs)
      }
    },
    ([], []),
    types
  )
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

  let (valueTypes, typeTypes) = organizeTypes(types);

  let docsByName = findAllDocs(structure, valueTypes, typeTypes);

  let mainMarkdown = Str.global_substitute(Str.regexp_string("\n@all\n"), text => {
    "\nNOPE" /* OK have to get the things now */
  }, mainMarkdown);
  let mainMarkdown = Str.global_substitute(Str.regexp_string("\n@doc [\n]+"), text => {
    let raw = String.sub(text, 6, String.length(text) - 6);
    let items = Str.split(Str.regexp_string(","), raw) |> List.map(String.trim);
    items |> List.map(item => switch (List.assoc(item, docsByName)) {
    | exception Not_found => failwith("Invalid doc item referenced: " ++ item)
    | doc => generateDoc(doc)
    }) |> String.concat("\n\n");
    /* "\nNOPE doc"  */
    /* OK have to get the things now */
  }, mainMarkdown);
  mainMarkdown
};
