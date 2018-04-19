
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
  | Omd.Code_block(lang, contents) => { fn(lang, contents); None }
  | _ => None
}, md) |> ignore;

let iterBlocks = (modules, custom, fn) => {
  modules |> List.iter(({State.Model.docs, name, items}) => {
    docs |?< iterDocBlocks(fn(name));
    items |> List.iter(State.Model.Docs.iter(((_, docString, _)) => docString |?< iterDocBlocks(fn(name))));
  });
  custom |> List.iter(({State.Model.contents, title}) => iterDocBlocks(fn(title), contents));
};

let collectBlocks = (modules, custom) => {
  let codeBlocks = ref([]);
  iterBlocks(modules, custom, (page, lang, content) => switch (CodeSnippets.parseCodeOptions(lang)) {
  | None => ()
  | Some(options) => codeBlocks := [(page, lang, content, options), ...codeBlocks^]
  });
  codeBlocks^;
};

let resolveShared = codeBlocks => {
  let shared = Hashtbl.create(10);

  codeBlocks |> List.iter(((_, _, content, options)) => {
    switch (options.State.Model.sharedAs) {
    | None => ()
    | Some(name) => {
      if (Hashtbl.mem(shared, name)) {
        failwith("shared() name must be unique within a package");
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

let codeFromPackage = ({
  State.Model.name,
  modules,
  custom,
  namespaced,
  backend,
  defaultCodeOptions,
  compiledDependencyDirectories
}) => {
  /* Will this also do the processing?
  maybe not yet. It will return code units ready to be compiled etc. */

  /** TODO defaultCodeOptions */
  let codeBlocks = collectBlocks(modules, custom);
  let shared = resolveShared(codeBlocks);

  let processedCodeBlocks = codeBlocks |> List.map(((page, lang, content, options)) => {
    let fullContent = switch (options.State.Model.sharedAs) {
    | None => CodeSnippets.fullContent(Hashtbl.find(shared), options, content)
    | Some(name) => Hashtbl.find(shared, name)
    };
    (page, lang, content, fullContent, options)
  });

  processedCodeBlocks
};

