
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
  path: (stringifier, Path.t) => string,
  expr: (stringifier, Types.type_expr) => string,
  ident: (stringifier, Ident.t) => string,
  decl: (stringifier, string, Types.type_declaration) => string,
};

let print_expr = (stringifier, typ) => {
  let loop = stringifier.expr(stringifier);
  open Types;
  switch (typ.desc) {
  | Tvar(None) => "'a"
  | Tvar(Some(str)) => "'" ++ str
  | Tarrow(label, arg, res, _) => {
    let (args, result) = collectArgs([(label, arg)], res);
    let args = List.rev(args);
    Printf.sprintf({|(%s) => %s|}, String.concat(", ", List.map(((label, typ)) => {
      if (label == "") {
        loop(typ)
      } else {
        Printf.sprintf("~%s: %s", label, loop(typ))
      }
    }, args)), loop(result))
  }
  | Ttuple(items) => "(" ++ String.concat(", ", List.map(loop, items)) ++ ")"
  | Tconstr(path, args, _) => stringifier.path(stringifier, path) ++ (switch args {
    | [] => ""
    | args => "(" ++ String.concat(", ", List.map(loop, args)) ++ ")"
    })
  | Tobject(_, _) => "<object>"
  | Tfield(_, _, _, _) => "<field>"
  | Tnil => "nil"
  | Tlink(inner) => loop(inner)
  | Tsubst(inner) => loop(inner)
  | Tvariant(_) => "<variant>"
  | Tunivar(_) => "<univar>"
  | Tpoly(_, _) => "<poly>"
  | Tpackage(_, _, _) => "<package>"
  }
};

let print_constructor = (loop, {Types.cd_id: {name}, cd_args, cd_res}) => {
  name ++ (switch cd_args {
  | [] => ""
  | args => "(" ++ String.concat(", ", List.map(loop, args)) ++ ")"
  }) ++ (switch cd_res {
  | None => ""
  | Some(typ) => ": " ++ loop(typ)
  })
};

let print_attr = (printer, {Types.ld_id, ld_mutable, ld_type}) => {
  switch ld_mutable {
  | Asttypes.Immutable => ""
  | Mutable => "mut "
  } ++ printer.ident(printer, ld_id) ++ ": " ++ printer.expr(printer, ld_type)
};

let print_decl = (stringifier, name, decl) => {
  open Types;
  let args = switch decl.type_params {
  | [] => ""
  | args => "(" ++ String.concat(", ", List.map(stringifier.expr(stringifier), args)) ++ ")"
  };
  let left = "type " ++ name ++ args;
  switch decl.type_kind {
  | Type_abstract => left
  | Type_open => left ++ " = .."
  | Type_record(labels, representation) => left ++ " = {\n  " ++ String.concat(",\n  ", List.map(print_attr(stringifier), labels)) ++ "\n}"
  | Type_variant(constructors) => left ++ " =\n  | " ++ String.concat("\n  | ", List.map(print_constructor(stringifier.expr(stringifier)), constructors))
  } ++ (switch decl.type_manifest {
  | None => ""
  | Some(manifest) => " = " ++ stringifier.expr(stringifier, manifest)
  })
};

let default = {
  ident: (_, {Ident.name}) => name,
  path: (stringifier, path) => switch path {
    | Path.Pident(ident) => stringifier.ident(stringifier, ident)
    | Pdot(path, name, _) => stringifier.path(stringifier, path) ++ "." ++ name
    | Papply(_, _) => "<apply>"
  },
  expr: print_expr,
  decl: print_decl,
};