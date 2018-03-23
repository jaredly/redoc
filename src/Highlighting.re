
open Parsetree;

module F = (Collect: {
  let lident: (Longident.t, Location.t) => unit;
  let constant: ([< `Int | `Float | `Char | `String], Location.t) => unit;
}) => {
  let mapper = {
    ...Ast_mapper.default_mapper,
    expr: (mapper, {pexp_desc, pexp_loc} as expr) => {
      switch pexp_desc {
      | Pexp_ident({txt, loc}) => {
        Collect.lident(txt, loc);
        ()
      }
      | Pexp_let(isRecursive, bindings, scopedExpression) => {

        ()
      }
      | Pexp_constant(constant) => {
        let typ = switch constant {
        | Asttypes.Const_int(_) => `Int
        | Asttypes.Const_char(_) => `Char
        | Asttypes.Const_string(_, _) => `String
        | Asttypes.Const_float(_) => `Float
        | Asttypes.Const_int32(_) => `Int
        | Asttypes.Const_int64(_) => `Int
        | Asttypes.Const_nativeint(_) => `Int
        };
        Collect.constant(typ, pexp_loc);
        ()
      }

      /*
      | Pexp_constant(_) => failwith("<case>")
      | [@implicit_arity] Pexp_let(_, _, _) => failwith("<case>")
      | Pexp_function(_) => failwith("<case>")
      | [@implicit_arity] Pexp_fun(_, _, _, _) => failwith("<case>")
      | [@implicit_arity] Pexp_apply(_, _) => failwith("<case>")
      | [@implicit_arity] Pexp_match(_, _) => failwith("<case>")
      | [@implicit_arity] Pexp_try(_, _) => failwith("<case>")
      | Pexp_tuple(_) => failwith("<case>")
      | [@implicit_arity] Pexp_construct(_, _) => failwith("<case>")
      | [@implicit_arity] Pexp_variant(_, _) => failwith("<case>")
      | [@implicit_arity] Pexp_record(_, _) => failwith("<case>")
      | [@implicit_arity] Pexp_field(_, _) => failwith("<case>")
      | [@implicit_arity] Pexp_setfield(_, _, _) => failwith("<case>")
      | Pexp_array(_) => failwith("<case>")
      | [@implicit_arity] Pexp_ifthenelse(_, _, _) => failwith("<case>")
      | [@implicit_arity] Pexp_sequence(_, _) => failwith("<case>")
      | [@implicit_arity] Pexp_while(_, _) => failwith("<case>")
      | [@implicit_arity] Pexp_for(_, _, _, _, _) => failwith("<case>")
      | [@implicit_arity] Pexp_constraint(_, _) => failwith("<case>")
      | [@implicit_arity] Pexp_coerce(_, _, _) => failwith("<case>")
      | [@implicit_arity] Pexp_send(_, _) => failwith("<case>")
      | Pexp_new(_) => failwith("<case>")
      | [@implicit_arity] Pexp_setinstvar(_, _) => failwith("<case>")
      | Pexp_override(_) => failwith("<case>")
      | [@implicit_arity] Pexp_letmodule(_, _, _) => failwith("<case>")
      | Pexp_assert(_) => failwith("<case>")
      | Pexp_lazy(_) => failwith("<case>")
      | [@implicit_arity] Pexp_poly(_, _) => failwith("<case>")
      | Pexp_object(_) => failwith("<case>")
      | [@implicit_arity] Pexp_newtype(_, _) => failwith("<case>")
      | Pexp_pack(_) => failwith("<case>")
      | [@implicit_arity] Pexp_open(_, _, _) => failwith("<case>")
      | Pexp_extension(_) => failwith("<case>")
      */
      | _ => ()
      };
      Ast_mapper.default_mapper.expr(mapper, expr)
    }
  };

};


let highlight = (text, ast) => {
  let ranges = ref([]);
  let addRange = (loc, className) => ranges := [(loc, className), ...ranges^];
  let module Mapper = F({
    let lident = (ident, loc) => addRange(loc, "identifier");
    let constant = (t, loc) => addRange(loc, switch t {
    | `String => "string"
    | `Int => "int"
    | `Float => "float"
    | `Char => "char"
    });
  });
  Mapper.mapper.structure(Mapper.mapper, ast) |> ignore;
  let ranges = ranges^ |> List.sort(((aloc, _), (bloc, _)) => {
    let sdiff = aloc.Location.loc_start.Lexing.pos_cnum -
    bloc.Location.loc_start.Lexing.pos_cnum;
    /** If they start at the same time, the *larger* range should go First */
    if (sdiff === 0) {
      bloc.Location.loc_end.Lexing.pos_cnum -
      aloc.Location.loc_end.Lexing.pos_cnum
    } else {
      sdiff
    }
  });
  /** Yolo this might be overkill? */
  let inserts = Array.make(String.length(text), []);
  let closes = Array.make(String.length(text), 0);
  ranges |> List.iter((({Location.loc_start: {Lexing.pos_cnum}, loc_end: {Lexing.pos_cnum: cend}}, className)) => {
    inserts[pos_cnum] = [className, ...inserts[pos_cnum]];
    closes[cend] = closes[cend] + 1;
    /* inserts[cend] = [className, ...inserts[cend]]; */
  });

  let t = ref(text);
  let rec loop = (i, offset) => {
    if (i >= Array.length(closes)) {
      ()
    } else {
      let additional = if (closes[i] == 0) {
        ""
      } else {
        let rec loop = i => i > 0 ? "</span>" ++ loop(i - 1) : "";
        loop(closes[i])
      };
      let additional = additional ++ (if (inserts[i] == []) {
        ""
      } else {
        let rec loop = inserts => switch inserts {
        | [] => ""
        | [name, ...rest] => "<span class=\"" ++ name ++ "\">" ++ loop(rest)
        };
        loop(inserts[i])
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