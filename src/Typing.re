
module type Collector = {
  let add: (~mend: Lexing.position=?, ~depth: int=?, Types.type_expr, Location.t) => unit;
  let ident: (Path.t, Location.t) => unit;
  let declaration: (Ident.t, Location.t) => unit;
};

module F = (Collector: Collector) => {
  include TypedtreeIter.DefaultIteratorArgument;
  let enter_structure_item = (item) =>
    Typedtree.(
      switch item.str_desc {
      | Tstr_value(isrec, bindings) =>
        List.iter(
          (binding) => Collector.add(binding.vb_expr.exp_type, binding.vb_loc),
          bindings
        )
      | _ => ()
      }
    );
  let depth = ref(0);
  let enter_core_type = (typ) => {
    open Typedtree;
    Collector.add(~depth=depth^, typ.ctyp_type, typ.ctyp_loc);
    switch typ.ctyp_desc {
    | Ttyp_constr(path, {txt, loc}, args) => {
      Collector.ident(path, loc)
    }
    | _ => ()
    }
  };
  let enter_type_declaration = (typ) => {
    open Typedtree;
    switch typ.typ_type.Types.type_manifest {
    | Some((x)) => Collector.add(~depth=depth^, x, typ.typ_loc)
    | _ => ()
    };
    Collector.declaration(typ.typ_id, typ.typ_name.loc)
  };
  let enter_pattern = pat => {
    open Typedtree;
    Collector.add(~depth=depth^, pat.pat_type, pat.pat_loc);
    switch (pat.pat_desc) {
    | Tpat_var(ident, {txt, loc}) => Collector.declaration(ident, loc)
    | Tpat_alias(_, ident, {txt, loc}) => Collector.declaration(ident, loc)
    | _ => ()
    }
  };
  let enter_structure_item = str => {
    open Typedtree;
    switch str.str_desc {
    | Tstr_module({mb_id, mb_name: {txt, loc}}) => {
      Collector.declaration(mb_id, loc);
    }
    | _ => ()
    }
  };
  let enter_expression = (expr) => {
    open Typedtree;
    Collector.add(~depth=depth^, expr.exp_type, expr.Typedtree.exp_loc);
    switch expr.exp_desc {
    | Texp_for(ident, _, _, _, _, _) => {
      /* TODO I'm not super happy about this because the loc is not around the actual declaration :/ */
      /* But wait!! On the parsetree side, we do have a good loc. Soo we'll have to do extra work, but we can get it done. */
      Collector.declaration(ident, expr.Typedtree.exp_loc)
    }

    | Texp_let(isrec, bindings, rest) =>
      List.iter(
        (binding) => Collector.add(~depth=depth^, binding.vb_expr.exp_type, binding.vb_loc),
        bindings
      )
    | Texp_ident(path, {txt, loc}, value_description) => {
      Collector.ident(path, loc)
    }
    | Texp_record(items, ext) =>
      List.iter(
        ((loc, label, expr)) =>
          Collector.add(
            ~depth=depth^,
            expr.exp_type,
            ~mend=expr.exp_loc.Location.loc_end,
            loc.Asttypes.loc
          ),
        items
      ) /* TODO
      | Texp_construct loc desc args => Collector.add "constructor"  */
    | _ => ()
    };
    depth :=depth^ + 1;
  };
  let exit_expression = (expr) => depth :=depth^ - 1;
};



let ppos = (pos) =>
  Lexing.(
    Printf.sprintf(
      {|{"line": %d, "col": %d, "chars": %d}|},
      pos.pos_lnum,
      pos.pos_cnum - pos.pos_bol,
      pos.pos_cnum
    )
  );

let entry = (loc, ~depth, ~mend=?, typ) => {
  open Location;
  let mend =
    switch mend {
    | Some((x)) => x
    | None => loc.loc_end
    };
  Printf.sprintf(
    {|{"depth": %d, "start": %s, "end": %s, "type": %S}|},
    depth,
    ppos(loc.loc_start),
    ppos(mend),
    typ
  );
};


let type_to_string = (typ) => {
  Printtyp.type_expr(Format.str_formatter, typ);
  Format.flush_str_formatter();
};

type externalsUsed = list((Path.t, Location.t));

type bindings = Hashtbl.t(int, list((Ident.t, Location.t)));

  /**
   * Ok, so for things that have IDs, e.g. things in this file...
   * we will just have a mapping of {id: {declaration: opt(ident), usages: list((ident, loc))}}
   */
  /* let ident = (path, loc) => (); */
  /* let declaration = (ident, loc) => (); */

let truncateLoc = (length, {Location.loc_start, loc_end} as loc) => {
  ...loc,
  loc_start,
  loc_end: {
    ...loc_start,
    pos_cnum: loc_start.pos_cnum + length
  }
};

let collectTypes = annots => {
  let types = Hashtbl.create(100);
  let add = (~mend=?, ~depth=0, typ, loc) => if (!loc.Location.loc_ghost) {
    let loc_end = switch mend {
    | Some(m) => m
    | None => loc.Location.loc_end
    };
    Hashtbl.add(types, (loc.Location.loc_start, loc_end), typ)
  };
  let externals = ref([]);
  let bindings = Hashtbl.create(100);

  let declaration = (ident, loc) => {
    Hashtbl.replace(bindings, ident.Ident.stamp, ((ident, loc), []));
  };
  let ident = (path, loc) => {
    let {Ident.stamp, name} = Path.head(path);
    if (stamp == 0) {
      externals := [(path, loc), ...externals^]
    } else {
      let loc = truncateLoc(String.length(name), loc);
      switch (Hashtbl.find(bindings, stamp)) {
      | exception Not_found => print_endline("Getting an ident but stamp not defined " ++ string_of_int(stamp))
      /* | exception Not_found => failwith("Getting an ident but declaration not recorded: " ++ string_of_int(stamp)) */
      | (binding, uses) => Hashtbl.replace(bindings, stamp, (
        binding,
        [(path, loc), ...uses]
      ))
      }
    }
  };

  let module Config = {
    let add = add;
    let ident=ident;
    let declaration=declaration;
  };
  let module Iter = TypedtreeIter.MakeIterator((F(Config)));

  switch annots {
  | Cmt_format.Implementation(structure) => {
    Printtyped.implementation(Format.str_formatter, structure);
    Files.writeFile("./log_types.txt", Format.flush_str_formatter()) |> ignore;
    Iter.iter_structure(structure)
  }
  | _ => failwith("Not a valid cmt file")
  };

  (types, bindings, externals^)
};
