
open Infix;

let rec takeN = (items, i) => i <= 0 ? [] : switch items {
| [] => []
| [one, ...rest] => [one, ...takeN(rest, i - 1)]
};

let itemColor = item => switch item {
| State.Model.Docs.Type(_) => "#faa"
| Value(_) => "#afa"
| Module(_) => "#aaf"
| _ => "#eee"
};

let prefix = item => String.sub(State.Model.Docs.itemName(item), 0, 1);

let firstFewItems = items => {
  open State.Model.Docs;
  items
  |> List.filter(((_, _, i)) => switch i {
  /* TODO handle includes */
  | Value(_) | Type(_) | Module(_) => true
  | _ => false
  })
  |> List.sort(((n1, _, i1), (n2, _, i2)) => {
    switch (i1, i2) {
    | (Value(_), Value(_)) => compare(n1, n2)
    | (Value(_), _) => -1
    | (_, Value(_)) => 1
    | (Type(_), Type(_)) => compare(n1, n2)
    | (Type(_), _) => -1
    | (_, Type(_)) => 1
    | _ => compare(n1, n2)
    }
  })
  |> List.map(((name, _, item)) =>
  "<span style='background-color:" ++ itemColor(item) ++ ";border-radius:50%;padding:0 2px;margin-right: 4px'>" ++ prefix(item) ++ "</span>"
  ++ name) |> String.concat("\n")
};

let showType = typ => GenerateDoc.prettyString(~width=100, PrintType.default.expr(PrintType.default, typ));

let getFunctionArgs = t => switch (PrintType.collectArgs([], t)) {
| ([], _) => None
| (args, _) => Some(args |> List.rev |> List.map(((label, typ)) => {
  if (label != "" && label.[0] == '?') {
    let label = String.sub(label, 1, String.length(label) - 1);
    open Types;
    switch (typ.desc) {
    | Tconstr(Path.Pident({stamp, name: "option"}), [arg], _) => (label, showType(arg) ++ " (optional)")
    | _ => ("?" ++ label, showType(typ))
    }
  } else {
    (label, showType(typ))
  }
}))
};

let showItemType = (name, item, modulesAtPath) => {
  open State.Model.Docs;
  switch item {
  | Value(v) => {
    let t = PrintType.default.value(PrintType.default, name, name, v) |> GenerateDoc.prettyString(~width=100);
    (getFunctionArgs(v) |?>> (args => args |> List.map(arg => Json.Array([Json.String(fst(arg)), Json.String(snd(arg))])) |> items => Json.Array(items) ), Json.String(t));
  }
  | Type(t) => (None, Json.String(PrintType.default.decl(PrintType.default, name, name, t) |> GenerateDoc.prettyString(~width=100)))
  | Module(Items(items)) => (None, Json.String(firstFewItems(items)))
  | Module(Alias(aliasPath)) => (None, Json.String(switch (Hashtbl.find(modulesAtPath, Path.name(aliasPath))) {
    | exception Not_found => ""
    | children => firstFewItems(children)
    }))
  | _ => (None, Json.String(""))
  }
};

let getCompletionData = modules => {
  let items = ref([]);
  let add = i => items := [i, ...items^];

  let modulesAtPath = Hashtbl.create(10);
  modules |> List.iter(({State.Model.name, items}) => {
    Hashtbl.replace(modulesAtPath, name, items);
    items |> List.iter(State.Model.Docs.iterWithPath(~modulesAtPath, [name], (path, (name, _, item)) => {
      switch item {
      | Module(Items(items)) => Hashtbl.replace(modulesAtPath, List.rev([name, ...path]) |> String.concat("."), items)
      | _ => ()
      }
    }))
  });

  modules |> List.iter(({State.Model.name, items}) => {
    add(([], name, (None, Json.String(firstFewItems(items))), None, "module"));
    items |> List.iter(State.Model.Docs.iterWithPath(~modulesAtPath, [name], (path, (name, docString, item)) => {
      switch item {
      | Value(_) | Type(_) | Module(_) => add((List.rev(path), name, showItemType(name, item, modulesAtPath), docString |?>> Omd.to_html, State.Model.Docs.itemName(item)))
      | _ => ()
      }
    }));
  });
  items^
};

let writeEditorSupport = (static, directory, modules, (browserCompilerPath, compilerDepsBuffer)) => {
  Files.copyExn(~source=browserCompilerPath, ~dest=directory /+ "bucklescript.js");
  let out = open_out(directory /+ "bucklescript-deps.js");
  Buffer.output_buffer(out, compilerDepsBuffer);
  close_out(out);

  let completionData = Json.stringify(Json.Array(getCompletionData(modules) |> List.map(((path, name, (args, typ), docs, kind)) => Json.Object([
    ("path", Json.String(String.concat(".", path))),
    ("name", Json.String(name)),
    ("type", typ),
    ("docs", docs |?>> (docs => Json.String(docs)) |? Json.Null),
    ("kind", Json.String(kind)),
    ...(args |?>> (args => [("args", args)]) |? [])
  ]))));
  Files.writeFileExn(directory /+ "completion-data.js", "[].push.apply(window.complationData, " ++ completionData ++ ")");
  Files.copyExn(~source=static /+ "bs-3.0.0-completion.js", ~dest=directory /+ "bucklescript-stdlib-completion.js");

  Files.ifExists(directory /+ "examples") |?< examplesDir => Files.collect(examplesDir, name => Filename.check_suffix(name, ".re")) |> List.map(example => {
    let title = Filename.basename(example) |> Filename.chop_extension;
    let contents = Files.readFileExn(example);
    Json.Object([("title", Json.String(title)), ("code", Json.String(contents))])
  }) |> examples => Files.writeFileExn(directory /+ "playground-examples.js", "window.examplesData = " ++ Json.stringify(Json.Array(examples)));

  ["jsx-ppx.js",
  "refmt.js",
  "colors.js",
  "playground.html",
  "playground.js",
  "codemirror-5.36.0/lib/codemirror.js",
  "codemirror-5.36.0/lib/codemirror.css",
  "codemirror-5.36.0/mode/rust/rust.js",
  "codemirror-5.36.0/addon/comment/comment.js",
  "codemirror-5.36.0/addon/edit/closebrackets.js",
  "codemirror-5.36.0/addon/edit/matchbrackets.js",
  "codemirror-5.36.0/addon/hint/show-hint.js",
  "codemirror-5.36.0/addon/hint/show-hint.css",
  "codemirror-5.36.0/addon/mode/simple.js"]
  |> List.iter(name => {
    Files.copyExn(~source=static /+ name, ~dest=directory /+ Filename.basename(name));
  });
};

let makeSearchPage = (~playgroundEnabled, ~markdowns, ~names, dest, searchables) => {
  let path = dest /+ "search.html";
  let rel = Files.relpath(Filename.dirname(path));
  let markdowns = List.map(({State.Model.title, destPath, contents}) => (destPath, title), markdowns);
  let projectListing = names |> List.map(name => (rel(dest /+ "api" /+ name ++ ".html"), name));
  let main = Printf.sprintf({|
    <input placeholder="Search the docs" id="search-input"/>
    <style>%s</style>
    <div id="search-results"></div>
    <link rel=stylesheet href="search.css">
    <script defer src="searchables.json.index.js"></script>
    <script defer src="elasticlunr.js"></script>
    <script defer src="search.js"></script>
  |}, DocsTemplate.searchStyle);
  let html = Docs.page(~playgroundEnabled, ~sourceUrl=None, ~relativeToRoot=rel(dest), "Search", [], projectListing, markdowns, main);
  Files.writeFile(path, html) |> ignore;
  Files.writeFile(dest /+ "search.js", SearchScript.js) |> ignore;
  Files.writeFile(dest /+ "elasticlunr.js", ElasticRaw.raw) |> ignore;
  Files.writeFile(dest /+ "searchables.json", Search.serializeSearchables(searchables^)) |> ignore;
  MakeIndex.run(dest /+ "elasticlunr.js", dest /+ "searchables.json")
};

let outputCustom = (~playgroundEnabled, dest, markdowns, searchHref, repo, processDocString, names, {State.Model.title, destPath, sourcePath, contents}) => {
  let path = dest /+ destPath;

  let rel = Files.relpath(Filename.dirname(path));
  let (tocItems, override) = GenerateDoc.trackToc(~lower=true, 0, Markdown.linkifyMarkdown(path, dest));
  let searchPrinter = GenerateDoc.printer(searchHref, []);
  let m: (string, string, ~override:(Omd.element => option(string))=?, list(string), string, option(State.Model.Docs.docItem)) => Omd.t => string = processDocString(searchPrinter);
  let main = m(path, title, ~override=override, [], title, None, contents);

  let sourceUrl = repo |?> (url => sourcePath |?>> (sourcePath => url /+ sourcePath));

  let markdowns = List.map(({State.Model.title, destPath}) => (rel(dest /+ destPath), title), markdowns);
  let projectListing = names |> List.map(name => (rel(dest /+ "api" /+ name ++ ".html"), name));
  let html = Docs.page(~playgroundEnabled, ~sourceUrl, ~relativeToRoot=rel(dest), title, List.rev(tocItems^), projectListing, markdowns, main);

  Files.writeFile(path, html) |> ignore;
};

let outputModule = (~playgroundEnabled, dest, codeBlocksMap, markdowns, searchHref, repo, processDocString, names, {State.Model.name, sourcePath, docs, items, stamps}) => {
  let output = dest /+ "api" /+ name ++ ".html";
  let rel = Files.relpath(Filename.dirname(output));

  let markdowns = List.map(({State.Model.title, destPath, contents}) => (rel(dest /+ destPath), title), markdowns);

  let searchPrinter = GenerateDoc.printer(searchHref, stamps);
  let sourceUrl = repo |?>> (url => url /+ sourcePath);
  let text = Docs.generate(
    ~playgroundEnabled,
    ~sourceUrl,
    ~relativeToRoot=rel(dest),
    ~processDocString=processDocString(searchPrinter, output, name),
    name,
    docs,
    stamps,
    items,
    names,
    markdowns
  );

  Files.writeFileExn(output, text);
};

let makeCodeBlocksMap = codeBlocks => {
  let map = Hashtbl.create(100);
  codeBlocks |> List.iter(({State.Model.langLine, raw, page, filePath: name} as block) => {
    Hashtbl.replace(map, (langLine, raw), block)
  });
  map
};

let searchHref = (names, doc) => {
  switch (Docs.formatHref("", names, doc)) {
  | None => None
  | Some(href) => Some("./api/" ++ href)
  }
};

open State;

let package = (
  {State.Model.name, repo, custom, sidebar, modules},
  compilationResults,
  {State.Input.directory, template, search},
  {State.Input.static}
) => {
  Files.mkdirp(directory);

  let (codeBlocks, playgroundEnabled) = compilationResults |?>> (((codeBlocks, bundles)) => {
    Files.copyExn(~source=static /+ "block-script.js", ~dest=directory /+ "block-script.js");
    let playgroundEnabled = bundles |?>> (((runtimeDeps, compilerDeps)) => {
      Files.writeFileExn(directory /+ "all-deps.js", runtimeDeps ++ ";window.loadedAllDeps = true;");
      /* This is where we handle stuff for the editor. should be named "editorArtifacts" or something */
      compilerDeps |?< writeEditorSupport(static, directory, modules);
      true
    }) |? false;
    (codeBlocks, playgroundEnabled);
  }) |? ([], false);

  let cssLoc = Filename.concat(directory, "styles.css");
  let jsLoc = Filename.concat(directory, "script.js");

  Files.copyExn(static /+ "styles.css", cssLoc);
  Files.copyExn(static /+ "script.js", jsLoc);

  /* Files.mkdirp(directory /+ "fonts"); */
  Files.copyDeep(~source=static /+ "fonts", ~dest=directory /+ "fonts");

  let codeBlocksMap = makeCodeBlocksMap(codeBlocks);

  let names = modules |> List.map(({Model.sourcePath, name}) => name);

  let (searchables, processDocString) = Markdown.makeDocStringProcessor(directory, element => switch element {
  | Omd.Code_block(lang, content) => {
    let lang = String.trim(lang);
    let parts = Str.split(Str.regexp_string(";"), lang);
    if (List.mem("alt", parts)) {
      Some("")
    } else {
      switch (Hashtbl.find(codeBlocksMap, (lang, content))) {
      | exception Not_found => {
        switch (CodeSnippets.parseCodeOptions(lang, State.Model.defaultOptions)) {
        | Some({codeDisplay: {hide: true}}) => Some("")
        | _ => None
        }
      }
      | {raw, html} => Some(html)
      }
    }
  }
  | _ => None
  });

  Files.mkdirp(directory /+ "api");

  modules |> List.iter(outputModule(~playgroundEnabled, directory, codeBlocks, custom, searchHref(names), repo, processDocString, names));

  custom |> List.iter(outputCustom(~playgroundEnabled, directory, custom, searchHref(names), repo, processDocString, names));

  makeSearchPage(~playgroundEnabled, ~markdowns=custom, ~names, directory, searchables);

  print_endline("Ok packaged folks " ++ directory);

  let localUrl = "file://" ++ Files.absify(directory) /+ "index.html";
  print_newline();
  print_endline("Complete! Docs are available in " ++ directory ++ "\nOpen " ++ localUrl ++ " in your browser to view");
  print_newline();
};
