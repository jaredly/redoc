
open Parsetree;

let allGlobals = ["int", "float", "string", "list", "option", "bool", "unit", "array", "char"];

let formatHref = (name, projectNames, (modName, inner, ptype)) => {
  let modName = if (modName == "<global>") {
    switch inner {
    | [name] when List.mem(name, allGlobals) => "globals"
    | _ => {
      print_endline("Cant find " ++ GenerateDoc.makeId(inner, ptype) ++ " in " ++ modName);
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

let page = (~relativeToRoot, ~cssLoc, ~jsLoc, ~checkHashes=false, name, tocs, projectNames, markdowns, contents) => {
  Printf.sprintf({|
    %s
    %s
    <div class='container'>
    %s
    <div class='main'>
    %s
    </div>
    <div class='right-blank'></div>
    </div>
  |}, DocsTemplate.head(~relativeToRoot, ~cssLoc?, ~jsLoc?, name),
  checkHashes ? "<script>window.shouldCheckHashes=true</script>" : "",
  Sidebar.generate(name, tocs, projectNames, markdowns, Filename.concat(relativeToRoot, "search.html")), contents)
};

let generate = (~relativeToRoot, ~cssLoc, ~jsLoc, ~processDocString, name, topdoc, stamps, allDocs, projectNames, markdowns) => {
  let mainMarkdown = switch (topdoc) {
  | None => GenerateDoc.defaultMain(~addHeading=true, name)
  | Some(doc) => doc
  };

  let printer = GenerateDoc.printer(formatHref(name, projectNames), stamps);
  let (html, tocs) = GenerateDoc.docsForModule(printer, processDocString, [], 0, name, mainMarkdown, allDocs);

  let projectListing = projectNames |> List.map(name => (name ++ ".html", name));
  page(~relativeToRoot, ~cssLoc, ~jsLoc, ~checkHashes=true, name, List.rev(tocs), projectListing, markdowns, html)
};
