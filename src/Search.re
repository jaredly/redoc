
let escape = text => {
  let ln = String.length(text);
  let buf = Buffer.create(ln);
  let rec loop = i => {
    if (i < ln) {
      switch (text.[i]) {
      | '\\' => Buffer.add_string(buf, "\\\\")
      | '\"' => Buffer.add_string(buf, "\\\"")
      | '\n' => Buffer.add_string(buf, "\\n")
      | c => Buffer.add_char(buf, c)
      };
      loop(i + 1)
    }
  };
  loop(0);
  Buffer.contents(buf)
};

let replace = (one, two, text) => Str.global_replace(Str.regexp_string(one), two, text);
/* let escape = text => text
|> replace({|\ |}, "\\\\ ")
|> replace("\\@", "\\\\@")
|> replace("\\", "\\\\")
|> replace("\n", "\\n")
|> replace("\"", "\\\""); */

let serializeSearchable = ((href, title, contents, rendered, breadcrumb)) => {
  /* if (String.contains()) */
  Printf.sprintf({|{"href": "%s", "title": "%s", "contents": "%s", "rendered": "%s", "breadcrumb": "%s"}|},
  escape(href),
  escape(title),
  /* "", */
  escape(contents),
  /* "", */
  escape(rendered),
  escape(breadcrumb)
  )
};

let serializeSearchables = searchables => "[" ++ String.concat(",\n", List.map(serializeSearchable, searchables)) ++ "]";
