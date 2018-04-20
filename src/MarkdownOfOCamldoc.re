
/* open Octavius_types; */

let withStyle = (style, contents) => switch style {
| `Bold => Omd.Bold(contents)
| `Italic => Omd.Emph(contents)
| `Emphasis => Omd.Emph(contents)
| `Superscript => Omd.Raw("Superscript")
| `Subscript => Omd.Raw("Subscript")
};

let rec convertItem = item => switch item.Location_.value {
| `Heading(level, label, content) => Omd.Text("heading")
| `Tag(tag) => Omd.Text("tag")

/* | Raw(text) => Omd.Raw(text)
| Code(text) => Omd.Code_block("", text) */
| _ => {
  convertNestable(item)
  /* Octavius_print.pp(Format.str_formatter); */
  /* Omd.Raw_block(Format.flush_str_formatter()); */
  /* Omd.Raw_block("Other") */
}
} and convertNestable = item => switch item.Location_.value {
| `Paragraph(inline) => Omd.Paragraph(List.map(convertInline, inline))
| _ => Omd.Text("wat")
}
and convertInline = item => switch item.Location_.value {
| `Link(href, content) => Omd.Url(href, List.map(convertLink, content), "")
| _ => Omd.Text("wat")
}
and convertLink = item => switch item.Location_.value {
| `Styled(style, contents) => withStyle(style, List.map(convertLink, contents))
| `Space => Omd.Text(" ")
| `Word(text) => Omd.Text(text)
| `Code_span(text) => Omd.Code("", text)
/* | _ => convertLeaf(item) */
}
and convertLeaf = (item: Comment.with_location(Comment.leaf_inline_element)) => switch item.Location_.value {
| `Space => Omd.Text(" ")
| `Word(text) => Omd.Text(text)
| `Code_span(text) => Omd.Code("", text)
}
;

let convert = text => {
  /* let ocamldoc = Octavius.parse(Lexing.from_string(text));
  switch ocamldoc {
  | Octavius.Ok((items, tags)) => {
    List.map(convertItem, items)
  }
  | Error({Errors.error, location}) => {
    print_endline("Failed to parse ocamldoc " ++ Errors.message(error));
    [Omd.Text("Failed to parse folks: " ++ text ++ " because " ++ Errors.message(error))]
  }
  } */
  let res = Parser_.parse_comment(
    ~permissive=true,
    ~sections_allowed=`All,
    ~containing_definition=Paths.Identifier.Root({Root.package: "hi", file: Page("hi"), digest: "hi"}, "What"),
    ~location=Lexing.dummy_pos,
    ~text
  );
  switch res.result {
  | Error.Ok(docs) => List.map(convertItem, docs)
  /* | Ok(`Stop) => [Omd.Text("Stop?")] */
  | Error(message) => [Omd.Text("failed to parse")]
  }
  /* [Omd.Text(text)] */
};