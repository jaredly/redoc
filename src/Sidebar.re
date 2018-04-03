
let generate = (name, tocItems, _projectListing) => {
  let main = tocItems |> List.map(((level, name, id, cls)) => {
    Printf.sprintf({|<a href="#%s" class='level-%d %s'>%s</a>|}, id, level, cls, name)
  }) |> String.concat("\n");
  Printf.sprintf({|
    <div class='sidebar-wrapper'>
    <div class='sidebar'>
    %s
    </div>
    </div>
  |}, main)
};
