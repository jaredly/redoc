
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

let getName = x => Filename.basename(x) |> Filename.chop_extension;
let isReadme = path => Filename.check_suffix(String.lowercase(path), "/readme.md");
let asHtml = path => Filename.chop_extension(path) ++ ".html";

let htmlName = path => {
  print_endline("Path for html name " ++ path);
  if (isReadme(path)) {
    print_endline("Readme folks " ++ path);
    String.sub(path, 0, String.length(path) - String.length("/readme.md")) /+ "index.html"
  } else {
    asHtml(path)
  }
};

let getTitle = (path, base) => {
  if (isReadme(path)) {
    let dir = Filename.dirname(path);
    print_endline(path ++ " base " ++ base ++ " dir " ++ dir);
    if (dir == base) {
      print_endline("Base dir!!!");
      "Home"
    } else {
      Filename.basename(dir)
    }
  } else {
    getName(path)
  }
};

let parseCustom = (base, (absPath, sourcePath, destPath)) => {
  let title = getTitle(absPath, base);
  /* let destPath = sourcePath |?>> htmlName |? title ++ ".html"; */
  if (sourcePath == None) {
    print_endline("What no source path");
  };
  print_endline("absPath " ++ absPath ++ " title " ++ title ++ " dest " ++ destPath);
  {
    title,
    sourcePath,
    destPath,
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
    custom: List.map(parseCustom(root), customFiles),
    namespaced: false, /* TODO */
    backend,
    defaultCodeOptions: None,
    modules: processModules(moduleFiles),
  }
};
