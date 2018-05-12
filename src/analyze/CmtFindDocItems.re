
open PrepareUtils;

/* module T = {
  type docItem =
    | Value(Types.type_expr)
    | Type(Types.type_declaration)
    | Module(moduleContents)
    | Include(option(Path.t), list(doc))
    | StandaloneDoc(Omd.t)
  and moduleContents =
    | Items(list(doc))
    | Alias(Path.t)
  and doc = (string, option(Omd.t), docItem);
}; */

open State.Model.Docs;

let rec iter = (fn, (name, docString, item) as doc) => {
  fn(doc);
  switch item {
  | Include(_, children) | Module(Items(children)) => List.iter(iter(fn), children)
  | _ => ()
  }
};

let rec docItemsFromTypes = (parseDoc, signature) => {
  open Types;
  List.fold_left((items, item) => switch item {
  | Sig_value({stamp, name}, {val_type, val_kind, val_attributes}) => [(name, findDocAttribute(parseDoc, val_attributes), Value(val_type)), ...items]
  | Sig_type({stamp, name}, decl, _) => [(name, findDocAttribute(parseDoc, decl.type_attributes), Type(decl)), ...items]
  | Sig_module({stamp, name}, {md_type, md_attributes, md_loc}, _) => [(name, findDocAttribute(parseDoc, md_attributes), Module(moduleContents(parseDoc, md_type)))]
  | _ => items
  }, [], signature);
} and moduleContents = (parseDoc, md_type) => {
  open Types;
  switch md_type {
  | Mty_ident(path) | Mty_alias(path) => Alias(path) /* TODO moduleContents */
  | Mty_signature(signature) => Items(docItemsFromTypes(parseDoc, signature))
  | Mty_functor(_, _, typ) => moduleContents(parseDoc, typ)
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

let rec docItemsFromStructure = (parseDoc, structure) => {
  open Typedtree;
  List.fold_left(((global, items), item) => switch (item.str_desc) {
  | Tstr_value(_, bindings) => foldOpt(({vb_loc, vb_expr, vb_pat, vb_attributes}) =>
    if (!hasNoDoc(vb_attributes)) {
      switch (vb_pat.pat_desc) {
      | Tpat_var(_, {Asttypes.txt}) => Some((txt, findDocAttribute(parseDoc, vb_attributes), Value(vb_pat.pat_type)))
      | _ => None
      }
    } else {None}
    , bindings, items) |> a => (global, a)
  | Tstr_primitive({val_name: {txt, loc}, val_val, val_attributes, val_loc}) => {
    if (!hasNoDoc(val_attributes)) {
      (global, [(txt, findDocAttribute(parseDoc, val_attributes), Value(val_val.val_type)), ...items])
    } else {(global, items)}
  }
  | Tstr_attribute(({Asttypes.txt: "ocaml.doc" | "ocaml.text"}, PStr([{pstr_desc: Pstr_eval({pexp_desc: Pexp_constant(Const_string(doc, _))}, _)}]))) => {
    let doc = cleanOffStars(doc) |> parseDoc;
    if (items == [] && global == None) {
      (Some(doc), [])
    } else {
      (global, [("", None, StandaloneDoc(doc)), ...items])
    }
  }
  | Tstr_include({incl_loc, incl_mod, incl_attributes, incl_type}) => {
    if (!hasNoDoc(incl_attributes)) {
      switch incl_mod.mod_desc {
      | Tmod_ident(path, _) => ((Path.name(path), findDocAttribute(parseDoc, incl_attributes), Include(Some(path), docItemsFromTypes(parseDoc, incl_type))))
      | _ => (("", findDocAttribute(parseDoc, incl_attributes), Include(None, docItemsFromTypes(parseDoc, incl_type))))
      } |> a => (global, [a, ...items])
    } else {(global, items)}
  }
  | Tstr_type(decls) => foldOpt(({typ_name: {txt}, typ_loc, typ_attributes, typ_type}) =>
    if (!hasNoDoc(typ_attributes)) {
      Some((txt, findDocAttribute(parseDoc, typ_attributes), Type(typ_type)))
    } else {None}, decls, items) |> a => (global, a)
  | Tstr_module({mb_attributes, mb_loc, mb_name: {txt}, mb_expr}) => {
    if (hasNoDoc(mb_attributes)) {
      (global, items)
    } else {
      let (docc, contents) = moduleContentsStr(parseDoc, mb_expr);
      (global, [(txt, either(docc, findDocAttribute(parseDoc, mb_attributes)), Module(contents)), ...items])
    }
  }
  | _ => (global, items)
  }, (None, []), structure);
}
and moduleContentsStr = (parseDoc, {Typedtree.mod_desc, mod_attributes, mod_loc}) => {
  open Typedtree;
  switch mod_desc {
  | Tmod_structure(structure) => {
    let (docc, contents) = docItemsFromStructure(parseDoc, structure.str_items);
    (docc, Items(contents))
  }
  | Tmod_constraint(mmod, mtyp, _, _) => {
    /* TODO this should probably be the mtyp. why? */
    moduleContentsStr(parseDoc, mmod)
    /* moduleContentsSig(mtyp, typesByLoc) */
  }
  | Tmod_ident(path, _) => (findDocAttribute(parseDoc, mod_attributes), Alias(path))
  | Tmod_functor(_, _, _, result) => moduleContentsStr(parseDoc, result) |> mapFst(either(findDocAttribute(parseDoc, mod_attributes)))
  | Tmod_apply(inner, _, _) => moduleContentsStr(parseDoc, inner) |> mapFst(either(findDocAttribute(parseDoc, mod_attributes)))
  | Tmod_unpack(_, typ) => (findDocAttribute(parseDoc, mod_attributes), moduleContentsType(parseDoc, typ))
  }
}
and moduleContentsType = (parseDoc, modtype) => Types.(switch modtype {
  | Mty_ident(path) | Mty_alias(path) => Alias(path)
  | Mty_functor(_, _, tt) => moduleContentsType(parseDoc, tt)
  | Mty_signature(sign) => Items(docItemsFromTypes(parseDoc, sign))
})

and docItemsFromSignature = (parseDoc, signature) => {
  open Typedtree;
  List.fold_left(((global, items), item) => switch (item.sig_desc) {
  | Tsig_value({val_name: {txt, loc}, val_val, val_attributes, val_loc}) =>
    if (!hasNoDoc(val_attributes)) {
      (global, [(txt, findDocAttribute(parseDoc, val_attributes), Value(val_val.val_type)), ...items])
    } else {(global, items)}
  | Tsig_attribute(({Asttypes.txt: "ocaml.doc" | "ocaml.text"}, PStr([{pstr_desc: Pstr_eval({pexp_desc: Pexp_constant(Const_string(doc, _))}, _)}]))) => {
    let doc = cleanOffStars(doc) |> parseDoc;
    if (items == [] && global == None) {
      (Some(doc), [])
    } else {
      (global, [("", None, StandaloneDoc(doc)), ...items])
    }
  }
  | Tsig_include({incl_loc, incl_mod, incl_attributes, incl_type}) => {
    if (!hasNoDoc(incl_attributes)) {
      switch incl_mod.mty_desc {
      | Tmty_ident(path, _) | Tmty_alias(path, _) => Some((Path.name(path), findDocAttribute(parseDoc, incl_attributes), Include(Some(path), docItemsFromTypes(parseDoc, incl_type))))
      | _ => Some(("", findDocAttribute(parseDoc, incl_attributes), Include(None, docItemsFromTypes(parseDoc, incl_type))))
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
      Some((txt, findDocAttribute(parseDoc, typ_attributes), Type(typ_type)))
    } else {None}, decls, items) |> a => (global, a)
  | Tsig_module({md_attributes, md_loc, md_name: {txt}, md_type: module_type}) => {
    if (hasNoDoc(md_attributes)) {
      (global, items)
    } else {
      let (docc, contents) = moduleContentsSig(parseDoc, module_type);
      (global, [(txt, either(docc, findDocAttribute(parseDoc, md_attributes)), Module(contents)), ...items])
    }
  }
  | _ => (global, items)
  }, (None, []), signature);
}
and moduleContentsSig = (parseDoc, {Typedtree.mty_desc, mty_attributes, mty_loc}) => {
  open Typedtree;
  switch mty_desc {
  | Tmty_signature(signature) => {
    let (docc, contents) = docItemsFromSignature(parseDoc, signature.sig_items);
    (docc, Items(contents))
  }
  | Tmty_alias(path, _) | Tmty_ident(path, _) => (findDocAttribute(parseDoc, mty_attributes), Alias(path))
  | Tmty_functor(_, _, _, result) => moduleContentsSig(parseDoc, result) |> mapFst(either(findDocAttribute(parseDoc, mty_attributes)))
  | Tmty_with(inner, _) => moduleContentsSig(parseDoc, inner) |> mapFst(either(findDocAttribute(parseDoc, mty_attributes)))
  | Tmty_typeof(modd)
    => assert(false)
  }
};