
open Outcometree;

let rec collectArgs = (coll, typ) => switch typ.Types.desc {
| Types.Tarrow(label, arg, result, _) => collectArgs([(label, arg), ...coll], result)
| _ => (coll, typ)
};

type stringifier = {
  path: (stringifier, Path.t) => Pretty.doc,
  expr: (stringifier, Types.type_expr) => Pretty.doc,
  ident: (stringifier, Ident.t) => Pretty.doc,
  decl: (stringifier, string, string, Types.type_declaration) => Pretty.doc,
  value: (stringifier, string, string, Types.type_expr) => Pretty.doc,
};

let break = Pretty.line("");
let space = Pretty.line(" ");

let str = Pretty.text;
let (@!) = Pretty.append;

let sepd_list = (sep, items, loop) => {
  let rec recur = items => switch items {
    | [] => Pretty.empty
    | [one] => loop(one)
    | [one, ...more] => loop(one) @! sep @! recur(more)
  };
  recur(items)
  /* Format.pp_print_list(~pp_sep=(fmt, ()) => Format.fprintf(fmt, "@ %s", sep), loop, fmt, items); */
};

let commad_list = (loop, items) => {
  sepd_list(str(",") @! space, items, loop)
  /* Format.pp_print_list(~pp_sep=(fmt, ()) => Format.fprintf(fmt, ",@ "), loop, fmt, items); */
};

let indentGroup = doc => Pretty.indent(4, Pretty.group(doc));

let tuple_list = (items, loop) => {
  str("(") @! indentGroup(break @!
  /* Format.fprintf(fmt, "(@[@,"); */
  commad_list(loop, items) @!
  break) @!
  str(")")
  /* Format.fprintf(fmt, "@;<0 -4>@])"); */
};

let print_expr = (stringifier, typ) => {
  let loop = stringifier.expr(stringifier);
  open Types;
  switch (typ.desc) {
  | Tvar(None) => str("'a")
  | Tvar(Some(s)) => str("'" ++ s)
  | Tarrow(label, arg, res, _) => {
    let (args, result) = collectArgs([(label, arg)], res);
    let args = List.rev(args);
    str("(") @!
    indentGroup(
      break @!
    commad_list(((label, typ)) => {
      if (label == "") {
        loop(typ)
      } else {
        str("~" ++ label ++ ": ") @! indentGroup(loop(typ))
      }
    }, args)
    @! break
    ) @! str(") => ") @!
    /* Format.fprintf(fmt, "@;<0 -4>@]) => "); */
    loop(result);
  }
  | Ttuple(items) => tuple_list(items, loop)
  | Tconstr(path, args, _) => {
    stringifier.path(stringifier, path) @!
    switch args {
    | [] => Pretty.empty
    | args => tuple_list(args, loop)
    }
  }
  | Tobject(_, _) => str("<object>")
  | Tfield(_, _, _, _) => str("<field>")
  | Tnil => str("nil")
  | Tlink(inner) => loop(inner)
  | Tsubst(inner) => loop(inner)
  | Tvariant(_) => str("<variant>")
  | Tunivar(_) => str("<univar>")
  | Tpoly(_, _) => str("<poly>")
  | Tpackage(_, _, _) => str("<package>")
  }
};

let print_constructor = (loop, {Types.cd_id: {name}, cd_args, cd_res}) => {
  str(name) @!
  (switch cd_args {
  | [] => Pretty.empty
  | args => tuple_list(args, loop)
  }) @!
  (switch cd_res {
  | None => Pretty.empty
  | Some(typ) => {
    str(": ") @!
    loop(typ)
  }
  })
};

let print_attr = (printer, {Types.ld_id, ld_mutable, ld_type}) => {
  switch ld_mutable {
  | Asttypes.Immutable => Pretty.empty
  | Mutable => str("mut ")
  } @!
  printer.ident(printer, ld_id) @!
  str( ": ") @!
  printer.expr(printer, ld_type);
};

let print_value = (stringifier, realName, name, decl) => {
  str("let ") @!
  str(~len=String.length(realName), name) @!
  str(" = ") @! stringifier.expr(stringifier, decl)
};

let print_decl = (stringifier, realName, name, decl) => {
  open Types;
  str("type ") @!
  str(~len=String.length(realName), name) @!
  switch decl.type_params {
  | [] => Pretty.empty
  | args => tuple_list(args, stringifier.expr(stringifier))
  } @!
  switch decl.type_kind {
  | Type_abstract => Pretty.empty
  | Type_open => str(" = ..")
  | Type_record(labels, representation) => {
    str(" = {") @! indentGroup(break @!
    commad_list(print_attr(stringifier), labels)
     @! break) @! str("}")
  }
  | Type_variant(constructors) => {
    str(" = ") @! indentGroup(break @! str("| ") @!
      sepd_list(space @! str("| "), constructors, print_constructor(stringifier.expr(stringifier)))
    ) @! break
  }
  } @!
  switch decl.type_manifest {
  | None => Pretty.empty
  | Some(manifest) => {
    str(" = ") @!
    stringifier.expr(stringifier, manifest)
  }
  };
  /* Format.fprintf(fmt, "@]"); */
};

let default = {
  ident: (_, {Ident.name}) => str(name),
  path: (stringifier, path) => switch path {
    | Path.Pident(ident) => stringifier.ident(stringifier, ident)
    | Pdot(path, name, _) => {stringifier.path(stringifier, path) @! str("." ++ name)}
    | Papply(_, _) => str("<apply>")
  },
  value: print_value,
  expr: print_expr,
  decl: print_decl,
};