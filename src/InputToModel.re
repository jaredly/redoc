
open Infix;
open! State.Model;

let parseSidebar = path => {
  let contents = Json.parse(Files.readFile(path) |! "Sidebar file does not exist") |> Json.array |! "Sidebar json must be an array";
  let rec loop = item => switch item {
  | Json.String(path) => State.Model.SidebarItem(path)
  | Json.Object(contents) => State.Model.SidebarHeader(
    List.assoc("title", contents) |> Json.string |! "Title must be a string",
    List.assoc("contents", contents) |> Json.array |! "Contents must be a list" |> List.map(loop)
  )
  | _ => failwith("Invalid sidebar file")
  };
  List.map(loop, contents)
};

let parseCustom = ((absPath, sourcePath)) => {
  {
    title: Filename.basename(absPath) |> Filename.chop_extension |> String.capitalize,
    sourcePath,
    /* destPath:  */
    contents: Omd.of_string(Files.readFile(absPath) |! "Unable to read markdown file " ++ absPath)
  }
};

let getDocableItems = cmt => {
  ("Hello", None, Module({contents: Items([])}))
};

let processCmt = cmt => {
  (None, [])
};

let processModules = moduleFiles => {
  let hash = Hashtbl.create(100);
  moduleFiles |> List.iter(((cmt, sourcePath)) => {
    let (topDocs, contents) = processCmt(cmt);
    let name = Filename.chop_extension(cmt);
    Hashtbl.replace(hash, name, {
      name,
      sourcePath,
      docs: topDocs,
      contents,
    })
  });
  hash
};

let package = ({State.Input.meta: {packageName, repo}, root, sidebarFile, customFiles, moduleFiles, compiledDependencyDirectories}, {State.Input.bsRoot, refmt, static}) => {
  {
    name: packageName,
    repo,
    sidebar: sidebarFile |?>> parseSidebar,
    custom: List.map(parseCustom, customFiles),
    namespaced: false, /* TODO */
    backend: Bucklescript,
    defaultCodeOptions: None,
    modules: processModules(moduleFiles),
    compiledDependencyDirectories,
  }
};
