
/* This is a special outcome printer. We use outcome tree, because it's meant for display. */

open Outcometree;

/* let rec collectArgs = (coll, typ) => switch typ {
| Otyp_arrow(label, arg, result) => collectArgs([(label, arg), ...coll], result)
| _ => (coll, typ)
};

let rec print_ident = id => switch id {
| Oide_ident(str) => str
| Oide_dot(inner, str) => print_ident(inner) ++ "." ++ str
| Oide_apply(_, _) => "apply is what"
};

let print_constructor = (loop, (name, args, result)) => {
  name ++ (switch args {
  | [] => ""
  | args => "(" ++ String.concat(", ", List.map(loop, args)) ++ ")"
  }) ++ (switch result {
  | None => ""
  | Some(typ) => ": " ++ loop(typ)
  })
};

let rec print_out_type = (~extension, out_type: out_type) => {
  let loop = print_out_type(~extension);
  switch (extension(loop, out_type)) {
  | Some(res) => res
  | None => switch out_type {
    | Otyp_abstract => ""
    | Otyp_open => ""
    | Otyp_alias(inner, alias) => "Alias: " ++ alias ++ ": " ++ loop(inner)
    | Otyp_arrow(label, arg, result) => {
      let (args, result) = collectArgs([(label, arg)], result);
      let args = List.rev(args);
      Printf.sprintf({|(%s) => %s|}, String.concat(", ", List.map(((label, typ)) => {
        if (label == "") {
          loop(typ)
        } else {
          Printf.sprintf("~%s: %s", label, loop(typ))
        }
      }, args)), loop(result))
    }
    | Otyp_class(_, _, _) => "class type"
    | Otyp_constr(ident, args) => print_ident(ident) ++ (switch args {
    | [] => ""
    | args => "(" ++ String.concat(", ", List.map(loop, args)) ++ ")"
    })
    | Otyp_manifest(left, right) => "manifest " ++ loop(left) ++ " <> " ++ loop(right)
    | Otyp_object(args, isopen) => "{. " ++ String.concat(", ", List.map(((label, typ)) => label ++ ": " ++ loop(typ), args)) ++ "}"
    | Otyp_record(items) => "{" ++ String.concat(", ", List.map(((label, something, typ)) => label ++ ": " ++ loop(typ), items)) ++ "}"
    | Otyp_stuff(what) => "stuff " ++ what
    | Otyp_sum(constructors) => String.concat(" | ", constructors |> List.map(print_constructor(loop)))
    | Otyp_tuple(items) => "(" ++ String.concat(", ", List.map(loop, items)) ++ ")"
    | Otyp_var(someFlag, str) => "'" ++ str
    | Otyp_variant(_, _, _, _) => "variant"
    | Otyp_poly(_, _) => "poly"
    | Otyp_module(_, _, _) => "module"
    };
  };
};

let print_desc = (~extension, desc) => Printtyp.tree_of_typexp(false, desc) |> print_out_type(~extension);

let print_desc = desc => {
  print_desc(~extension=(loop, item) => None, desc)
}; */

let rec collectArgs = (coll, typ) => switch typ.Types.desc {
| Types.Tarrow(label, arg, result, _) => collectArgs([(label, arg), ...coll], result)
| _ => (coll, typ)
};

type stringifier = {
  path: (stringifier, Format.formatter, Path.t) => unit,
  expr: (stringifier, Format.formatter, Types.type_expr) => unit,
  ident: (stringifier, Format.formatter, Ident.t) => unit,
  decl: (stringifier, Format.formatter, string, string, Types.type_declaration) => unit,
};

let commad_list = (fmt, items, loop) => {
  Format.pp_print_list(~pp_sep=(fmt, ()) => Format.fprintf(fmt, ",@ "), loop, fmt, items);
};

let sepd_list = (fmt, sep, items, loop) => {
  Format.pp_print_list(~pp_sep=(fmt, ()) => Format.fprintf(fmt, "@ %s", sep), loop, fmt, items);
};

let tuple_list = (fmt, items, loop) => {
  Format.fprintf(fmt, "(@[@,");
  commad_list(fmt, items, loop);
  Format.fprintf(fmt, "@;<0 -4>@])");
};

let print_expr = (stringifier, fmt, typ) => {
  let loop = stringifier.expr(stringifier);
  Format.fprintf(fmt, "@[<hov 4>");
  open Types;
  switch (typ.desc) {
  | Tvar(None) => Format.pp_print_string(fmt, "'a")
  | Tvar(Some(str)) => Format.pp_print_string(fmt, "'" ++ str)
  | Tarrow(label, arg, res, _) => {
    let (args, result) = collectArgs([(label, arg)], res);
    let args = List.rev(args);
    Format.fprintf(fmt, "(@[<hv 4>@,");
    Format.pp_print_list(~pp_sep=(fmt, ()) => Format.fprintf(fmt, ",@ "), (fmt, (label, typ)) => {
      if (label == "") {
        loop(fmt, typ)
      } else {
        Format.fprintf(fmt, "~%s: ", label);
        loop(fmt, typ)
      }
    }, fmt, args);
    Format.fprintf(fmt, "@;<0 -4>@]) => ");
    loop(fmt, result);
    /* Format.fprintf(fmt, {|(%s) => %s|}, String.concat(", ", List.map(((label, typ)) => {
      if (label == "") {
        loop(typ)
      } else {
        Printf.sprintf("~%s: %s", label, loop(typ))
      }
    }, args)), loop(result)) */
  }
  | Ttuple(items) => {
    tuple_list(fmt, items, loop);
    /* Format.pp_print_string(fmt, "(");
    Format.pp_print_list(~pp_sep=(fmt, ()) => Format.fprintf(fmt, ",@ "), loop, fmt, items);
    Format.pp_print_string(fmt, ")"); */
    /* "(" ++ String.concat(", ", List.map(loop, items)) ++ ")" */
  }
  | Tconstr(path, args, _) => {
    stringifier.path(stringifier, fmt, path);
    switch args {
    | [] => ()
    | args => tuple_list(fmt, args, loop)
    /* "(" ++ String.concat(", ", List.map(loop, args)) ++ ")" */
    }
  }
  | Tobject(_, _) => Format.pp_print_string(fmt, "<object>")
  | Tfield(_, _, _, _) => Format.pp_print_string(fmt, "<field>")
  | Tnil => Format.pp_print_string(fmt, "nil")
  | Tlink(inner) => loop(fmt, inner)
  | Tsubst(inner) => loop(fmt, inner)
  | Tvariant(_) => Format.pp_print_string(fmt, "<variant>")
  | Tunivar(_) => Format.pp_print_string(fmt, "<univar>")
  | Tpoly(_, _) => Format.pp_print_string(fmt, "<poly>")
  | Tpackage(_, _, _) => Format.pp_print_string(fmt, "<package>")
  };
  Format.fprintf(fmt, "@]");
};

let print_constructor = (loop, fmt, {Types.cd_id: {name}, cd_args, cd_res}) => {
  Format.pp_print_string(fmt, name);
  (switch cd_args {
  | [] => ()
  | args => tuple_list(fmt, args, loop)
  /* "(" ++ String.concat(", ", List.map(loop, args)) ++ ")" */
  });
  (switch cd_res {
  | None => ()
  | Some(typ) => {
    Format.pp_print_string(fmt, ": ");
    loop(fmt, typ)
  }
  })
};

let print_attr = (printer, fmt, {Types.ld_id, ld_mutable, ld_type}) => {
  switch ld_mutable {
  | Asttypes.Immutable => ()
  | Mutable => Format.pp_print_string(fmt, "mut ")
  };
  printer.ident(printer, fmt, ld_id);
  Format.pp_print_string(fmt,  ": ");
  printer.expr(printer, fmt, ld_type);
};

let print_decl = (stringifier, fmt, realName, name, decl) => {
  open Types;
  Format.fprintf(fmt, "@[<hv 4>");
  Format.pp_print_string(fmt, "type ");
  Format.pp_print_as(fmt, String.length(realName), name);
  /* Format.fprintf(fmt, "type %s", name); */
  switch decl.type_params {
  | [] => ()
  | args => tuple_list(fmt, args, stringifier.expr(stringifier))
  /* "(" ++ String.concat(", ", List.map(stringifier.expr(stringifier), args)) ++ ")" */
  };
  switch decl.type_kind {
  | Type_abstract => ()
  | Type_open => Format.pp_print_string(fmt, " = ..")
  | Type_record(labels, representation) => {
    Format.fprintf(fmt, " = {@[@,");
    commad_list(fmt, labels, print_attr(stringifier));
    Format.fprintf(fmt, "@;<0 -4>@]}");
    /* " = {\n  " ++ String.concat(",\n  ", List.map(print_attr(stringifier, fmt), labels)) ++ "\n}" */
  }
  | Type_variant(constructors) => {
    Format.fprintf(fmt, " =\n @[| ");
    sepd_list(fmt, "| ", constructors, print_constructor(stringifier.expr(stringifier)));
     /* String.concat("\n  | ", List.map(print_constructor(stringifier.expr(stringifier)), constructors)) */
    Format.fprintf(fmt, "@]");
  }
  };
  switch decl.type_manifest {
  | None => ()
  | Some(manifest) => {
    Format.pp_print_string(fmt, " = ");
    stringifier.expr(stringifier, fmt, manifest)
  }
  };
  Format.fprintf(fmt, "@]");
};

let default = {
  ident: (_, fmt, {Ident.name}) => Format.pp_print_string(fmt, name),
  path: (stringifier, fmt, path) => switch path {
    | Path.Pident(ident) => stringifier.ident(stringifier, fmt, ident)
    | Pdot(path, name, _) => {stringifier.path(stringifier, fmt, path); Format.pp_print_string(fmt, "." ++ name)}
    | Papply(_, _) => Format.pp_print_string(fmt, "<apply>")
  },
  expr: print_expr,
  decl: print_decl,
};