
open PrepareUtils;

let rec doubleFold = (fn, items) => {
  List.fold_left(((left, right), item) => {
    let (l, r) = fn(item);
    (l @ left, r @ right)
  }, ([], []), items)
};

module T = {
  type pathType = PrintType.pathType = PModule | PModuleType | PValue | PType;
  type docItem =
    | Value(Types.type_expr)
    | Type(Types.type_declaration)
    | Module(moduleContents)
    /* | ModType */
    | Include(option(Path.t), list(doc))
    /* | CompactModule(list(cdoc)) */
    | StandaloneDoc(string)
  and moduleContents =
    | Items(list(doc))
    | Alias(Path.t)
    /* | Ident */
  /* and compactItem =
    | CValue(Types.type_expr)
    | CModule(list(cdoc))
    | CType(Types.type_expr)
  and cdoc = (string, compactItem) */
  and doc = (string, option(string), docItem);

};
open T;

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
      | Tsig_module({md_id: {stamp, name}, md_loc, md_type: {mty_loc, mty_desc: Tmty_alias(path, _) | Tmty_ident(path, _), mty_type}}) => {
        ([], [(mty_loc, `ModuleAlias(path))])
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
      | Tstr_modtype({mtd_id: {stamp, name}, mtd_type: Some({mty_desc: Tmty_signature(signature), mty_type})}) => {
        let (stamps, typs) = organizeTypesIntf(addToPath(currentPath, name), signature.sig_items);
        ([(stamp, addToPath(currentPath, name) |> toFullPath(PModule)), ...stamps], typs)
      }
      | _ => ([], [])
      }
  }, types)
};

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
  | Mty_ident(path) | Mty_alias(path) => Alias(path) /* TODO moduleContents */
  | Mty_signature(signature) => Items(findAllDocsType(signature))
  | Mty_functor(_, _, typ) => moduleContents(typ)
  }
};

let either = (a, b) => switch (a, b) {
| (Some(a), _) => Some(a)
| (_, Some(b)) => Some(b)
| _ => None
};

let mapFst = (fn, (a, b)) => (fn(a), b);

let eitherFirst = (opt, (opt2, second)) => {
  (either(opt, opt2), second)
};

/* TODO maybe use the typedtree for this instead */

let rec findAllDocs = (structure, typesByLoc) => {
  open Parsetree;
  List.fold_left(((global, items), item) => switch (item.pstr_desc) {
  | Pstr_value(_, bindings) => foldOpt(({pvb_loc, pvb_expr, pvb_pat, pvb_attributes}) =>
    if (!hasNoDoc(pvb_attributes)) {
      switch (pvb_pat.ppat_desc) {
      | Ppat_var({Asttypes.txt}) => switch (List.assoc(pvb_loc, typesByLoc)) {
        | exception Not_found => {print_endline("Unable to find binding type for value by loc " ++ txt); None}
        | `Value(typ) => Some((txt, findDocAttribute(pvb_attributes), Value(typ)))
        | _ => {print_endline("Expected a value, not a type declaration"); None}
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
      | `Include(path, incl) => Some((switch pincl_mod.pmod_desc {
      | Pmod_ident({txt, loc}) => String.concat(".", Longident.flatten(txt))
      | _ => ""
      }, findDocAttribute(pincl_attributes), Include(path, findAllDocsType(incl))))
      | _ => {print_endline("expected include"); None}
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
      | `Type(typ) => Some((txt, findDocAttribute(ptype_attributes), Type(typ)))
      | _ => {print_endline("expected tyep, nto value"); None}
      }
    } else {None}, decls, items) |> a => (global, a)
  /* | Pstr_module({pmb_attributes, pmb_loc, pmb_name: {txt}, pmb_expr: {pmod_desc: Pmod_constraint({pmod_desc: Pmod_structure(structure)}, _)}}) */
  | Pstr_module({pmb_attributes, pmb_loc, pmb_name: {txt}, pmb_expr}) => {
    if (hasNoDoc(pmb_attributes)) {
      (global, items)
    } else {
      let (docc, contents) = moduleContentsStr(pmb_expr, typesByLoc);
      (global, [(txt, docc, Module(contents)), ...items])
    }
  }
  | _ => (global, items)
  }, (None, []), structure);
}
and moduleContentsStr = ({Parsetree.pmod_desc, pmod_attributes, pmod_loc}, typesByLoc) => {
  open Parsetree;
  switch pmod_desc {
  | Pmod_structure(structure) => {
    let (docc, contents) = findAllDocs(structure, typesByLoc);
    (docc, Items(contents))
  }
  | Pmod_constraint(mmod, mtyp) => {
    /* TODO this should probably be the mtyp. why? */
    moduleContentsStr(mmod, typesByLoc)
    /* moduleContentsSig(mtyp, typesByLoc) */
  }
  | Pmod_ident(_) => switch (List.assoc(pmod_loc, typesByLoc)) {
  | exception Not_found => (None, Items([]))
  | `ModuleAlias(path) => (findDocAttribute(pmod_attributes), Alias(path))
  | _ => (None, Items([]))
  }
  | Pmod_functor(_, _, result) => moduleContentsStr(result, typesByLoc)
  | Pmod_apply(inner, _) => moduleContentsStr(inner, typesByLoc)
  | Pmod_unpack(_) => (None, Items([]))
  | Pmod_extension(_) => assert(false)
  }
}

and findAllDocsIntf = (signature, typesByLoc) => {
  open Parsetree;
  List.fold_left(((global, items), item) => switch (item.psig_desc) {
  | Psig_value({pval_name: {txt, loc}, pval_type, pval_attributes, pval_loc}) =>
    if (!hasNoDoc(pval_attributes)) {
      switch (List.assoc(pval_loc, typesByLoc)) {
      | exception Not_found => {print_endline("Unable to find binding type for value by loc " ++ txt); (global, items)}
      | `Value(typ) => (global, [(txt, findDocAttribute(pval_attributes), Value(typ)), ...items])
      | _ => {print_endline("Expected a value, not a type declaration"); (global, items)}
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
      | `Include(path, incl) => Some((switch pincl_mod.pmty_desc {
        | Pmty_ident({txt, loc}) => String.concat(".", Longident.flatten(txt))
        | _ => ""
      }, findDocAttribute(pincl_attributes), Include(path, findAllDocsType(incl))))
      | _ => {print_endline("expected include"); None}
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
      | `Type(typ) => Some((txt, findDocAttribute(ptype_attributes), Type(typ)))
      | _ => {print_endline("expected tyep, nto value"); None}
      }
    } else {None}, decls, items) |> a => (global, a)
  | Psig_module({pmd_attributes, pmd_loc, pmd_name: {txt}, pmd_type: module_type}) => {
    if (hasNoDoc(pmd_attributes)) {
      (global, items)
    } else {
      let (docc, contents) = moduleContentsSig(module_type, typesByLoc);
      (global, [(txt, either(docc, findDocAttribute(pmd_attributes)), Module(contents)), ...items])
    }
  }
  | _ => (global, items)
  }, (None, []), signature);
}
and moduleContentsSig = ({Parsetree.pmty_desc, pmty_attributes, pmty_loc}, typesByLoc) => {
  open Parsetree;
  switch pmty_desc {
  | Pmty_signature(signature) => {
    let (docc, contents) = findAllDocsIntf(signature, typesByLoc);
    (docc, Items(contents))
  }
  | Pmty_alias(_) | Pmty_ident(_) => switch (List.assoc(pmty_loc, typesByLoc)) {
  | exception Not_found => (findDocAttribute(pmty_attributes), Items([]))
  | `ModuleAlias(path) => (findDocAttribute(pmty_attributes), Alias(path))
  | _ => (None, Items([]))
  }
  | Pmty_functor(_, _, result) => moduleContentsSig(result, typesByLoc) |> mapFst(either(findDocAttribute(pmty_attributes)))
  | Pmty_with(inner, _) => moduleContentsSig(inner, typesByLoc) |> mapFst(either(findDocAttribute(pmty_attributes)))
  | Pmty_typeof(modd) => moduleContentsStr(modd, typesByLoc) |> mapFst(either(findDocAttribute(pmty_attributes)))
  | Pmty_extension(_) => assert(false)
  }
};