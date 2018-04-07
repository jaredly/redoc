
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

let annotateText = (tags, inserts, text) => {
  let tags = tags |> List.sort(((aStart, aEnd, _), (bStart, bEnd, _)) => {
    let startDiff = aStart - bStart;
    /** If they start at the same time, the *larger* range should go First */
    if (startDiff === 0) {
      bEnd - aEnd
    } else {
      startDiff
    }
  });

  let tag_starts = Array.make(String.length(text), []);
  let tag_closes = Array.make(String.length(text), 0);
  tags |> List.iter(((cstart, cend, attributes)) => {
    tag_starts[cstart] = [attributes, ...tag_starts[cstart]];
    tag_closes[cend] = tag_closes[cend] + 1;
  });

  let extra_inserts = Array.make(String.length(text), []);
  inserts |> List.iter(((pos, text)) => {
      extra_inserts[pos] = [text, ...extra_inserts[pos]]
  });

  let b = Buffer.create(String.length(text));
  let rec loop = (i) => {
    if (i >= Array.length(tag_closes)) {
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

      addHtmlEscapedToBuffer(b, text.[i]);

      loop(i + 1);
    }
  };
  loop(0);

  Buffer.to_bytes(b) |> Bytes.to_string
};

let iterTags = (cmt, addTag) => {
  /* TODO report types with all of this probably? */
  let module Iter = {
    include TypedtreeIter.DefaultIteratorArgument;
    let enter_expression = ({exp_desc, exp_loc}) => {
      switch exp_desc {
      /* TODO dive into the longident */
      | Texp_ident(path, {txt: Lident(text), loc}, _) when !(text.[0] >= 'a' && text.[0] <= 'z') => addTag(loc, "operator")
      | Texp_ident(path, {txt, loc}, _) => addTag(loc, "ident")
      | Texp_constant(Const_int(_)) => addTag(exp_loc, "int")
      | Texp_constant(Const_float(_)) => addTag(exp_loc, "float")
      | Texp_constant(Const_string(_)) => addTag(exp_loc, "string")
      | Texp_construct({txt, loc}, desc, args) => addTag(loc, "constructor")
      /* | Texp_variant */
      | _ => ()
      }
    };
    let enter_core_type = ({ctyp_desc, ctyp_loc: loc}) => {
      switch ctyp_desc {
      | Ttyp_var(string) => addTag(loc, "type-vbl")
      | Ttyp_constr(path, {txt, loc}, args) => addTag(loc, "type-constructor")
      | _ => ()
      }
    };
    let enter_pattern = ({pat_desc, pat_loc}) => {
      switch pat_desc {
      | Tpat_var(path, {txt, loc}) => addTag(loc, "pattern-ident")
      | Tpat_construct({txt, loc}, desc, args) => addTag(loc, "patern-constructor")
      | Tpat_constant(Const_int(_)) => addTag(pat_loc, "int")
      | Tpat_constant(Const_float(_)) => addTag(pat_loc, "float")
      | Tpat_constant(Const_string(_)) => addTag(pat_loc, "string")
      | _ => ()
      }
    };
  };
  let module IterIter = TypedtreeIter.MakeIterator(Iter);
  let annots = Cmt_format.read_cmt(cmt).Cmt_format.cmt_annots;

  switch annots {
  | Cmt_format.Implementation(str) => {
    IterIter.iter_structure(str)
  }
  | Cmt_format.Interface(sign) => {
    IterIter.iter_signature(sign)
  }
  | _ => failwith("Not a valid cmt file")
  };
};

let collectRanges = (cmt) => {
  let tags = ref([]);
  iterTags(cmt, (loc, tag) => loc.Location.loc_ghost ? () : tags := [(loc, tag), ...tags^]);
  tags^;
};

let highlight = (text, cmt) => {
  let ranges = collectRanges(cmt);
  let tags = ranges |> List.map((({Location.loc_start: {pos_cnum}, loc_end: {pos_cnum: cend}}, className)) => {
    (pos_cnum, cend, "class='" ++ className ++ "'")
  });
  let inserts = []; /* TODO annotate "open"s? */
  annotateText(tags, inserts, text)
};