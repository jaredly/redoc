
/**
 * Two ways to identify a given value:
 * its stamp.
 * it's parent (current path)'s stamp.
 * from that, I think we'll be able to work all the things out.
 *
 * oh but there are also different scopes folks.
 *
 * A given module can have:
 * - types
 * - values
 * - modules
 * - module types
 */

/**
 * What do I even want on the other end?
 *
 * blocks of code, linked to each other.
 * oh I also want collapsing of things. that would be cool.
 *
 *
 * Give each thing a unique ID.
 * the paths are a way of accessing that ID
 *
 * also I don't really care about what open a thing came from. It's fine.
*/

/* let rec chart = (addItem, types) => {
  open Typedtree;
  List.fold_left((items, item) => {
      let more = switch (item.str_desc) {
      | Tstr_value(recc, bindings) => (
        bindings |> filterNil(binding => switch binding {
        | {vb_pat: {pat_desc: Tpat_var({stamp, name}, _)}} => {
          addItem(stamp, name, {...item, str_desc: Tstr_value(recc, [binding])})
          Some((stamp, Value(name)))
        }
        | _ => None
        }),
      )
      | Tstr_type(decls) => List.map(({typ_id: {stamp, name}} as decl) => {
        addItem(stamp, name, {...item, str_desc: Tstr_type([decl])});
        (stamp, Type(name))
      }, decls)
      | Tstr_module({mb_id: {stamp, name}, mb_expr: {
        mod_type,
        mod_desc: Tmod_structure(structure) | Tmod_constraint({mod_desc: Tmod_structure(structure)}, _, _, _)
      }}) => {
        /* TODO do I need to record modules as such? */
        let children = chart(addItem, structure.str_items);
        [(stamp, Module(name, children))]
      }
      | _ => []
      };
      more @ items
  }, [], types)
}; */

/**

What I really want.

type nodes = {
  [id: int]: {
    text: string, /* has a tags that are <a data-target-id="10"> </a> */
    dependsOn: list(int),
  }
}

What needs to be solved for this to happen?
- currently type & value refs come as paths, I need to resolve those paths to the stamp declaration.
- for PIdents that's easy
- maybe start with that, get fancy later

 */

let filterNil = (fn, items) => List.fold_left(
  (items, item) => switch (fn(item)) {
  | None => items
  | Some(item) => [item, ...items]
  },
  [],
  items
);


type tag =
  | TypeHover(Types.type_expr)
  | Cls(string)
  /* | Define(int) */
  | TypeDef(Ident.t)
  | ValueDef(Ident.t)
  | TypeRef(Path.t)
  | ValueRef(Path.t);

let iterTags = (addTag) => {
  /* Hmmm Ok I think I want to handle TypeRef & TypeDef internally too, so I know what's an external reference? */
  let addColor = (loc, className) => addTag(loc, [Cls(className)]);
  let addColorType = (loc, className, typ) => addTag(loc, [Cls(className), TypeHover(typ)]);
  let addType = (loc, typ) => addTag(loc, [TypeHover(typ)]);
  /* TODO report types with all of this probably? */
  let module Iter = {
    open Typedtree;
    include TypedtreeIter.DefaultIteratorArgument;
    let enter_expression = ({exp_desc, exp_loc, exp_type}) => {
      let addColorT = (loc, cls) => addTag(loc, [Cls(cls), TypeHover(exp_type)]);
      switch exp_desc {
      /* TODO dive into the longident */
      | Texp_ident(path, {txt: Lident(text), loc}, _) when !(text.[0] >= 'a' && text.[0] <= 'z') => {
        addTag(loc, [Cls("operator"), TypeHover(exp_type), ValueRef(path)])
      }
      | Texp_ident(path, {txt, loc}, _) => {
        addTag(loc, [Cls("ident"), TypeHover(exp_type), ValueRef(path)])
      }
      | Texp_constant(Const_int(_)) => addColorT(exp_loc, "int")
      | Texp_constant(Const_float(_)) => addColorT(exp_loc, "float")
      | Texp_constant(Const_string(content, tag)) => {
        let expectedMaxSize = switch tag {
        | None => String.length(String.escaped(content)) + 2
        | Some(tag) => String.length(String.escaped(content)) + (String.length(tag) * 2) + 4
        };
        if (exp_loc.Location.loc_end.pos_cnum - exp_loc.Location.loc_start.pos_cnum > expectedMaxSize) {
          /* This is the jsx <div> bug where the div string thinks it's the size of the whole tag. */
          ()
        } else {
          addColorT(exp_loc, "string")
        }
      }
      /* TODO link to the type */
      | Texp_field(target, {txt, loc}, {lbl_arg}) => addColorType(loc, "field", lbl_arg)
      | Texp_construct({txt: Lident("::"), loc}, desc, args) => addType(loc, exp_type)
      | Texp_construct({txt, loc}, desc, args) => addColorT(loc, "constructor")
      | Texp_record(_) => addType(exp_loc, exp_type)
      /* | Texp_variant */
      | _ => ()
      /* | _ => addType(exp_loc, exp_type) */
      }
    };
    let enter_core_type = ({ctyp_desc, ctyp_loc: loc}) => {
      switch ctyp_desc {
      | Ttyp_var(string) => addColor(loc, "type-vbl")
      | Ttyp_constr(path, {txt, loc}, args) => {
        /* addColor(loc, "type-constructor") */
        addTag(loc, [Cls("type-constructor"), TypeRef(path)])
      }
      | _ => ()
      }
    };
    let enter_pattern = ({pat_desc, pat_loc, pat_type}) => {
      switch pat_desc {
      | Tpat_var(ident, {txt, loc}) => {
        addTag(loc, [Cls("pattern-ident"), ValueDef(ident), TypeHover(pat_type)])
        /* addColorType(loc, "pattern-ident", pat_type) */
      }
      /* | Tpat_construct({txt, loc}, desc, args) => addColorType(loc, "patern-constructor", pat_type) */
      | Tpat_construct({txt: Lident("::"), loc}, desc, args) => {
        addTag(loc, [TypeHover(pat_type)])
        /* addType(loc, pat_type) */
      }
      | Tpat_construct({txt, loc}, desc, args) => {
        /* TODO make this a TypeRef? */
        addTag(loc, [Cls("pattern-constructor"), TypeHover(pat_type)])
        /* addColorType(loc, "pattern-constructor", pat_type) */
      }
      | Tpat_constant(Const_int(_)) => addColorType(pat_loc, "int", pat_type)
      | Tpat_constant(Const_float(_)) => addColorType(pat_loc, "float", pat_type)
      | Tpat_constant(Const_string(_)) => addColorType(pat_loc, "string", pat_type)
      | _ => ()
      }
    };
  };
  (module Iter: TypedtreeIter.IteratorArgument)
};



let highlightItem = item => {
  let valueStamps = Hashtbl.create(100);
  let typeStamps = Hashtbl.create(100);
  let foundTags = ref([]);
  let externalValues = ref([]);
  let externalTypes = ref([]);

  let module TagIterator = TypedtreeIter.MakeIterator(val iterTags((loc, tags) => {
    foundTags := [(loc, tags), ...foundTags^];
    tags |> List.iter(tag => switch tag {
    | TypeDef({stamp, name}) => Hashtbl.replace(typeStamps, stamp, true)
    | ValueDef({stamp, name}) => Hashtbl.replace(valueStamps, stamp, true)
    | TypeHover(_) => ()
    | Cls(_) => ()
    | ValueRef(path) => {
      let {Ident.stamp} = Path.head(path);
      if (!Hashtbl.mem(valueStamps, stamp)) {
        externalValues := [path, ...externalValues^];
      }
    }
    | TypeRef(path) => {
      let {Ident.stamp} = Path.head(path);
      if (!Hashtbl.mem(typeStamps, stamp)) {
        externalTypes := [path, ...externalTypes^];
      }
    }
    })
  }));

  /* let iter_part = part => switch part {
  | Cmt_format.Partial_structure(str) => TagIterator.iter_structure(str)
  | Partial_structure_item(str) => TagIterator.iter_structure_item(str)
  | Partial_signature(str) => TagIterator.iter_signature(str)
  | Partial_signature_item(str) => TagIterator.iter_signature_item(str)
  | Partial_expression(expression) => TagIterator.iter_expression(expression)
  | Partial_pattern(pattern) => TagIterator.iter_pattern(pattern)
  | Partial_class_expr(class_expr) => TagIterator.iter_class_expr(class_expr)
  | Partial_module_type(module_type) => TagIterator.iter_module_type(module_type)
  };

  switch cmt {
  | Cmt_format.Implementation(str) => {
    TagIterator.iter_structure(str);
  }
  | Cmt_format.Interface(sign) => {
    TagIterator.iter_signature(sign);
  }
  | Cmt_format.Partial_implementation(parts)
  | Cmt_format.Partial_interface(parts) => {
    Array.iter(iter_part, parts);
  }
  | _ => failwith("Not a valid cmt file")
  }; */

  TagIterator.iter_structure_item(item);

  (foundTags^, externalValues^, externalTypes^)
};

type markdownTags = (Location.t, list(tag));

type node =
  | Item(Location.t, item, list((Location.t, list(tag))), list(Path.t), list(Path.t))
  | Module(string, list((int, node)))
and item =
  | Value(string)
  | Type(string)
;

let rec chart = (structureItems) => {
  open Typedtree;
  List.fold_left((items, item) => {
      let more = switch (item.str_desc) {
      | Tstr_value(recc, bindings) => (
        bindings |> filterNil(binding => switch binding {
        | {vb_loc, vb_pat: {pat_desc: Tpat_var({stamp, name}, _)}} => {
          let (markupTags, externalValues, externalTypes) = highlightItem({...item, str_desc: Tstr_value(recc, [binding])});
          Some((stamp, Item(vb_loc, Value(name), markupTags, externalValues, externalTypes)))
        }
        | _ => None
        }),
      )
      | Tstr_type(decls) => List.map(({typ_loc, typ_id: {stamp, name}} as decl) => {
        let (markupTags, externalValues, externalTypes) = highlightItem({...item, str_desc: Tstr_type([decl])});
        ((stamp, Item(typ_loc, Type(name), markupTags, externalValues, externalTypes)))
      }, decls)
      | Tstr_module({mb_id: {stamp, name}, mb_expr: {
        mod_type,
        mod_desc: Tmod_structure(structure) | Tmod_constraint({mod_desc: Tmod_structure(structure)}, _, _, _)
      }}) => {
        /* TODO do I need to record modules as such? */
        let children = chart(structure.str_items);
        [(stamp, Module(name, children))]
      }
      | _ => []
      };
      more @ items
  }, [], structureItems)
};

let process = (cmt, modStamps, typStamps, valStamps) => {
  /* let stamps = Hashtbl.create(100); */
  /* let rootNode = Module(moduleName, topChildren); */
  /* let items = ref([]);
  let add = t => items := [t, ...items^]; */

  /*
   * I want to be able to line up a `Path.t` to a stamp.
   * So that means:
   * - each module needs separate lists of types, values, and submodules
   */

  /* TODO I could probably inline this into `chart` */
  let rec collect = (nodes) => {
    List.fold_left(((types, values, modules), (stamp, node)) => {
      switch node {
      | Module(name, children) => {
        let organized = collect(children);
        Hashtbl.replace(modStamps, stamp, organized);
        (types, values, [(name, stamp), ...modules])
      }
      | Item(loc, item, tags, vals, typs) => {
        let (name, table) = switch item {
        | Type(name) => (name, typStamps)
        | Value(name) => (name, valStamps)
        };
        Hashtbl.replace(table, stamp, (name, loc, tags, vals, typs));
        switch item {
        | Type(_) => ([(name, stamp), ...types], values, modules)
        | Value(_) => (types, [(name, stamp), ...values], modules)
        }
      }
      }
    }, ([], [], []), nodes)
  };

  collect(chart(cmt))
};

let showType = typ => PrintType.default.expr(PrintType.default, typ) |> GenerateDoc.prettyString;

let fold = (d, fn, v) => switch v { | None => d | Some(v) => fn(v) };

let rec flatten = path => switch path {
  | Path.Pident(ident) => (ident, [])
  | Pdot(path, name, _) => {
    let (ident, names) = flatten(path);
    (ident, names @ [name])
  }
  | Papply(_) => failwith("Cannot apply paths")
};

let rec deepValue = (names, (_types, values, modules), valStamps, modStamps) => {
  switch names {
  | [] => `Missing
  | [name] => switch (List.assoc(name, values)) {
    | exception Not_found => `Missing
    | stamp => `Global(stamp)
    }
  | [modname, ...names] => switch (List.assoc(modname, modules)) {
    | exception Not_found => `Missing
    | stamp => deepValue(names, Hashtbl.find(modStamps, stamp), valStamps, modStamps)
    }
  }
};

let rec deepType = (names, (types, _values, modules), typStamps, modStamps) => {
  switch names {
  | [] => `Missing
  | [name] => switch (List.assoc(name, types)) {
    | exception Not_found => `Missing
    | stamp => `Global(stamp)
    }
  | [modname, ...names] => switch (List.assoc(modname, modules)) {
    | exception Not_found => `Missing
    | stamp => deepType(names, Hashtbl.find(modStamps, stamp), typStamps, modStamps)
    }
  }
};

let resolveValue = (valStamps, modStamps, globalMods, path) => {
  switch path {
  | Path.Pident({stamp}) => switch (Hashtbl.find(valStamps, stamp)) {
    | exception Not_found => `Local(stamp)
    | _ => `Global(stamp)
    }
  | Pdot(_) => {
    let ({Ident.stamp, name}, names) = flatten(path);
    switch (stamp == 0 ? Hashtbl.find(globalMods, name) : Hashtbl.find(modStamps, stamp)) {
    | exception Not_found => {print_endline("Cannot find module " ++ name); `Missing}
    | contents => deepValue(names, contents, valStamps, modStamps)
    }
  }
  | Papply(_, _) => `Missing
  }
};

/* TODO consolidate with deepType? */
let resolveType = (typStamps, modStamps, globalMods, path) => {
  switch path {
  | Path.Pident({stamp}) => switch (Hashtbl.find(typStamps, stamp)) {
    | exception Not_found => `Local(stamp)
    | _ => `Global(stamp)
    }
  | Pdot(_) => {
    let ({Ident.stamp, name}, names) = flatten(path);
    switch (stamp == 0 ? Hashtbl.find(globalMods, name) : Hashtbl.find(modStamps, stamp)) {
    | exception Not_found => {print_endline("Cannot find module " ++ name); `Missing}
    | contents => deepType(names, contents, typStamps, modStamps)
    }
  }
  | Papply(_, _) => `Missing
  }
};

let processMany = (modules) => {
  let globalMods = Hashtbl.create(100);

  let modStamps = Hashtbl.create(100);
  let typStamps = Hashtbl.create(100);
  let valStamps = Hashtbl.create(100);

  List.iter(((name, cmt, sourceText)) => {
    Hashtbl.replace(globalMods, name, process(cmt, modStamps, typStamps, valStamps))
  }, modules);

  let stampAttr = stamp => "data-local-define='" ++ string_of_int(stamp) ++ "'";
  let stampUse = stamp => switch stamp {
  | `Missing => ""
  | `Local(stamp) => "data-local-use='" ++ string_of_int(stamp) ++ "'"
  | `Global(stamp) => "data-global-use='" ++ string_of_int(stamp) ++ "'"
  };

  let mapTag = tag => switch tag {
  | TypeHover(typ) => "data-type=\"" ++ showType(typ) ++ "\""
  | Cls(string) => "class=\"" ++ string ++ "\""
  | TypeDef({stamp, name}) => stampAttr(stamp)
  | ValueDef({stamp, name}) => stampAttr(stamp)
  | TypeRef(path) => resolveType(typStamps, modStamps, globalMods, path) |> stampUse
  | ValueRef(path) => resolveValue(valStamps, modStamps, globalMods, path) |> stampUse
  };

  valStamps |> Hashtbl.iter((key, (name, loc, tags, vals, typs)) => {
    let resolvedTags = tags |> List.map(((loc, tags)) => {
      (loc, tags |> List.map(mapTag))
    });
    ()
  });
};