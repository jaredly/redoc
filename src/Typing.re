
module type Collector = {
  let add: (~mend: Lexing.position=?, ~depth: int=?, Types.type_expr, Location.t) => unit;
  let ident: (Path.t, Location.t) => unit;
  let declaration: (Ident.t, Location.t) => unit;
  let open_: (Path.t, Location.t) => unit;
};

module F = (Collector: Collector) => {
  include TypedtreeIter.DefaultIteratorArgument;
  let depth = ref(0);

  type openn = {mutable used: list(Longident.t), path: Path.t, loc: Location.t};
  type open_stack = {
    mutable closed: list(openn),
    mutable opens: list(openn),
    parent: option(open_stack)
  };
  let root_stack = {opens: [{
    used: [],
    loc: Location.none,
    path: Path.Pident({
      Ident.name: "Pervasives",
      stamp: 0,
      flags: 1,
    })
  }], parent: None, closed: []};
  let closed_stacks = ref([]);
  let open_stack = ref(root_stack);
  let new_stack = () => open_stack := {parent: Some(open_stack^), opens: [], closed: []};
  let pop_stack = () => switch (open_stack^.parent) {
  | Some(parent) => {
    print_endline("Popping");
    closed_stacks := [open_stack^, ...closed_stacks^];
    open_stack := parent
  }
  | None => ()
  };

  let add_open = (path, loc) => {
    print_endline("Add open " ++ Path.name(path));
    open_stack^.opens = [{path, loc, used: []}, ...open_stack^.opens];
  };
  let pop_open = () => {
    switch (open_stack^.opens) {
    | [] => ()
    | [top, ...rest] => {
      open_stack^.opens = rest;
      open_stack^.closed = [top, ...open_stack^.closed];
    }
    }
  };

  let rec usesOpen = (ident, path) => switch (ident, path) {
  | (Longident.Lident(name), Path.Pdot(path, pname, _)) => true
  | (Longident.Lident(_), Path.Pident(_)) => false
  | (Longident.Ldot(ident, _), Path.Pdot(path, _, _)) => usesOpen(ident, path)
  | _ => failwith("Cannot relative "  ++ Path.name(path))
  };

  let rec relative = (ident, path) => switch (ident, path) {
  | (Longident.Lident(name), Path.Pdot(path, pname, _)) when pname == name => path
  | (Longident.Ldot(ident, _), Path.Pdot(path, _, _)) => relative(ident, path)
  | _ => failwith("Cannot relative "  ++ Path.name(path))
  };

  let add_use = (path, ident, loc) => {
    let openNeedle = relative(ident, path);
    let rec loop = stack => {
      let rec inner = opens => switch opens {
      | [] => switch stack.parent {
      | Some(parent) => loop(parent)
      | None => print_endline("Unable to find an open to meet my needs: " ++ String.concat(".", Longident.flatten(ident))  )
      }
      | [{path} as one, ...rest] when Path.same(path, openNeedle) =>  {
        /* print_endline("Matched " ++ Path.name(path) ++ " "); */
        one.used = [ident, ...one.used];
      }
      | [_, ...rest] => inner(rest)
      };
      inner(stack.opens)
    };
    loop(open_stack^)
  };



  let enter_core_type = (typ) => {
    open Typedtree;
    Collector.add(~depth=depth^, typ.ctyp_type, typ.ctyp_loc);
    switch typ.ctyp_desc {
    | Ttyp_constr(path, {txt, loc}, args) => {
      if (usesOpen(txt, path)) {
        add_use(path, txt, loc);
      };
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
    | Tstr_value(isrec, bindings) =>
      List.iter(
        (binding) => Collector.add(binding.vb_expr.exp_type, binding.vb_loc),
        bindings
      )
    | Tstr_module({mb_id, mb_name: {txt, loc}}) => {
      Collector.declaration(mb_id, loc);
      new_stack();
    }
    | Tstr_open({open_path, open_txt: {txt, loc}}) => {
      if (usesOpen(txt, open_path)) {
        add_use(open_path, txt, loc);
      };
      Collector.ident(open_path, loc);
      Collector.open_(open_path, loc);
      add_open(open_path, loc);
    }
    | _ => ()
    }
  };
  let leave_structure_item = str => Typedtree.(switch str.str_desc {
  | Tstr_module(_) => pop_stack()
  | _ => ()
  });
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
      if (usesOpen(txt, path)) {
        add_use(path, txt, loc);
      };
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
    expr.exp_extra |> List.iter(((ex, loc, _)) => switch ex {
    | Texp_open(_, path, {txt, loc}, _) => add_open(path, loc)
    | _ => ()
    });
    depth :=depth^ + 1;
  };
  let leave_expression = (expr) => {
    depth :=depth^ - 1;
    open Typedtree;
    expr.exp_extra |> List.iter(((ex, loc, _)) => switch ex {
    | Texp_open(_, path, {txt, loc}, _) => pop_open()
    | _ => ()
    });
  };
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

  let open_ = (path, loc) => ();

  let module Config = {
    let add = add;
    let ident=ident;
    let declaration=declaration;
    let open_ = open_;
  };
  let module IterSource = F(Config);
  let module Iter = TypedtreeIter.MakeIterator(IterSource);

  switch annots {
  | Cmt_format.Implementation(structure) => {
    Printtyped.implementation(Format.str_formatter, structure);
    Files.writeFile("./log_types.txt", Format.flush_str_formatter()) |> ignore;
    Iter.iter_structure(structure)
  }
  | _ => failwith("Not a valid cmt file")
  };

  open IterSource;
  let all_opens = IterSource.root_stack.opens @ IterSource.root_stack.closed @ List.concat(
    List.map(op => op.opens @ op.closed, IterSource.closed_stacks^)
  );
  print_endline(string_of_int(List.length(all_opens)));
  all_opens |> List.iter(({path, loc, used}) => {
    print_endline(Path.name(path) ++ ": " ++ String.concat(", ", List.map(n => String.concat(".", Longident.flatten(n)), used)));
  });

  (types, bindings, externals^)
};
