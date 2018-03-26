
open Parsetree;

module F = (Collect: {
  let lident: (Longident.t, Location.t, string) => unit;
  let pat_var: (string, Location.t) => unit;
  let constant: ([< `Int | `Float | `Char | `String | `Boolean], Location.t) => unit;
}) => {

  let constantType = constant => switch constant {
  | Asttypes.Const_int(_) => `Int
  | Asttypes.Const_char(_) => `Char
  | Asttypes.Const_string(_, _) => `String
  | Asttypes.Const_float(_) => `Float
  | Asttypes.Const_int32(_) => `Int
  | Asttypes.Const_int64(_) => `Int
  | Asttypes.Const_nativeint(_) => `Int
  };

  let rec mapPat = (prefix, {ppat_desc, ppat_loc}) => {
    let mapPat = mapPat(prefix);
    switch ppat_desc {
    | Ppat_any => ()
    | Ppat_var({txt, loc}) => Collect.pat_var(txt, loc)
    | Ppat_alias(pat, {txt, loc}) => {
      mapPat(pat);
      Collect.pat_var(txt, loc)
    }
    | Ppat_constant(constant) => Collect.constant(constantType(constant), ppat_loc)
    | Ppat_interval(start, send) => ()
    | Ppat_tuple(items) => List.iter(mapPat, items)
    | Ppat_construct({txt, loc}, args) => {
      Collect.lident(txt, loc, prefix); /* maybe distinguish that this is in a pattern */
      switch  args {
        | None => ()
        | Some(pat) => mapPat(pat)
      };
    }
    | Ppat_variant(label, arg) => ()
    | Ppat_record(attributes, closedFlag) => {
      attributes |> List.iter((({Asttypes.txt, loc}, pat)) => {
        Collect.lident(txt, loc, prefix);
        mapPat(pat)
      })
    }
    | Ppat_array(contents) => ()
    | Ppat_or(left, right) => {mapPat(left); mapPat(right)}
    | Ppat_constraint(pat, typ) => mapPat(pat)
    | Ppat_type({txt, loc}) => Collect.lident(txt, loc, "type-")
    | Ppat_lazy(pat) => mapPat(pat)
    | Ppat_unpack({txt, loc}) => Collect.pat_var(txt, loc)
    | Ppat_exception(pat) => mapPat(pat)
    | Ppat_extension(ext) => ()
    }
  };

  let mapper = {
    ...Ast_mapper.default_mapper,
    structure_item: (mapper, {pstr_desc, pstr_loc} as str) => {
      switch pstr_desc {
      | Pstr_value(recFlag, bindings) => {
        bindings |> List.iter(({pvb_pat, pvb_expr, pvb_loc}) => {
          mapPat("top-let-", pvb_pat);
          ()
        })
      }
      | Pstr_module({pmb_name: {txt, loc}}) => Collect.pat_var(txt, loc)
      | Pstr_open({popen_lid: {txt, loc}}) => Collect.lident(txt, loc, "open-")
      /* | Pstr_primitive(_) => failwith("<case>")
      | Pstr_type(_) => failwith("<case>")
      | Pstr_typext(_) => failwith("<case>")
      | Pstr_exception(_) => failwith("<case>")
      | Pstr_module(_) => failwith("<case>")
      | Pstr_recmodule(_) => failwith("<case>")
      | Pstr_modtype(_) => failwith("<case>")
      | Pstr_open(_) => failwith("<case>")
      | Pstr_class(_) => failwith("<case>")
      | Pstr_class_type(_) => failwith("<case>")
      | Pstr_include(_) => failwith("<case>")
      | Pstr_attribute(_) => failwith("<case>")
      | Pstr_extension(_, _) => failwith("<case>") */
      | _ => ()
      };
      Ast_mapper.default_mapper.structure_item(mapper, str);
    },
    type_declaration: (mapper, {ptype_name: {txt, loc}} as decl) => {
      Collect.pat_var(txt, loc);
      Ast_mapper.default_mapper.type_declaration(mapper, decl)
    },
    typ: (mapper, typ) => {
      switch typ.ptyp_desc {
      | Ptyp_constr({txt, loc}, args) => Collect.lident(txt, loc, "type-")
      | _ => ()
      };
      Ast_mapper.default_mapper.typ(mapper, typ)
    },
    expr: (mapper, {pexp_desc, pexp_loc} as expr) => {
      switch pexp_desc {
      | Pexp_ident({txt, loc}) => {
        Collect.lident(txt, loc, "");
        ()
      }
      | Pexp_let(isRecursive, bindings, scopedExpression) => {
        bindings |> List.iter(({pvb_pat, pvb_expr, pvb_loc}) => {
          mapPat("let-", pvb_pat);
        });
        ()
      }
      | Pexp_constant(constant) => {
        Collect.constant(constantType(constant), pexp_loc);
        ()
      }

      | Pexp_fun(label, default, pattern, body) => {
        mapPat("arg-", pattern);
        ()
      }

      | Pexp_apply(target, arguments) => {
        arguments |> List.iter(((label, argument)) => {
          if (label == "") {
            ()
          } else {
            /* :( don't have location info for the label */
            ()
          }
          ;()
        })
        ;
        ()
      }
      | Pexp_tuple(items) => {
        /* TODO handle parens */
        ()
      }

      | Pexp_match(arg, items) => {
        items |> List.iter(({pc_lhs, pc_guard, pc_rhs}) => {
          mapPat("switch-", pc_lhs)
          ;
          ()
        })
      }

      | Pexp_field(expr, {txt, loc}) => Collect.lident(txt, loc, "field-")
      | Pexp_record(items, maybeSpread) => {
        items |> List.iter((({Asttypes.txt, loc}, value)) => {
          Collect.lident(txt, loc, "record-")
        })
      }
      | Pexp_construct({txt: Lident("true" | "false"), loc}, arg) => {
        Collect.constant(`Boolean, pexp_loc)
      }
      | Pexp_construct({txt, loc}, arg) => {
        Collect.lident(txt, loc, "constructor-")
      }

      /*
      | Pexp_function(_) => failwith("<case>")
      | Pexp_match(_, _) => failwith("<case>")
      | Pexp_try(_, _) => failwith("<case>")
      | Pexp_variant(_, _) => failwith("<case>")
      | Pexp_setfield(_, _, _) => failwith("<case>")
      | Pexp_array(_) => failwith("<case>")
      | Pexp_ifthenelse(_, _, _) => failwith("<case>")
      | Pexp_sequence(_, _) => failwith("<case>")
      | Pexp_while(_, _) => failwith("<case>")
      | Pexp_for(_, _, _, _, _) => failwith("<case>")
      | Pexp_constraint(_, _) => failwith("<case>")
      | Pexp_coerce(_, _, _) => failwith("<case>")
      | Pexp_send(_, _) => failwith("<case>")
      | Pexp_new(_) => failwith("<case>")
      | Pexp_setinstvar(_, _) => failwith("<case>")
      | Pexp_override(_) => failwith("<case>")
      | Pexp_letmodule(_, _, _) => failwith("<case>")
      | Pexp_assert(_) => failwith("<case>")
      | Pexp_lazy(_) => failwith("<case>")
      | Pexp_poly(_, _) => failwith("<case>")
      | Pexp_object(_) => failwith("<case>")
      | Pexp_newtype(_, _) => failwith("<case>")
      | Pexp_pack(_) => failwith("<case>")
      | Pexp_open(_, _, _) => failwith("<case>")
      | Pexp_extension(_) => failwith("<case>")
      */
      | _ => ()
      };
      Ast_mapper.default_mapper.expr(mapper, expr)
    }
  };

};

let locPair = ({Location.loc_start, loc_end}) => (loc_start.pos_cnum, loc_end.pos_cnum);

let rec pathName = path => {
  switch path {
  | Path.Pident({Ident.stamp, name}) => stamp == 0 ? name ++ "!" : name ++ "/" ++ string_of_int(stamp)
  | Path.Pdot(path, name, _) => pathName(path) ++ "." ++ name
  | Path.Papply(one, two) => failwith("cannot path name an apply") /* TBH I just don't understand apply */
  }
};


let collect = (ast, bindingsMap, externalsMap, locToPath) => {
  let ranges = ref([]);
  let addNums = (cstart, cend, className, id) => ranges := [(cstart, cend, className, id), ...ranges^];
  let addRange = (loc, className, id) => {
    if (!loc.Location.loc_ghost) {
      addNums(loc.Location.loc_start.pos_cnum, loc.Location.loc_end.pos_cnum, className, id);
    }
  };

  let addIdentifier = (cstart, cend, txt, prefix, id) => {
    let txt = String.trim(txt);
    let cls = if (txt.[0] >= 'A' && txt.[0] <= 'Z') {
      print_endline("Mod " ++ txt);
      "module-identifier"
    } else if (txt.[0] == '_') {
      "unused-identifier"
    } else if (txt.[0] < 'a' || txt.[0] > 'z' || txt.[0] == '!' || txt == "!" || txt == "not") {
      "operator"
    } else {
      "value-identifier"
    };
    addNums(cstart, cend, prefix ++ cls, id);
  };

  let getId = (name, cstart, cend) => {
    switch (Hashtbl.find(locToPath, (cstart, cend))) {
    | exception Not_found => {
      switch (Hashtbl.find(bindingsMap, (cstart, cend))) {
      | exception Not_found => `Normal
      | stamp => `Full(name ++ "/" ++ string_of_int(stamp))
      };
    }
    | path => `Full(pathName(path))
    }
  };

  let idForLoc = (name, {Location.loc_start: {pos_cnum}, loc_end: {pos_cnum: cend}}) => {
    getId(name, pos_cnum, cend)
  };

  let addLident = (lident: Longident.t, cstart, cend, prefix) => {
    switch lident {
    | Longident.Lident("()") => addNums(cstart, cend, "unit", `Normal)
    | _ => {
      switch (Hashtbl.find(locToPath, (cstart, cend))) {
      | exception Not_found => {
        print_endline("No binding path for " ++ string_of_int(cstart) ++ "-" ++ string_of_int(cend) ++ (String.concat(".", Longident.flatten(lident))));
        ()
      }
      | path => {
        let rec loop = (lident, cstart, cend, path) => {
          switch (lident, path) {
          | (Longident.Lident(txt), _) => addIdentifier(cstart, cend, txt, prefix, `Full(pathName(path)))
          | (Longident.Ldot(lident, txt), Path.Pdot(pleft, pname, _)) => {
            loop(lident, cstart, cend - String.length(txt) - 1, pleft);
            addIdentifier(cend - String.length(txt), cend, txt, prefix, `Full(pathName(path)))
          }
          | (Longident.Lapply(first, second), _) => ()
          | _ => ()
          }
        };
        loop(lident,cstart, cend, path)
      }
      }
    }
    }
  };

  let module Mapper = F({
    let lident = (ident, loc, prefix) => {
      if (!loc.Location.loc_ghost) {
        addLident(ident, loc.Location.loc_start.pos_cnum, loc.Location.loc_end.pos_cnum, prefix)
      };
    };
    let pat_var = (str, loc) => addRange(loc, "declaration-var", idForLoc(str, loc));
    let constant = (t, loc) => addRange(loc, switch t {
    | `String => "string"
    | `Int => "int"
    | `Float => "float"
    | `Char => "char"
    | `Boolean => "boolean"
    }, `Normal);
  });

  Mapper.mapper.structure(Mapper.mapper, ast) |> ignore;
  ranges^ |> List.sort(((ast, ae, _, _), (bst, be, _, _)) => {
    let sdiff = ast - bst;
    /** If they start at the same time, the *larger* range should go First */
    if (sdiff === 0) {
      be - ae
    } else {
      sdiff
    }
  });
};

let buildLocBindingMap = bindings => {
  let map = Hashtbl.create(100);
  Hashtbl.iter((stamp, ((_, loc), uses)) => {
    Hashtbl.replace(map, locPair(loc), stamp);
    uses |> List.iter(((_, loc)) => Hashtbl.replace(map, locPair(loc), stamp))
  }, bindings);
  map
};

let buildExternalsMap = externals => {
  let map = Hashtbl.create(100);
  externals |> List.iter(((path, loc)) => {
    Hashtbl.replace(map, locPair(loc), path)
  });
  map
};

let highlight = (text, ast, bindings, externals, all_opens, locToPath) => {

  let bindingMap = buildLocBindingMap(bindings);
  let externalsMap = buildExternalsMap(externals);
  let ranges = collect(ast, bindingMap, externalsMap, locToPath);

  /** Yolo this might be overkill? */
  let tag_starts = Array.make(String.length(text), []);
  let tag_closes = Array.make(String.length(text), 0);
  ranges |> List.iter(((cstart, cend, className, id)) => {
    tag_starts[cstart] = [(className, id), ...tag_starts[cstart]];
    tag_closes[cend] = tag_closes[cend] + 1;
  });

  let extra_inserts = Array.make(String.length(text), []);
  let globalTag = (path, lident) => {
    let show = String.concat(".", Longident.flatten(lident));
    let id = pathName(path) ++ "." ++ show;
    Printf.sprintf({|<span class="declaration-var" data-id="%s">%s</span>|}, id, show)
  };
  all_opens |> List.iter(({Typing.path, loc, used}) => {
    if (!loc.Location.loc_ghost) {
      let i = loc.Location.loc_end.pos_cnum;
      print_endline(string_of_int(i));
      extra_inserts[i] = [
        Printf.sprintf(
          {|%s <span class="open-exposing">exposing (%s)</span>|},
          switch path {
          | Path.Pident({name: "Pervasives"}) => "open Pervasives"
          | _ => ""
          },
          used |> List.map(globalTag(path)) |> String.concat(", ")
        ),
        ...extra_inserts[i]
      ];
    } else {
      print_endline("Skipping a ghost open :/")
    }
  });

  let openTag = (name, id) => {
    "<span class=\"" ++ name ++ "\"" ++ (
      switch id {
      | `Normal => ""
      | `Opened(id) => " data-opened data-id=\"" ++ id ++ "\""
      | `Full(id) => " data-id=\"" ++ id ++ "\""
      }
    ) ++ ">"
/*
     /* for viewing witch identifiers have numbers */
      ++ (switch id {
    | `Normal => ""
    | `Opened(id) | `Full(id) => "<span class=\"id-badge\">" ++ id ++ "</span>"
    }) */
  };

  let t = ref(text);
  let rec loop = (i, offset) => {
    if (i >= Array.length(tag_closes)) {
      ()
    } else {
      let additional = if (tag_closes[i] == 0) {
        ""
      } else {
        let rec loop = i => i > 0 ? "</span>" ++ loop(i - 1) : "";
        loop(tag_closes[i])
      };

      let additional = additional ++ (if (extra_inserts[i] == []) {
        ""
      } else {
        String.concat("", extra_inserts[i])
      });

      let additional = additional ++ (if (tag_starts[i] == []) {
        ""
      } else {
        let rec loop = inserts => switch inserts {
        | [] => ""
        | [(name, id), ...rest] => openTag(name, id) ++ loop(rest)
        };
        loop(tag_starts[i])
      });

      t := String.sub(t^, 0, i + offset) ++ additional ++ String.sub(t^, i + offset, String.length(t^) - i - offset);
      loop(i + 1, offset + (String.length(additional)))
    }
  };
  loop(0, 0);
  t^

  /* let rec loop = (text, ranges, offset) => {
    switch ranges {
    | [] => text
    | [(loc, className), ...rest] => {

    }
    }
  };
  loop(text, ranges, 0) */
};