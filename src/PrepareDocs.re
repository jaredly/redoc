
open PrepareUtils;

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

let rec doubleFold = (fn, items) => {
  List.fold_left(((left, right), item) => {
    let (l, r) = fn(item);
    (l @ left, r @ right)
  }, ([], []), items)
};

let rec organizeTypesType = (currentPath, types) => {
  open Types;
  foldOpt(item => switch item {
  | Sig_value({stamp, name}, {val_type, val_kind}) => Some((stamp, addToPath(currentPath, name) |> toFullPath(PValue)))
  | Sig_type({stamp, name}, decl, _) => Some((stamp, addToPath(currentPath, name) |> toFullPath(PType)))
  | Sig_modtype({stamp, name}, _) => Some((stamp, addToPath(currentPath, name) |> toFullPath(PModule)))
  | _ => None
  }, types, [])
};

let rec organizeTypesIntf = (currentPath, types) => {
  open Typedtree;
  List.fold_left((items, item) => {
      let more = switch (item.sig_desc) {
      | Tsig_value({val_id: {stamp, name}}) => [(stamp, addToPath(currentPath, name) |> toFullPath(PValue))]
      | Tsig_type(decls) => List.map(({typ_id: {stamp, name}}) => (stamp, addToPath(currentPath, name) |> toFullPath(PType)), decls)
      | Tsig_include({incl_mod, incl_type}) => organizeTypesType(currentPath, incl_type)
      | Tsig_module({md_id: {stamp, name}, md_type: {mty_desc: Tmty_signature(signature)}}) => {
        let (stamps) = organizeTypesIntf(addToPath(currentPath, name), signature.sig_items);
        [(stamp, addToPath(currentPath, name) |> toFullPath(PModule)), ...stamps]
      }
      | Tsig_module({md_id: {stamp, name}}) => [(stamp, addToPath(currentPath, name) |> toFullPath(PModule))]
      | _ => []
      };
      more @ items
  }, [], types)
};

let rec organizeTypes = (currentPath, types) => {
  open Typedtree;
  List.fold_left((items, item) => {
      let more = switch (item.str_desc) {
      | Tstr_value(_rec, bindings) => (
        bindings |> filterNil(binding => switch binding {
        | {vb_pat: {pat_desc: Tpat_var({stamp, name}, _)}} => Some((stamp, addToPath(currentPath, name) |> toFullPath(PValue)))
        | _ => None
        }),
      )
      | Tstr_type(decls) => List.map(({typ_id: {stamp, name}}) => (stamp, addToPath(currentPath, name) |> toFullPath(PType)), decls)
      | Tstr_module({mb_id: {stamp, name}, mb_expr: {mod_type, mod_desc: Tmod_structure(structure) | Tmod_constraint({mod_desc: Tmod_structure(structure)}, _, _, _)}})
       => {
        let (stamps) = organizeTypes(addToPath(currentPath, name), structure.str_items);
        [(stamp, addToPath(currentPath, name) |> toFullPath(PModule)), ...stamps]
      }
      | Tstr_modtype({mtd_id: {stamp, name}, mtd_type: Some({mty_desc: Tmty_signature(signature), mty_type})}) => {
        let (stamps) = organizeTypesIntf(addToPath(currentPath, name), signature.sig_items);
        [(stamp, addToPath(currentPath, name) |> toFullPath(PModule)), ...stamps]
      }
      | Tstr_module({mb_id: {stamp, name}}) => [(stamp, addToPath(currentPath, name) |> toFullPath(PModule))]
      | Tstr_include({incl_loc, incl_mod, incl_attributes, incl_type}) => {
        organizeTypesType(currentPath, incl_type)
      }
      | _ => []
      };
      more @ items
  }, [], types)
};

let rec findAllDocsType = (signature) => {
  open Types;
  List.fold_left((items, item) => switch item {
  | Sig_value({stamp, name}, {val_type, val_kind, val_attributes}) => [(name, findDocAttribute(val_attributes), Value(val_type)), ...items]
  | Sig_type({stamp, name}, decl, _) => [(name, findDocAttribute(decl.type_attributes), Type(decl)), ...items]
  | Sig_module({stamp, name}, {md_type, md_attributes, md_loc}, _) => [(name, findDocAttribute(md_attributes), Module(moduleContents(md_type)))]
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

let rec findAllDocs = (structure) => {
  open Typedtree;
  List.fold_left(((global, items), item) => switch (item.str_desc) {
  | Tstr_value(_, bindings) => foldOpt(({vb_loc, vb_expr, vb_pat, vb_attributes}) =>
    if (!hasNoDoc(vb_attributes)) {
      switch (vb_pat.pat_desc) {
      | Tpat_var(_, {Asttypes.txt}) => Some((txt, findDocAttribute(vb_attributes), Value(vb_pat.pat_type)))
      | _ => None
      }
    } else {None}
    , bindings, items) |> a => (global, a)
  | Tstr_attribute(({Asttypes.txt: "ocaml.doc"}, PStr([{pstr_desc: Pstr_eval({pexp_desc: Pexp_constant(Const_string(doc, _))}, _)}]))) => {
    let doc = cleanOffStars(doc);
    if (items == [] && global == None) {
      (Some(doc), [])
    } else {
      (global, [("", None, StandaloneDoc(doc)), ...items])
    }
  }
  | Tstr_include({incl_loc, incl_mod, incl_attributes, incl_type}) => {
    if (!hasNoDoc(incl_attributes)) {
      switch incl_mod.mod_desc {
      | Tmod_ident(path, _) => ((Path.name(path), findDocAttribute(incl_attributes), Include(Some(path), findAllDocsType(incl_type))))
      | _ => (("", findDocAttribute(incl_attributes), Include(None, findAllDocsType(incl_type))))
      } |> a => (global, [a, ...items])
    } else {(global, items)}
  }
  | Tstr_type(decls) => foldOpt(({typ_name: {txt}, typ_loc, typ_attributes, typ_type}) =>
    if (!hasNoDoc(typ_attributes)) {
      Some((txt, findDocAttribute(typ_attributes), Type(typ_type)))
    } else {None}, decls, items) |> a => (global, a)
  /* | Pstr_module({pmb_attributes, pmb_loc, pmb_name: {txt}, pmb_expr: {pmod_desc: Pmod_constraint({pmod_desc: Pmod_structure(structure)}, _)}}) */
  | Tstr_module({mb_attributes, mb_loc, mb_name: {txt}, mb_expr}) => {
    if (hasNoDoc(mb_attributes)) {
      (global, items)
    } else {
      let (docc, contents) = moduleContentsStr(mb_expr);
      (global, [(txt, docc, Module(contents)), ...items])
    }
  }
  | _ => (global, items)
  }, (None, []), structure);
}
and moduleContentsStr = ({Typedtree.mod_desc, mod_attributes, mod_loc}) => {
  open Typedtree;
  switch mod_desc {
  | Tmod_structure(structure) => {
    let (docc, contents) = findAllDocs(structure.str_items);
    (docc, Items(contents))
  }
  | Tmod_constraint(mmod, mtyp, _, _) => {
    /* TODO this should probably be the mtyp. why? */
    moduleContentsStr(mmod)
    /* moduleContentsSig(mtyp, typesByLoc) */
  }
  | Tmod_ident(path, _) => (findDocAttribute(mod_attributes), Alias(path))
  | Tmod_functor(_, _, _, result) => moduleContentsStr(result) |> mapFst(either(findDocAttribute(mod_attributes)))
  | Tmod_apply(inner, _, _) => moduleContentsStr(inner) |> mapFst(either(findDocAttribute(mod_attributes)))
  | Tmod_unpack(_, typ) => (findDocAttribute(mod_attributes), moduleContentsType(typ))
  }
}
and moduleContentsType = (modtype) => Types.(switch modtype {
  | Mty_ident(path) | Mty_alias(path) => Alias(path)
  | Mty_functor(_, _, tt) => moduleContentsType(tt)
  | Mty_signature(sign) => Items(findAllDocsType(sign))
})

and findAllDocsIntf = (signature) => {
  open Typedtree;
  List.fold_left(((global, items), item) => switch (item.sig_desc) {
  | Tsig_value({val_name: {txt, loc}, val_val, val_attributes, val_loc}) =>
    if (!hasNoDoc(val_attributes)) {
      (global, [(txt, findDocAttribute(val_attributes), Value(val_val.val_type)), ...items])
    } else {(global, items)}
  | Tsig_attribute(({Asttypes.txt: "ocaml.doc"}, PStr([{pstr_desc: Pstr_eval({pexp_desc: Pexp_constant(Const_string(doc, _))}, _)}]))) => {
    if (items == [] && global == None) {
      (Some(doc), [])
    } else {
      (global, [("", None, StandaloneDoc(doc)), ...items])
    }
  }
  | Tsig_include({incl_loc, incl_mod, incl_attributes, incl_type}) => {
    if (!hasNoDoc(incl_attributes)) {
      switch incl_mod.mty_desc {
      | Tmty_ident(path, _) | Tmty_alias(path, _) => Some((Path.name(path), findDocAttribute(incl_attributes), Include(Some(path), findAllDocsType(incl_type))))
      | _ => Some(("", findDocAttribute(incl_attributes), Include(None, findAllDocsType(incl_type))))
      } |> a => switch a {
      | None => (global, items)
      | Some(item) => {
        (global, [item, ...items])
      }
      }
    } else {(global, items)}
  }
  | Tsig_type(decls) => foldOpt(({typ_name: {txt}, typ_loc, typ_attributes, typ_type}) =>
    if (!hasNoDoc(typ_attributes)) {
      Some((txt, findDocAttribute(typ_attributes), Type(typ_type)))
    } else {None}, decls, items) |> a => (global, a)
  | Tsig_module({md_attributes, md_loc, md_name: {txt}, md_type: module_type}) => {
    if (hasNoDoc(md_attributes)) {
      (global, items)
    } else {
      let (docc, contents) = moduleContentsSig(module_type);
      (global, [(txt, either(docc, findDocAttribute(md_attributes)), Module(contents)), ...items])
    }
  }
  | _ => (global, items)
  }, (None, []), signature);
}
and moduleContentsSig = ({Typedtree.mty_desc, mty_attributes, mty_loc}) => {
  open Typedtree;
  switch mty_desc {
  | Tmty_signature(signature) => {
    let (docc, contents) = findAllDocsIntf(signature.sig_items);
    (docc, Items(contents))
  }
  | Tmty_alias(path, _) | Tmty_ident(path, _) => (findDocAttribute(mty_attributes), Alias(path))
  | Tmty_functor(_, _, _, result) => moduleContentsSig(result) |> mapFst(either(findDocAttribute(mty_attributes)))
  | Tmty_with(inner, _) => moduleContentsSig(inner) |> mapFst(either(findDocAttribute(mty_attributes)))
  | Tmty_typeof(modd)
  /* => moduleContentsStr(modd) |> mapFst(either(findDocAttribute(mty_attributes))) */
    => assert(false)
  }
};