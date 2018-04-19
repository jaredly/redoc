
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

let processCmt = (name, cmt) => {
  let annots = Cmt_format.read_cmt(cmt).Cmt_format.cmt_annots;

  switch annots {
  | Cmt_format.Implementation({str_items} as s) => {
    /* Printtyped.implementation(Format.str_formatter, s);
    let out = Format.flush_str_formatter();
    Files.writeFile("debug_" ++ name ++ ".typ.inft", out) |> ignore; */

    let stamps = CmtFindStamps.stampsFromTypedtreeImplementation((name, []), str_items);
    let (topdoc, allDocs) = CmtFindDocItems.docItemsFromStructure(str_items);
    (stamps, topdoc, allDocs)
  }
  | Cmt_format.Interface({sig_items} as s) => {
    /* Printtyped.interface(Format.str_formatter, s);
    let out = Format.flush_str_formatter();
    Files.writeFile("debug_" ++ name ++ ".typ.inft", out) |> ignore; */

    let stamps = CmtFindStamps.stampsFromTypedtreeInterface((name, []), sig_items);
    let (topdoc, allDocs) = CmtFindDocItems.docItemsFromSignature(sig_items);
    (stamps, topdoc, allDocs)
  }
  | _ => failwith("Not a valid cmt file")
  };
};

let processModules = moduleFiles => {
  moduleFiles |> List.map(((cmt, sourcePath)) => {
    let name = Filename.basename(cmt) |> Filename.chop_extension |> String.capitalize;
    let (stamps, topDocs, items) = processCmt(name, cmt);
    {
      name,
      sourcePath,
      docs: topDocs,
      items,
      stamps,
    }
  });
};

let package = ({State.Input.meta: {packageName, repo}, backend, root, sidebarFile, customFiles, moduleFiles}) => {
  {
    name: packageName,
    repo,
    sidebar: sidebarFile |?>> parseSidebar,
    custom: List.map(parseCustom, customFiles),
    namespaced: false, /* TODO */
    backend,
    defaultCodeOptions: None,
    modules: processModules(moduleFiles),
  }
};
