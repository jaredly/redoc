


module type Collector = {
  let add: (~mend: Lexing.position=?, ~depth: int=?, Types.type_expr, Location.t) => unit;
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
  let enter_pattern = (pat) => Typedtree.(Collector.add(~depth=depth^, pat.pat_type, pat.pat_loc));
  let enter_core_type = (typ) => Typedtree.(Collector.add(~depth=depth^, typ.ctyp_type, typ.ctyp_loc));
  let enter_type_declaration = (typ) =>
    Typedtree.(
      switch typ.typ_type.Types.type_manifest {
      | Some((x)) => Collector.add(~depth=depth^, x, typ.typ_loc)
      | _ => ()
      }
    );
  let enter_expression = (expr) => {
    open Typedtree;
    Collector.add(~depth=depth^, expr.exp_type, expr.Typedtree.exp_loc);
    switch expr.exp_desc {
    | Texp_let(isrec, bindings, rest) =>
      List.iter(
        (binding) => Collector.add(~depth=depth^, binding.vb_expr.exp_type, binding.vb_loc),
        bindings
      )
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

let display_type = (typ, ~depth=0, ~mend=?, loc) =>
  Location.(
    if (! loc.loc_ghost) {
      try {
        let txt = entry(loc, ~depth=depth, ~mend=?mend, type_to_string(typ));
        print_endline(txt);
      } {
      | _ => ()
      };
    }
  );

let findTypes = ( path) =>
  {
    open Cmt_format;
    let {cmt_annots, cmt_comments, cmt_imports} = read_cmt(path);
    let types = ref([]);
    module Iter =
      TypedtreeIter.MakeIterator(
        (
          F(
            {
              let add = (~mend=?, ~depth=0, typ, loc) => if (!loc.Location.loc_ghost) {
                types:=[(typ, loc, mend, depth), ...types^];
              }
            }
          )
        )
      );
    switch cmt_annots {
    | Implementation(structure) =>
      Iter.iter_structure(structure);
      List.iter(
        ((typ, loc, mend, depth)) =>
          display_type(typ, ~depth=depth, ~mend=?mend, loc),
        types^
      );
    | _ => exit(1)
    };
  };
