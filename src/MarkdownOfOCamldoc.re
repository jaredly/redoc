
open Comment;

let withStyle = (style, contents) => switch style {
| `Bold => Omd.Bold(contents)
| `Italic => Omd.Emph(contents)
| `Emphasis => Omd.Emph(contents)
| `Superscript => Omd.Raw("Superscript")
| `Subscript => Omd.Raw("Subscript")
};

let stripLoc = (fn, item) => fn(item.Location_.value);

let whiteLeft = text => {
  let ln = String.length(text);
  let rec loop = i => {
    i >= ln ? i - 1 : (text.[i] == ' ' ? loop(i + 1) : i)
  };
  loop(0)
};

let sliceToEnd = (text, num) => {
  let ln = String.length(text);
  if (ln <= num) {
    ""
  } else {
    String.sub(text, num, ln - num)
  }
};

let stripLeft = text => {
  let lines = Str.split(Str.regexp_string("\n"), text);
  let rec loop = lines => switch lines {
  | [] => 0
  | [one] => whiteLeft(one)
  | [one, ...more] => min(whiteLeft(one), loop(more))
  };
  let min = loop(lines |> List.filter(x => String.trim(x) != ""));
  String.concat("\n", List.map(line => sliceToEnd(line, min), lines))
};

let convertItem = (currentModule, item) => {

  let rec convertItem = item => switch item.Location_.value {
  | `Heading(level, label, content) => Omd.Text("!!!! heading")
  | `Tag(`Example(contents)) => Omd.Paragraph(List.map(stripLoc(convertNestable), contents))
  | `Tag(tag) => Omd.Text("!!!! tag")
  | #nestable_block_element as item => convertNestable(item)
  } and convertNestable = item => switch item {
  | `Paragraph(inline) => Omd.Paragraph(List.map(convertInline, inline))
  | `Code_block(text) => Omd.Code_block("ml", "#open " ++ currentModule ++ "\n" ++ stripLeft(text))
  | `Verbatim(text) => Omd.Raw(text) /* TODO */
  | `Modules(modules) => Omd.Raw("!!!! Modules please")
  | `List(`Ordered, children) => Omd.Ol(List.map(List.map(stripLoc(convertNestable)), children))
  | `List(`Unordered, children) => Omd.Ul(List.map(List.map(stripLoc(convertNestable)), children))
  }
  and convertInline = item => switch item.Location_.value {
  | `Link(href, content) => Omd.Url(href, List.map(convertLink, content), "")
  | `Styled(style, contents) => withStyle(style, List.map(convertInline, contents))
  | `Reference(someref, link) => Omd.Url("#TODO-ref", [Omd.Text("REFERENCE"), ...List.map(convertLink, link)], "")
  | #leaf_inline_element as rest => convertLeaf(rest)
  }
  and convertLink = item => switch item.Location_.value {
  | `Styled(style, contents) => withStyle(style, List.map(convertLink, contents))
  | #leaf_inline_element as rest => convertLeaf(rest)
  }
  and convertLeaf = (item: Comment.leaf_inline_element) => switch item {
  | `Space => Omd.Text(" ")
  | `Word(text) => Omd.Text(text)
  | `Code_span(text) => Omd.Code("", text)
  }
  ;
  convertItem(item)
};

let convert = (currentModule, text) => {
  let res = Parser_.parse_comment(
    ~permissive=true,
    ~sections_allowed=`All,
    ~containing_definition=Paths.Identifier.Root({Root.package: "hi", file: Page("hi"), digest: "hi"}, "What"),
    ~location=Lexing.dummy_pos,
    ~text
  );
  switch res.result {
  | Error.Ok(docs) => List.map(convertItem(currentModule), docs)
  | Error(message) => [Omd.Text("failed to parse: " ++ Error.to_string(message))]
  }
};