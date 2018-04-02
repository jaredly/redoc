
open Outcometree;

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
  }
  | Ttuple(items) => tuple_list(fmt, items, loop)
  | Tconstr(path, args, _) => {
    stringifier.path(stringifier, fmt, path);
    switch args {
    | [] => ()
    | args => tuple_list(fmt, args, loop)
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
  Format.fprintf(fmt, "@[<hov>");
  switch ld_mutable {
  | Asttypes.Immutable => ()
  | Mutable => Format.pp_print_string(fmt, "mut ")
  };
  printer.ident(printer, fmt, ld_id);
  Format.pp_print_string(fmt,  ": ");
  printer.expr(printer, fmt, ld_type);
  Format.fprintf(fmt, "@]");
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
  };
  switch decl.type_kind {
  | Type_abstract => ()
  | Type_open => Format.pp_print_string(fmt, " = ..")
  | Type_record(labels, representation) => {
    Format.fprintf(fmt, " = {@[@,");
    commad_list(fmt, labels, print_attr(stringifier));
    Format.fprintf(fmt, "@;<0 -4>@]}");
  }
  | Type_variant(constructors) => {
    Format.fprintf(fmt, " =\n @[| ");
    sepd_list(fmt, "| ", constructors, print_constructor(stringifier.expr(stringifier)));
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