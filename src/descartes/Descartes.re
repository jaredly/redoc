
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

let slice = (text, pstart, pend) => String.sub(text, pstart, pend - pstart);

type fullItem = {
  id: string,
  name: string,
  moduleName: string,
  loc: Location.t,
  tags: list((Location.t, list(tag))),
  vals: list(Path.t),
  typs: list(Path.t),
  text: string,
};

let process = (moduleName, structure, sourceText, modStamps, typStamps, valStamps) => {
  /* let stamps = Hashtbl.create(100); */
  /* let rootNode = Module(moduleName, topChildren); */
  /* let items = ref([]);
  let add = t => items := [t, ...items^]; */

  /*
   * I want to be able to line up a `Path.t` to a stamp.
   * So that means:
   * - each module needs separate lists of types, values, and submodules
   */
  let id = stamp => moduleName ++ "/" ++ string_of_int(stamp);

  /* TODO I could probably inline this into `chart` */
  let rec collect = (nodes) => {
    List.fold_left(((types, values, modules), (stamp, node)) => {
      switch node {
      | Module(name, children) => {
        let organized = collect(children);
        Hashtbl.replace(modStamps, id(stamp), (name, organized));
        (types, values, [(name, id(stamp)), ...modules])
      }
      | Item(loc, item, tags, vals, typs) => {
        let (name, table) = switch item {
        | Type(name) => (name, typStamps)
        | Value(name) => (name, valStamps)
        };
        Hashtbl.replace(table, id(stamp), {id: id(stamp), name, moduleName, loc, tags, vals, typs, text: slice(sourceText, loc.Location.loc_start.pos_cnum, loc.Location.loc_end.pos_cnum)});
        switch item {
        | Type(_) => ([(name, id(stamp)), ...types], values, modules)
        | Value(_) => (types, [(name, id(stamp)), ...values], modules)
        }
      }
      }
    }, ([], [], []), nodes)
  };

  collect(chart(structure))
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

let toId = (moduleName, stamp) => moduleName ++ "/" ++ string_of_int(stamp);

let rec deepValue = (names, (_name, (_types, values, modules)), valStamps, modStamps) => {
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

let rec deepType = (names, (_name, (types, _values, modules)), typStamps, modStamps) => {
  switch names {
  | [] => `Missing
  | [name] => switch (List.assoc(name, types)) {
    | exception Not_found => `Missing
    | id => `Global(id)
    }
  | [modname, ...names] => switch (List.assoc(modname, modules)) {
    | exception Not_found => `Missing
    | id => deepType(names, Hashtbl.find(modStamps, id), typStamps, modStamps)
    }
  }
};

let resolveValue = (moduleName, valStamps, modStamps, globalMods, path) => {
  switch path {
  | Path.Pident({stamp}) => switch (Hashtbl.find(valStamps, toId(moduleName, stamp))) {
    | exception Not_found => `Local(toId(moduleName, stamp))
    | _ => `Global(toId(moduleName, stamp))
    }
  | Pdot(_) => {
    let ({Ident.stamp, name}, names) = flatten(path);
    switch (stamp == 0 ? Hashtbl.find(globalMods, name) : Hashtbl.find(modStamps, toId(moduleName, stamp))) {
    | exception Not_found => {print_endline("Cannot find module " ++ name); `Missing}
    | contents => deepValue(names, contents, valStamps, modStamps)
    }
  }
  | Papply(_, _) => `Missing
  }
};

/* TODO consolidate with deepType? */
let resolveType = (moduleName, typStamps, modStamps, globalMods, path) => {
  switch path {
  | Path.Pident({stamp}) => switch (Hashtbl.find(typStamps, toId(moduleName, stamp))) {
    | exception Not_found => `Local(toId(moduleName, stamp))
    | _ => `Global(toId(moduleName, stamp))
    }
  | Pdot(_) => {
    let ({Ident.stamp, name}, names) = flatten(path);
    switch (stamp == 0 ? Hashtbl.find(globalMods, name) : Hashtbl.find(modStamps, toId(moduleName, stamp))) {
    | exception Not_found => {print_endline("Cannot find module " ++ name); `Missing}
    | contents => deepType(names, contents, typStamps, modStamps)
    }
  }
  | Papply(_, _) => `Missing
  }
};

let unique = list => {
  let hash = Hashtbl.create(10);
  list |> List.filter(item => Hashtbl.mem(hash, item) ? false : {Hashtbl.add(hash, item, true); true})
};

let processMany = (modules) => {
  let globalMods = Hashtbl.create(100);

  let modStamps = Hashtbl.create(100);
  let typStamps = Hashtbl.create(100);
  let valStamps = Hashtbl.create(100);

  List.iter(((name, structure, sourceText)) => {
    Hashtbl.replace(globalMods, name, (name, process(name, structure, sourceText, modStamps, typStamps, valStamps)))
  }, modules);

  let stampAttr = (moduleName, stamp) => "data-local-define='" ++ moduleName ++ "/" ++ string_of_int(stamp) ++ "'";
  let stampUse = (stamp) => switch stamp {
  | `Missing => "data-stamp-missing"
  | `Local(stamp) => "data-local-use='" ++ (stamp) ++ "'"
  | `Global(stamp) => "data-global-use='" ++ (stamp) ++ "'"
  };

  let mapTag = (moduleName, tag) => switch tag {
  | TypeHover(typ) => "data-type=\"" ++ showType(typ) ++ "\""
  | Cls(string) => "class=\"" ++ string ++ "\""
  | TypeDef({stamp, name}) => stampAttr(moduleName, stamp)
  | ValueDef({stamp, name}) => stampAttr(moduleName, stamp)
  | TypeRef(path) => resolveType(moduleName, typStamps, modStamps, globalMods, path) |> stampUse
  | ValueRef(path) => resolveValue(moduleName, valStamps, modStamps, globalMods, path) |> stampUse
  };

  let resolveItem = ({id, name, moduleName, loc, tags, vals, typs, text}) => {
    let resolvedTags = tags |> List.map(((loc, tags)) => {
      (loc.Location.loc_start.pos_cnum, loc.Location.loc_end.pos_cnum, tags |> List.map(mapTag(moduleName)) |> String.concat(" "))
    });
    let text = CodeHighlight.annotateText(resolvedTags, [], text, loc.Location.loc_start.pos_cnum, loc.Location.loc_end.pos_cnum);
    let vals = vals |> List.map(path => resolveValue(moduleName, valStamps, modStamps, globalMods, path)) |> unique |> CodeSnippets.optMap(res => switch res {
    | `Missing => None
    | `Local(_) => None
    | `Global(id) => Some(Hashtbl.find(valStamps, id))
    })
    ;
    let typs = typs |> List.map(path => resolveType(moduleName, typStamps, modStamps, globalMods, path)) |> unique |> CodeSnippets.optMap(res => switch res {
    | `Missing => None
    | `Local(_) => None
    | `Global(id) => Some(Hashtbl.find(typStamps, id))
    });
    (id, name, moduleName, loc, text, vals, typs)
  };

  /* TODO track the parentage of values */
  let annotatedValues = Hashtbl.fold((key, item, items) => [resolveItem(item), ...items], valStamps, []);
  let annotatedTypes = Hashtbl.fold((key, item, items) => [resolveItem(item), ...items], typStamps, []);

  let allModules =
  Hashtbl.fold((key, (name, (types, values, modules)), items) => [
    (key, name, List.map(snd, types) @ List.map(snd, values) @ List.map(snd, modules)),
    ...items
  ], modStamps, [])
  @
  Hashtbl.fold((key, (name, (types, values, modules)), items) => [
    (key, name, List.map(snd, types) @ List.map(snd, values) @ List.map(snd, modules)),
    ...items
  ], globalMods, [])
  ;

  (annotatedValues, allModules)
  /* TODO don't super need these for my current visualization */
   /* @ annotatedTypes */
};

let (/+) = Filename.concat;
open Infix;

let gatherCmts = (cmtdir, srcdir, skip) => {
  Files.collect(cmtdir, path => Filename.check_suffix(path, ".cmt") && !List.mem(Filename.basename(path) |> Filename.chop_extension, skip)) |> List.map(path => (
    path,
    srcdir /+ (Files.relpath(cmtdir, Filename.chop_extension(path) ++ ".re"))
  )) |> List.filter(((a, b)) => Files.exists(b))
};

let main = () => {
  switch (Sys.argv |> Array.to_list) {
  | [_, cmtdir, srcdir, ...skip] => {
    let files = gatherCmts(cmtdir, srcdir, skip);
    let ready = files |> List.map(((cmt, src)) => {
      let name = Filename.basename(cmt) |> Filename.chop_extension |> String.capitalize;
      let annots = Cmt_format.read_cmt(cmt).Cmt_format.cmt_annots;
      switch annots {
      | Cmt_format.Implementation({str_items}) => (name, str_items, Files.readFile(src) |! "Unable to read source file")
      | _ => failwith("Bad cmt")
      }
    });

    let (allValues, allModules) = processMany(ready);
    let contents = "window.DATA = {" ++ String.concat(",\n", List.map(((id, name, moduleName, loc, text, vals, typs)) => {
      Printf.sprintf(
        {|"%s": {"name": %S, "moduleName": %S, "html": %S, "values": %s, "chars": %d, "lines": %d}|},
        id,
        name,
        moduleName,
        text,
        "[" ++ String.concat(", ", List.map(({id, name, moduleName}) => Printf.sprintf({|{"id": %S, "name": %S, "moduleName": %S}|}, id, name, moduleName), vals)) ++ "]",
        loc.Location.loc_end.pos_cnum - loc.Location.loc_start.pos_cnum,
        loc.Location.loc_end.pos_lnum - loc.Location.loc_start.pos_lnum
      )
    }, allValues)) ++ "};\nwindow.MODULES = {" ++
    String.concat(",\n", allModules |> List.map(((id, name, ids)) => Printf.sprintf({|%S: {"name": %S, "ids": [%s]}|}, id, name, String.concat(", ", List.map(Printf.sprintf("%S"), ids)))))
    ++ "}";
    Files.writeFile("./docs/descartes/descartes.js", contents) |> ignore
  }
  | _ => print_endline("Usage: descartes cmtdir srcdir")
  }
};

main();