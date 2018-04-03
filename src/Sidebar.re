
let generate = (name, tocItems, projectListing) => {
  let main = tocItems |> List.map(((level, name, id, cls)) => {
    Printf.sprintf({|<a href="#%s" class='level-%d %s'>%s</a>|}, id, level, cls, name)
  }) |> String.concat("\n");
  Printf.sprintf({|
    <div class='sidebar-wrapper'>
    <div class='sidebar'>
    <div class='table-of-contents'>
    %s
    </div>
    %s
    </div>
    </div>
  |},
  main,
  projectListing == [] ? "" : "<div class='project-listing'><div class='project-title'>Package modules</div>" ++ {
    projectListing |> List.map(name => Printf.sprintf({|<a href="%s.html">%s</a>|}, name, name)) |> String.concat("\n")
  } ++ "</div>"
  )
};
