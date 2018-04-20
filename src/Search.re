
let replace = (one, two, text) => Str.global_replace(Str.regexp_string(one), two, text);
let escape = text => replace("\\", "\\\\", text)
|> replace("\\@", "\\\\@")
|> replace("\n", "\\n")
|> replace("\"", "\\\"");

let serializeSearchable = ((href, title, contents, rendered, breadcrumb)) => {
  Printf.sprintf({|{"href": "%s", "title": "%s", "contents": "%s", "rendered": "%s", "breadcrumb": "%s"}|},
  escape(href),
  escape(title),
  escape(contents),
  escape(rendered),
  escape(breadcrumb)
  )
};

let serializeSearchables = searchables => "[" ++ String.concat(",\n", List.map(serializeSearchable, searchables)) ++ "]";
