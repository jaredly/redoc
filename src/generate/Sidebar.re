
let makeToc = tocItems => {
  tocItems |> List.map(((level, name, id, cls)) => {
    Printf.sprintf({|<a href="#%s" class='level-%d %s'>%s</a>|}, id, level, cls, name)
  }) |> String.concat("\n");
};

let fastIn = items => {
  let map = Hashtbl.create(List.length(items));
  items |> List.iter(i => Hashtbl.replace(map, i, true));
  Hashtbl.mem(map)
};

let makeLink = ((htmlName, name)) => Printf.sprintf({|<a href="%s">%s</a>|}, htmlName, name);

let showPackage = (~sidebar, projectListing) => {
  let (topModules, otherModules) = switch sidebar {
  | Some({State.Model.pages: []})
  | None => (projectListing, [])
  | Some({State.Model.pages, modules}) => {
    let top = modules |> List.map(name => List.find(((_, n)) => n == name, projectListing));
    let inTop = fastIn(top);
    (top, List.filter(m => !inTop(m), projectListing))
  }
  };
  "<div class='project-title'>Package modules</div><div class='project-listing'>" ++ {
    (List.map(makeLink, topModules) |> String.concat("\n")) ++
    (if (otherModules != []) {
      "<div style='margin-top:16px;font-style:italic'>Other modules</div>" ++
      (otherModules |> List.map(makeLink) |> String.concat("\n"))
    } else {
      ""
    })
  } ++ "</div>"
};

let makeMarkdowns = (~sidebar, markdowns) => {
  if (markdowns == []) {
    ""
  } else {
    "<div class='docs-listing'>" ++ {
      markdowns |> List.map(((path, name)) => {
        Printf.sprintf({|<a href="%s">%s</a>|}, path, name)
      }) |> String.concat("\n")
    } ++ "</div>"
  }
};

open Infix;

let generate = (~sidebar, name, tocItems, projectListing, markdowns, searchPath, ~playgroundPath) => {
  Printf.sprintf({|
    <div class='sidebar-wrapper'>
    <div class='sidebar-expander'>Show navigation</div>
    <div class='sidebar'>
      <a href="%s" style="display: block; padding: 0 8px;">Search</a>
      %s
      %s
      <div class='toc-header'>Page Contents</div>
      <div class='table-of-contents'>
      %s
      </div>
      %s
    </div>
    </div>
  |},
  searchPath,
  playgroundPath |?>> Printf.sprintf({|<a href="%s" style="display: block; padding: 0 8px;">Playground</a>|}) |? "",
  makeMarkdowns(~sidebar, markdowns),
  makeToc(tocItems),
  projectListing == [] ? "" : showPackage(~sidebar, projectListing)
  )
};
