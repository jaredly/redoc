open Typedtree;

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

open PrepareUtils;

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

/* let rec findAllDocs = (structure) => {
  List.fold_left(((global, items), item) => {
    switch item.str_desc {
    | Tstr_attribute(({txt, loc}, PStr([{pstr_desc: Pstr_eval({pexp_desc: Pexp_constant(Const_string(doc, _))}, _)}]))) => {
      let doc = cleanOffStars(doc);
      if (global == None) {
        (Some(doc), items)
      } else {
        (global, [("", None, StandaloneDoc(doc)), ...items])
      }
    }
    | _ => {
      let extra = switch item.str_desc {
      | Tstr_value(_, bindings) => foldOpt(compose(
        ({vb_attributes}) => hasNoDoc(vb_attributes),
        ({vb_loc, vb_expr: {exp_type}, vb_pat, vb_attributes}) => {
          switch (vb_pat.pat_desc) {
          | Tpat_var({name, stamp}, _) => Some((name, findDocAttribute(vb_attributes), Value(vb_pat.pat_type)))
          | _ => None
          }
        }
      ))
      | Tstr_type(declarations) => List.map(({typ_id: {name, stamp}, typ_type, typ_attributes}) => {
      }, declarations)
      | _ => []
      };
      (global, extra @ items)
    }
    }
  })
}; */
