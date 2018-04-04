
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

let generate = (~cssLoc, ~jsLoc, name, topdoc, stamps, allDocs, projectNames, markdowns) => {
  let mainMarkdown = switch (topdoc) {
  | None => GenerateDoc.defaultMain(~addHeading=true, name)
  | Some(doc) => doc
  };

  let (html, tocs) = GenerateDoc.docsForModule(formatHref(name, projectNames), stamps, [], 0, name, mainMarkdown, allDocs);

  Printf.sprintf({|
    %s
    <div class='container'>
    %s
    <div class='main'>
    %s
    </div>
    <div class='right-blank'></div>
    </div>
  |}, DocsTemplate.head(~cssLoc?, ~jsLoc?, name), Sidebar.generate(name, List.rev(tocs), projectNames, markdowns), html)
};
