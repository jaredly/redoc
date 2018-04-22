
open Infix;

let slice = (s, pre, post) => String.sub(s, pre, String.length(s) - pre + post);
let startsWith = (prefix, string) => {
  let lp = String.length(prefix);
  lp <= String.length(string) && String.sub(string, 0, lp) == prefix
};

let rec iterDocBlocks = (fn, md) => Omd.Representation.visit(el => switch el {
  | Omd.Html_comment(text) when startsWith("<!--!", text) => {
    iterDocBlocks(fn, Omd.of_string(slice(text, 5, -3)));
    None
  }
  | Omd.Html_comment(text) => None
  | Omd.Code_block(lang, contents) => { fn(String.trim(lang), contents); None }
  | _ => None
}, md) |> ignore;

let iterBlocks = (modules, custom, fn) => {
  modules |> List.iter(({State.Model.docs, name, items}) => {
    docs |?< iterDocBlocks(fn(name, Some(name)));
    items |> List.iter(State.Model.Docs.iter(((_, docString, _)) => docString |?< iterDocBlocks(fn(name, Some(name)))));
  });
  custom |> List.iter(({State.Model.contents, title}) => iterDocBlocks(fn(title ++ "_md", None), contents));
};

let collectBlocks = (modules, custom, defaultOptions) => {
  let codeBlocks = ref([]);
  let alt = ref(None);
  iterBlocks(modules, custom, (page, moduleName, lang, content) => switch (CodeSnippets.parseCodeOptions(lang, defaultOptions |? State.Model.defaultOptions)) {
  | None => ()
  | Some(options) => {
    /* print_endline("Block: " ++ lang ++ " : " ++ State.Model.showLang(options.lang)); */
    let parts = Str.split(Str.regexp_string(";"), String.trim(lang));

    /* let syntax = List.mem("alt", parts) ? (options.lang == OCaml ? State.Model.Reason : State.Model.OCaml) : options.lang; */
    /* TODO add "autoOpen" flag */
    /* let prefix = switch moduleName {
    | None => ""
    | Some(name) => "open " ++ name ++ (syntax == State.Model.OCaml ? "" : ";") ++ "\n"
    }; */
    if (List.mem("alt", parts)) {
      alt := Some((lang, content, options));
      /* print_endline("Alt block\n" ++ prefix ++ content); */
    } else {
      codeBlocks := [(page, moduleName, lang, content, options, alt^), ...codeBlocks^];
      alt := None;
    }
  }
  });
  codeBlocks^;
};

let resolveShared = codeBlocks => {
  let shared = Hashtbl.create(10);

  codeBlocks |> List.iter(((_, _, _, content, options, alt)) => {
    switch (options.State.Model.sharedAs) {
    | None => ()
    | Some(name) => {
      if (alt != None) {
        failwith("Shared blocks can't have an `alt` attached to them")
      };
      if (Hashtbl.mem(shared, name)) {
        print_endline("Warning! shared() name must be unique within a package: " ++ name);
        print_endline("This will soon be an error");
      };
      Hashtbl.add(shared, name, (content, options));
    }
    };
  });

  let started = Hashtbl.create(Hashtbl.length(shared));
  let processed = Hashtbl.create(Hashtbl.length(shared));

  let rec getFullShared = (name) => {
    switch (Hashtbl.find(processed, name)) {
    | exception Not_found => {
      if (Hashtbl.mem(started, name)) {
        failwith("Recursive dependency in shared() block " ++ name);
      };
      Hashtbl.add(started, name, true);

      let (content, options) = Hashtbl.find(shared, name);
      let newContent = CodeSnippets.fullContent(getFullShared, options, content);
      Hashtbl.add(processed, name, newContent);
      newContent
    }
    | newContent => newContent
    }
  };

  shared |> Hashtbl.iter((name, _) => ignore(getFullShared(name)));

  processed;
};

let openPrefix = (syntax, name) => "#open " ++ name ++ (syntax == State.Model.OCaml ? "" : ";") ++ "\n";
let otherSyntax = syntax => syntax == State.Model.OCaml ? State.Model.Reason : State.Model.OCaml;

let codeFromPackage = ({
  State.Model.name,
  modules,
  custom,
  namespaced,
  backend,
  defaultCodeOptions,
}) => {
  let codeBlocks = collectBlocks(modules, custom, defaultCodeOptions);
  let shared = resolveShared(codeBlocks);

  open State.Model;
  let processedCodeBlocks = codeBlocks |> List.map(((page, moduleName, lang, content, options, alt)) => {
    let fullContent = switch (options.State.Model.sharedAs) {
    | None => CodeSnippets.fullContent(Hashtbl.find(shared), options, content)
    | Some(name) => Hashtbl.find(shared, name)
    };
    let fullContent = (moduleName |?>> openPrefix(options.lang) |? "") ++ fullContent;
    let altLang = otherSyntax(options.lang);
    let alt = switch alt {
    | None => None
    | Some((lang, content, options)) => Some((
      options,
      (moduleName |?>> openPrefix(altLang) |? "") ++ CodeSnippets.fullContent(Hashtbl.find(shared),
      options, content)))
    };
    (page, lang, content, fullContent, options, alt)
  });

  processedCodeBlocks |> List.filter(((_, _, _, _, options, alt)) => options.State.Model.expectation != Skip)
};
