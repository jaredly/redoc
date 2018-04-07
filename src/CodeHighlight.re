
open Typedtree;

let addHtmlEscapedToBuffer = (buffer, char) => {
  /* Handle htmlentities */
  switch char {
  | ('0'..'9' | 'a'..'z' | 'A'..'Z') as c => Buffer.add_char(buffer, c)
  | '"' => Buffer.add_string(buffer, "&quot;")
  | '\'' => Buffer.add_string(buffer, "&#39;")
  | '&' => Buffer.add_string(buffer, "&amp;")
  | '<' => Buffer.add_string(buffer, "&lt;")
  | '>' => Buffer.add_string(buffer, "&gt;")
  | c => Buffer.add_char(buffer, c)
  };
};

let annotateText = (tags, inserts, text, offset) => {
  let tags = tags |> List.sort(((aStart, aEnd, _), (bStart, bEnd, _)) => {
    let startDiff = aStart - bStart;
    /** If they start at the same time, the *larger* range should go First */
    if (startDiff === 0) {
      aEnd - bEnd
    } else {
      startDiff
    }
  }) |> List.filter(((st, en, _)) => st >= offset && en >= offset) |> List.map(((st, en, t)) => (st - offset, en - offset, t));

  let positions = String.length(text) + 1;

  let tag_starts = Array.make(positions, []);
  let tag_closes = Array.make(positions, 0);
  tags |> List.iter(((cstart, cend, attributes)) => {
    tag_starts[cstart] = [attributes, ...tag_starts[cstart]];
    /* print_endline(string_of_int(cend)); */
    tag_closes[cend] = tag_closes[cend] + 1;
  });

  let extra_inserts = Array.make(positions, []);
  inserts |> List.iter(((pos, text)) => {
      extra_inserts[pos] = [text, ...extra_inserts[pos]]
  });

  let b = Buffer.create(String.length(text));
  let rec loop = (i) => {
    if (i >= positions) {
      ()
    } else {
      if (tag_closes[i] != 0) {
        let rec loop = i => if (i > 0) {
          Buffer.add_string(b, "</span>");
          loop(i - 1)
        };
        loop(tag_closes[i])
      };

      if (extra_inserts[i] != []) {
        List.iter(Buffer.add_string(b), extra_inserts[i])
      };

      if (tag_starts[i] != []) {
        List.iter(attributes => Buffer.add_string(b, "<span " ++ attributes ++ ">"), tag_starts[i])
      };

      if (i < positions - 1) {
        addHtmlEscapedToBuffer(b, text.[i]);
      };

      loop(i + 1);
    }
  };
  loop(0);

  Buffer.to_bytes(b) |> Bytes.to_string
};

let showType = typ => PrintType.default.expr(PrintType.default, typ) |> GenerateDoc.prettyString;

Printexc.record_backtrace(true);

let iterTags = (cmt, addTag) => {
  let addColor = (loc, className) => addTag(loc, "class='" ++ className ++ "'");
  let addColorType = (loc, className, typ) => addTag(loc, "class='" ++ className ++ "' data-type=\"" ++ showType(typ) ++ "\"");
  let addType = (loc, typ) => addTag(loc, "data-type=\"" ++ showType(typ) ++ "\"");
  /* TODO report types with all of this probably? */
  let module Iter = {
    include TypedtreeIter.DefaultIteratorArgument;
    let enter_expression = ({exp_desc, exp_loc, exp_type}) => {
      let addColorT = (loc, cls) => addColorType(loc, cls, exp_type);
      switch exp_desc {
      /* TODO dive into the longident */
      | Texp_ident(path, {txt: Lident(text), loc}, _) when !(text.[0] >= 'a' && text.[0] <= 'z') => addColorT(loc, "operator")
      | Texp_ident(path, {txt, loc}, _) => addColorT(loc, "ident")
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
      | Ttyp_constr(path, {txt, loc}, args) => addColor(loc, "type-constructor")
      | _ => ()
      }
    };
    let enter_pattern = ({pat_desc, pat_loc, pat_type}) => {
      switch pat_desc {
      | Tpat_var(path, {txt, loc}) => addColorType(loc, "pattern-ident", pat_type)
      /* | Tpat_construct({txt, loc}, desc, args) => addColorType(loc, "patern-constructor", pat_type) */
      | Tpat_construct({txt: Lident("::"), loc}, desc, args) => addType(loc, pat_type)
      | Tpat_construct({txt, loc}, desc, args) => addColorType(loc, "pattern-constructor", pat_type)
      | Tpat_constant(Const_int(_)) => addColorType(pat_loc, "int", pat_type)
      | Tpat_constant(Const_float(_)) => addColorType(pat_loc, "float", pat_type)
      | Tpat_constant(Const_string(_)) => addColorType(pat_loc, "string", pat_type)
      | _ => ()
      }
    };
  };
  let module IterIter = TypedtreeIter.MakeIterator(Iter);

  let iter_part = part => switch part {
  | Cmt_format.Partial_structure(str) => IterIter.iter_structure(str)
  | Partial_structure_item(str) => IterIter.iter_structure_item(str)
  | Partial_signature(str) => IterIter.iter_signature(str)
  | Partial_signature_item(str) => IterIter.iter_signature_item(str)
  | Partial_expression(expression) => IterIter.iter_expression(expression)
  | Partial_pattern(pattern) => IterIter.iter_pattern(pattern)
  | Partial_class_expr(class_expr) => IterIter.iter_class_expr(class_expr)
  | Partial_module_type(module_type) => IterIter.iter_module_type(module_type)
  };

  switch cmt {
  | Cmt_format.Implementation(str) => {
    IterIter.iter_structure(str);
  }
  | Cmt_format.Interface(sign) => {
    IterIter.iter_signature(sign);
  }
  | Cmt_format.Partial_implementation(parts)
  | Cmt_format.Partial_interface(parts) => {
    Array.iter(iter_part, parts);
  }
  | _ => failwith("Not a valid cmt file")
  };
};

let collectRanges = (cmt) => {
  let tags = ref([]);
  iterTags(cmt, (loc, tag) => loc.Location.loc_ghost ? () : tags := [(loc, tag), ...tags^]);
  tags^;
};

let removeIfThere = path => Files.exists(path) ? Unix.unlink(path) : ();

let highlight = (text, cmt) => {
  /* print_endline("Highlith " ++ cmt); */
  if (Files.exists(cmt)) {
    let {Cmt_format.cmt_annots, cmt_builddir, cmt_sourcefile, cmt_modname, cmt_comments} = Cmt_format.read_cmt(cmt);
    /* Unix.unlink(cmt); */
    let base = cmt |> Filename.chop_extension;
    /* removeIfThere(base ++ ".cmi"); */
    /* removeIfThere(base ++ ".cmj"); */
    /* removeIfThere(base ++ ".mlast"); */
    /* removeIfThere(base ++ ".mlast.d"); */
    let partial = switch cmt_annots {
    | Cmt_format.Partial_implementation(_) | Cmt_format.Partial_interface(_) => true
    | _ => false
    };
    /* print_endline(cmt_modname ++ " built in " ++ cmt_builddir); */
    /* switch cmt_sourcefile {
    | None => print_endline("No source file")
    | Some(f) => print_endline("Source: " ++ f)
    }; */
    cmt_comments |> List.iter(((text, loc)) => {
      print_endline("Comment: " ++ text);
    });
    /* print_newline(); */

    if (partial) {
      print_endline("⚠️  ⚠️  ⚠️ Compilation failed!!");
      print_newline();
      print_endline(text);
      print_newline();
    };

    let lines = Str.split(Str.regexp_string("\n"), text);
    let rec loop = (offset, lines) => {
      switch lines {
      | [] => (offset, "")
      | [line, ...rest] when line != "" && line.[0] == '#' => {
        loop(offset + String.length(line) + 1, rest)
      }
      | _ => (offset, String.concat("\n", lines))
      }
    };
    let (offset, text) = loop(0, lines);

    let ranges = collectRanges(cmt_annots);
    let tags = ranges |> List.map((({Location.loc_start: {pos_cnum}, loc_end: {pos_cnum: cend}}, attributes)) => {
      (pos_cnum, cend, attributes)
    });
    let inserts = []; /* TODO annotate "open"s? */
    annotateText(tags, inserts, text, offset) ++ (partial ? "<div style='color: red'>Compilation failed!!</div>" : "")
  } else {
    Omd_utils.htmlentities(text) ++ "<strong>Compilation failed!</strong>"
  }
};