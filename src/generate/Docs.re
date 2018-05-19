
let allGlobals = ["int", "float", "string", "list", "option", "bool", "unit", "array", "char", "int64"];

let formatHref = (~warnMissing, name, projectNames, (modName, inner, ptype)) => {
  let modName = if (modName == "<global>") {
    switch inner {
    | [name] when List.mem(name, allGlobals) => "globals"
    | _ => {
      if (warnMissing) {
        print_endline("Cant find " ++ GenerateDoc.makeId(inner, ptype) ++ " in " ++ modName);
      };
      "globals"
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
    Some(hash)
  } else {
    if (List.mem(modName, projectNames)) {
      Some(modName ++ ".html" ++ hash)
    } else {
      None
    }
  }
};

open Infix;
let page = (~sidebar, ~sourceUrl, ~relativeToRoot, ~playgroundEnabled, ~checkHashes=false, name, tocs, projectNames, markdowns, contents) => {
  Printf.sprintf({|
    %s
    %s
    <div class='container'>
    %s
    <div class='main'>
    %s
    %s
    </div>
    <div class='right-blank'></div>
    </div>
  |}, DocsTemplate.head(~relativeToRoot, name),
  checkHashes ? "<script>window.shouldCheckHashes=true</script>" : "",
  Sidebar.generate(~sidebar, name, tocs, projectNames, markdowns, Infix.fileConcat(relativeToRoot, "search.html"), ~playgroundPath=playgroundEnabled ? Some(Infix.fileConcat(relativeToRoot, "playground.html")) : None),
  sourceUrl |?>> (url => {
    Printf.sprintf({|<a href="%s" class="edit-link">Edit</a>|}, url)
  }) |? "",
  contents)
};

let generate = (~sidebar, ~sourceUrl, ~relativeToRoot, ~playgroundEnabled, ~processDocString, name, topdoc, stamps, allDocs, projectNames, markdowns) => {
  let mainMarkdown = switch (topdoc) {
  | None => Omd.of_string(GenerateDoc.defaultMain(~addHeading=true, name))
  | Some(doc) => doc
  };

  let printer = GenerateDoc.printer(formatHref(~warnMissing=false, name, projectNames), stamps);
  let (html, tocs) = GenerateDoc.docsForModule(printer, processDocString, [], 0, name, mainMarkdown, allDocs);

  let projectListing = projectNames |> List.map(name => (name ++ ".html", name));
  page(~sidebar, ~sourceUrl, ~relativeToRoot, ~playgroundEnabled, ~checkHashes=true, name, List.rev(tocs), projectListing, markdowns, html)
};
