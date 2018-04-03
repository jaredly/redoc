
let rec doubleFold = (fn, items) => {
  List.fold_left(((left, right), item) => {
    let (l, r) = fn(item);
    (l @ left, r @ right)
  }, ([], []), items)
};

let addToPath = ((name, inner), more) => (name, inner @ [more]);
module T = {
  type pathType = PrintType.pathType = PModule | PModuleType | PValue | PType;
  type docItem =
    | Value(Types.type_expr)
    | Type(Types.type_declaration)
    | Module(list(doc))
    /* | ModType */
    | Include(option(Path.t), list(doc))
    /* | CompactModule(list(cdoc)) */
    | StandaloneDoc(string)
  and moduleContents =
    | Items(list(doc))
    | Alias(Path.t)
    | Ident
  /* and compactItem =
    | CValue(Types.type_expr)
    | CModule(list(cdoc))
    | CType(Types.type_expr)
  and cdoc = (string, compactItem) */
  and doc = (string, option(string), docItem);

};
open T;
let toFullPath = (pathType, (name, inner)) => (name, inner, pathType);

let filterNil = (fn, items) => List.fold_left(
  (items, item) => switch (fn(item)) {
  | None => items
  | Some(item) => [item, ...items]
  },
  [],
  items
);

let rec organizeTypesType = (currentPath, types) => {
  open Types;
  doubleFold(item => switch item {
  | Sig_value({stamp, name}, {val_type, val_kind, val_attributes}) => {
    /* TODO list out the attributes, see if the docs are there */
    ([(stamp, addToPath(currentPath, name) |> toFullPath(PValue))],
    [(Location.none, `Value(val_type))]
    )
  }
  | _ => ([], [])
  }, types)
};

let rec organizeTypesIntf = (currentPath, types) => {
  open Typedtree;
  doubleFold(item => {
      switch (item.sig_desc) {
      | Tsig_value({val_id: {stamp, name}, val_loc, val_val: {val_type}}) => (
        (
        [(stamp, addToPath(currentPath, name) |> toFullPath(PValue))],
        [(val_loc, `Value(val_type))]
        )
      )
      | Tsig_type(decls) => (
        List.map(({typ_id: {stamp, name}}) => (stamp, addToPath(currentPath, name) |> toFullPath(PType)), decls),
        List.map(({typ_type, typ_loc}) => (typ_loc, `Type(typ_type)), decls),
      )
      | Tsig_include({incl_loc, incl_mod, incl_type}) => {
        let (stamps, typs) = organizeTypesType(currentPath, incl_type);
        let path = switch incl_mod.mty_desc {
        | Tmty_ident(path, _) | Tmty_alias(path, _) => Some(path)
        | _ => None
        };
        (stamps, [(incl_loc, `Include(path, incl_type)), ...typs])
      }
      | Tsig_module({md_id: {stamp, name}, md_type: {mty_desc: Tmty_signature(signature), mty_type}}) => {
        let (stamps, typs) = organizeTypesIntf(addToPath(currentPath, name), signature.sig_items);
        ([(stamp, addToPath(currentPath, name) |> toFullPath(PModule)), ...stamps], typs)
      }
      | _ => ([], [])
      }
  }, types)
};

let rec organizeTypes = (currentPath, types) => {
  open Typedtree;
  doubleFold(item => {
      switch (item.str_desc) {
      | Tstr_value(_rec, bindings) => (
        bindings |> filterNil(binding => switch binding {
        | {vb_pat: {pat_desc: Tpat_var({stamp, name}, _)}} => Some((stamp, addToPath(currentPath, name) |> toFullPath(PValue)))
        | _ => None
        }),
        List.map(({vb_loc, vb_expr: {exp_type}}) => (vb_loc, `Value(exp_type)), bindings),
      )
      | Tstr_type(decls) => (
          List.map(({typ_id: {stamp, name}}) => (stamp, addToPath(currentPath, name) |> toFullPath(PType)), decls),
          List.map(({typ_type, typ_loc}) => (typ_loc, `Type(typ_type)), decls),
      )
      | Tstr_module({mb_id: {stamp, name}, mb_expr: {mod_type, mod_desc: Tmod_structure(structure)}})
      | Tstr_module({mb_id: {stamp, name}, mb_expr: {mod_type, mod_desc: Tmod_constraint({mod_desc: Tmod_structure(structure)}, _, _, _)}})
       => {
        let (stamps, typs) = organizeTypes(addToPath(currentPath, name), structure.str_items);
        ([(stamp, addToPath(currentPath, name) |> toFullPath(PModule)), ...stamps], typs)
      }
      /* | Tstr_module({mb_id: {stamp, name}, mb_expr: {mod_type, mod_desc: Tmod_constraint(_, _, _, _)}}) => {
        let (stamps, typs) = organizeTypes(addToPath(currentPath, name), structure.str_items);
        ([(stamp, addToPath(currentPath, name) |> toFullPath(PModule)), ...stamps], typs)
      } */
      | Tstr_modtype({mtd_id: {stamp, name}, mtd_type: Some({mty_desc: Tmty_signature(signature), mty_type})}) => {
        let (stamps, typs) = organizeTypesIntf(addToPath(currentPath, name), signature.sig_items);
        ([(stamp, addToPath(currentPath, name) |> toFullPath(PModule)), ...stamps], typs)
      }
      | _ => ([], [])
      }
  }, types)
};

let findStars = line => {
  let l = String.length(line);
  let rec loop = i => {
    if (i >= l - 1) {
      None
    } else if (line.[i] == '*' && line.[i + 1] == ' ') {
      Some(i + 1)
    } else {
      loop(i + 1)
    }
  };
  loop(0)
};

let combine = (one, two) => switch (one, two) {
| (None, None) => None
| (Some(a), None) => Some(a)
| (None, Some(b)) => Some(b)
| (Some(a), Some(b)) => a == b ? Some(a) : Some(0)
};

let trimFirst = (num, string) => {
  let length = String.length(string);
  length > num ? String.sub(string, num, length - num) : string
};

let cleanOffStars = doc => {
  let lines = Str.split(Str.regexp_string("\n"), doc);
  let rec loop = (first, lines) => {
    switch lines {
    | [] => None
    | [one] => (first || String.trim(one) == "") ? None : findStars(one)
    | [one, ...rest] => (first || String.trim(one) == "") ? loop(false, rest) : combine(findStars(one), loop(false, rest))
    }
  };
  let num = loop(true, lines);
  switch num {
  | None | Some(0) => doc
  | Some(num) => switch lines {
    | [] | [_] => doc
    | [one, ...rest] => one ++ "\n" ++ String.concat("\n", rest |> List.map(trimFirst(num)))
    }
  }
};

/* TODO should I hang on to location? */
let rec findDocAttribute = attributes => {
  open Parsetree;
  switch attributes {
  | [] => None
  | [({Asttypes.txt: "ocaml.doc"}, PStr([{pstr_desc: Pstr_eval({pexp_desc: Pexp_constant(Const_string(doc, _))}, _)}])), ...rest] => Some(cleanOffStars(doc))
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

let foldOpt = (fn, items, base) => List.fold_left((items, item) => switch (fn(item)) { | None => items | Some(x) => [x, ...items]}, base, items);

let rec findAllDocsType = (signature) => {
  open Types;
  List.fold_left((items, item) => switch item {
  | Sig_value({stamp, name}, {val_type, val_kind, val_attributes}) => {
    [(name, findDocAttribute(val_attributes), Value(val_type)), ...items]
  }
  | Sig_type({stamp, name}, decl, _) => {
    [(name, findDocAttribute(decl.type_attributes), Type(decl)), ...items]
  }
  | Sig_module({stamp, name}, {md_type, md_attributes, md_loc}, _) => {
    let contents = moduleContents(md_type);
    [(name, findDocAttribute(md_attributes), Module(contents))]
  }
  | _ => items
  }, [], signature);
} and moduleContents = md_type => {
  open Types;
  switch md_type {
  | Mty_ident(path) | Mty_alias(path) => [] /* TODO moduleContents */
  | Mty_signature(signature) => findAllDocsType(signature)
  | Mty_functor(_, _, typ) => moduleContents(typ)
  }
};

let rec findAllDocs = (structure, typesByLoc) => {
  open Parsetree;
  List.fold_left(((global, items), item) => switch (item.pstr_desc) {
  | Pstr_value(_, bindings) => foldOpt(({pvb_loc, pvb_expr, pvb_pat, pvb_attributes}) =>
    if (!hasNoDoc(pvb_attributes)) {
      switch (pvb_pat.ppat_desc) {
      | Ppat_var({Asttypes.txt}) => switch (List.assoc(pvb_loc, typesByLoc)) {
        | exception Not_found => {print_endline("Unable to find binding type for value by loc " ++ txt); None}
        | `Include(_, _) | `Type(_) => {print_endline("Expected a value, not a type declaration"); None}
        | `Value(typ) => Some((txt, findDocAttribute(pvb_attributes), Value(typ)))
        }
      | _ => None
      }
    } else {None}
    , bindings, items) |> a => (global, a)
  | Pstr_attribute(({Asttypes.txt: "ocaml.doc"}, PStr([{pstr_desc: Pstr_eval({pexp_desc: Pexp_constant(Const_string(doc, _))}, _)}]))) => {
    let doc = cleanOffStars(doc);
    if (items == [] && global == None) {
      (Some(doc), [])
    } else {
      (global, [("", None, StandaloneDoc(doc)), ...items])
    }
  }
  | Pstr_include({pincl_loc, pincl_mod, pincl_attributes}) => {
    if (!hasNoDoc(pincl_attributes)) {
      switch (List.assoc(pincl_loc, typesByLoc)) {
      | exception Not_found => {print_endline("unable to find binding for include"); None}
      | `Type(_) | `Value(_) => {print_endline("expected include"); None}
      | `Include(path, incl) => Some((switch pincl_mod.pmod_desc {
      | Pmod_ident({txt, loc}) => String.concat(".", Longident.flatten(txt))
      | _ => ""
      }, findDocAttribute(pincl_attributes), Include(path, findAllDocsType(incl))))
      } |> a => switch a {
      | None => (global, items)
      | Some(item) => (global, [item, ...items])
      }
    } else {(global, items)}
  }
  | Pstr_type(decls) => foldOpt(({ptype_name: {txt}, ptype_loc, ptype_attributes}) =>
    if (!hasNoDoc(ptype_attributes)) {
      switch (List.assoc(ptype_loc, typesByLoc)) {
      | exception Not_found => {print_endline("unable to find bindings type by loc " ++ txt); None}
      | `Include(_) | `Value(_) => {print_endline("expected tyep, nto value"); None}
      | `Type(typ) => Some((txt, findDocAttribute(ptype_attributes), Type(typ)))
      }
    } else {None}, decls, items) |> a => (global, a)
  | Pstr_module({pmb_attributes, pmb_loc, pmb_name: {txt}, pmb_expr: {pmod_desc: Pmod_constraint({pmod_desc: Pmod_structure(structure)}, _)}})
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

let rec findAllDocsIntf = (signature, typesByLoc) => {
  open Parsetree;
  List.fold_left(((global, items), item) => switch (item.psig_desc) {
  | Psig_value({pval_name: {txt, loc}, pval_type, pval_attributes, pval_loc}) =>
    if (!hasNoDoc(pval_attributes)) {
      switch (List.assoc(pval_loc, typesByLoc)) {
      | exception Not_found => {print_endline("Unable to find binding type for value by loc " ++ txt); (global, items)}
      | `Include(_) | `Type(_) => {print_endline("Expected a value, not a type declaration"); (global, items)}
      | `Value(typ) => (global, [(txt, findDocAttribute(pval_attributes), Value(typ)), ...items])
      }
    } else {(global, items)}
  | Psig_attribute(({Asttypes.txt: "ocaml.doc"}, PStr([{pstr_desc: Pstr_eval({pexp_desc: Pexp_constant(Const_string(doc, _))}, _)}]))) => {
    if (items == [] && global == None) {
      (Some(doc), [])
    } else {
      (global, [("", None, StandaloneDoc(doc)), ...items])
    }
  }
  | Psig_include({pincl_loc, pincl_mod, pincl_attributes}) => {
    if (!hasNoDoc(pincl_attributes)) {
      switch (List.assoc(pincl_loc, typesByLoc)) {
      | exception Not_found => {print_endline("unable to find binding for include"); None}
      | `Type(_) | `Value(_) => {print_endline("expected include"); None}
      | `Include(path, incl) => Some((switch pincl_mod.pmty_desc {
        | Pmty_ident({txt, loc}) => String.concat(".", Longident.flatten(txt))
        | _ => ""
      }, findDocAttribute(pincl_attributes), Include(path, findAllDocsType(incl))))
      } |> a => switch a {
      | None => (global, items)
      | Some(item) => {
        (global, [item, ...items])
      }
      }
    } else {(global, items)}
  }
  | Psig_type(decls) => foldOpt(({ptype_name: {txt}, ptype_loc, ptype_attributes}) =>
    if (!hasNoDoc(ptype_attributes)) {
      switch (List.assoc(ptype_loc, typesByLoc)) {
      | exception Not_found => {print_endline("unable to find bindings type by loc " ++ txt); None}
      | `Include(_, _) | `Value(_) => {print_endline("expected tyep, nto value"); None}
      | `Type(typ) => Some((txt, findDocAttribute(ptype_attributes), Type(typ)))
      }
    } else {None}, decls, items) |> a => (global, a)
  | Psig_module({pmd_attributes, pmd_loc, pmd_name: {txt}, pmd_type: {pmty_desc: Pmty_signature(signature)}}) => {
    if (hasNoDoc(pmd_attributes)) {
      (global, items)
    } else {
      let (docc, contents) = findAllDocsIntf(signature, typesByLoc);
      (global, [(txt, docc, Module(contents)), ...items])
    }
  }
  | _ => (global, items)
  }, (None, []), signature);
};