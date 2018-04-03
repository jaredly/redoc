
open Parsetree;

/*
 * TODO: figure out what things can be linked.
 * e.g. what modules expose what items.
 *
 * For linking to other things, I'm not sure what I can do.
 *
 * hmmm so I want "include" to show me things that link as well.
 * Look at Reprocessing_Types, Reprocessing.rei too
 *
 * Also referencing the things from another module.
 * Like `module Draw = ...`, have the contents there w/ IDs (& types?). (won't have docs, but thats ok)
 */

let allGlobals = ["int", "float", "string", "list", "option", "bool", "unit", "array", "char"];

let generate = (name, topdoc, stamps, allDocs) => {
  let mainMarkdown = switch (topdoc) {
  | None => GenerateDoc.defaultMain(~addHeading=true, name)
  | Some(doc) => doc
  };

  let formatHref = ((modName, inner, ptype)) => {
    let modName = if (modName == "<global>") {
      switch inner {
      | [name] when List.mem(name, allGlobals) => "globals"
      | _ => {
        print_endline("Cant find " ++ GenerateDoc.makeId(inner, ptype) ++ " in " ++ modName);
        name
      }
      }
    } else {
      modName
    };
    let hash = switch inner {
    | [] => ""
    | inner => "#" ++ GenerateDoc.makeId(inner, ptype)
    };
    if (modName == name) {
      hash
    } else {
      modName ++ ".html" ++ hash
    }
  };

  let (html, tocs) = GenerateDoc.docsForModule(formatHref, stamps, [], 0, name, mainMarkdown, allDocs);

  Printf.sprintf({|
    %s
    <div class='container'>
    %s
    <div class='main'>
    %s
    </div>
    <div class='right-blank'></div>
    </div>
  |}, DocsTemplate.head(name), Sidebar.generate(name, List.rev(tocs), []), html)

};

let interface = (name, intf) => {
  let stamps = PrepareDocs.organizeTypesIntf((name, []), intf.Typedtree.sig_items);
  let (topdoc, allDocs) = PrepareDocs.findAllDocsIntf(intf.Typedtree.sig_items);
  generate(name, topdoc, stamps, allDocs)
};

let implementation = (name, impl) => {
  let stamps = PrepareDocs.organizeTypes((name, []), impl.Typedtree.str_items);
  let (topdoc, allDocs) = PrepareDocs.findAllDocs(impl.Typedtree.str_items);
  generate(name, topdoc, stamps, allDocs)
};
