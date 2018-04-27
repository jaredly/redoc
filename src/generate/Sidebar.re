
let makeToc = tocItems => {
  tocItems |> List.map(((level, name, id, cls)) => {
    Printf.sprintf({|<a href="#%s" class='level-%d %s'>%s</a>|}, id, level, cls, name)
  }) |> String.concat("\n");
};

let showPackage = projectListing => {
  "<div class='project-title'>Package modules</div><div class='project-listing'>" ++ {
    projectListing |> List.map(((htmlName, name)) => Printf.sprintf({|<a href="%s">%s</a>|}, htmlName, name)) |> String.concat("\n")
  } ++ "</div>"
};

let makeMarkdowns = markdowns => {
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

let generate = (name, tocItems, projectListing, markdowns, searchPath, ~playgroundPath) => {
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
  makeMarkdowns(markdowns),
  makeToc(tocItems),
  projectListing == [] ? "" : showPackage(projectListing)
  )
};
