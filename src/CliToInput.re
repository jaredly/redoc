
open Infix;

let (/+) = Filename.concat;

let fail = (msg) => {
  print_endline(msg);
  exit(1);
};

let optMap = (fn, items) => List.fold_left((result, item) => switch (fn(item)) { | None => result | Some(res) => [res, ...result]}, [], items);

let shouldExist = (message, v) => Files.exists(v) ? v : fail(message ++ ": " ++ v);
let oneShouldExist = (message, items) => {
  let rec loop = left => switch left {
  | [] => fail(message ++ " Looked at " ++ String.concat(", ", items))
  | [one, ...more] => Files.exists(one) ? one : loop(more)
  };
  loop(items)
};

let startsWith = (text, prefix) => String.length(prefix) <= String.length(text)
  && String.sub(text, 0, String.length(prefix)) == prefix;

let findMarkdownFiles = (target, base) => {
  Files.collect(target, name => Filename.check_suffix(name, ".md")) |> List.map(path => {
    (path, if (startsWith(target, base)) { Some(Files.relpath(base, path)) } else {None})
  });
};

/**
 * Returns a list of paths, relative to the provided `base`
 */
let getSourceDirectories = (base, config) => {
  let rec handleItem = (current, item) => {
    switch item {
    | Json.Array(contents) => List.map(handleItem(current), contents) |> List.concat
    | Json.String(text) => [current /+ text]
    | Json.Object(_) =>
      let dir = Json.get("dir", item) |?> Json.string |? "Must specify directory";
      let backend = item |> Json.get("backend") |?> Json.array |?>> optMap(Json.string) |? ["js"];
      /* print_endline("Backend? " ++ String.concat(" & ", backend)); */
      let typ = item |> Json.get("type") |?> Json.string |? "lib";
      if (typ == "dev" || !List.mem("js", backend)) {
        []
      } else {
        [current /+ dir, ...switch (item |> Json.get("subdirs")) {
        | None => []
        | Some(Json.True) => Files.collectDirs(base /+ current /+ dir) |> List.map(Files.relpath(base))
        | Some(item) => handleItem(current /+ dir, item)
        }]
      }
    | _ => failwith("Invalid subdirs entry")
    };
  };
  config |> Json.get("sources") |?>> handleItem("") |? []
};


let isNative = config => Json.get("entries", config) != None || Json.get("allowed-build-kinds", config) != None;

let getDependencyDirs = (base, config) => {
  let deps = config |> Json.get("bs-dependencies") |?> Json.array |? [] |> optMap(Json.string);
  deps |> List.map(name => {
    let loc = base /+ "node_modules" /+ name;
    switch (Files.readFile(loc /+ "bsconfig.json")) {
    | Some(text) =>
      let inner = Json.parse(text);
      let allowedKinds = inner |> Json.get("allowed-build-kinds") |?> Json.array |?>> List.map(Json.string |.! "allowed-build-kinds must be strings") |? ["js"];
      let isNative = isNative(inner);
      let compiledBase = oneShouldExist("Cannot find directory for compiled artifacts.",
        isNative
          ? [loc /+ "lib/bs/js", loc /+ "lib/bs/native"]
          : [loc /+ "lib/bs", loc /+ "lib/ocaml"]
      );
      if (List.mem("js", allowedKinds)) {
        getSourceDirectories(loc, inner) |> List.map(name => (
          compiledBase /+ name,
          loc /+ "lib/js" /+ name,
        ));
      } else {
        []
      }
    | None =>
      print_endline("Skipping dependency: " ++ name);
      []
    }
  }) |> List.concat
};

let isSourceFile = name =>
  Filename.check_suffix(name, ".re")
  || Filename.check_suffix(name, ".rei")
  || Filename.check_suffix(name, ".ml")
  || Filename.check_suffix(name, ".mli");

let compiledName = name => Filename.chop_extension(name) ++ (name.[String.length(name) - 1] == 'i' ? ".cmti" : ".cmt");

let findProjectFiles = root => {
  let config = Json.parse(Files.readFile(root /+ "bsconfig.json") |! "No bsconfig.json found");
  let isNative = isNative(config);
  let compiledBase = oneShouldExist("Cannot find directory for compiled artifacts.",
    isNative
      ? [root /+ "lib/bs/js", root /+ "lib/bs/native"]
      : [root /+ "lib/bs", root /+ "lib/ocaml"]
  );
  getSourceDirectories(root, config) |> List.map(Filename.concat(root)) |> List.map(name => Files.collect(name, isSourceFile)) |> List.concat
  |> List.map(path => {
    let rel = Files.relpath(root, path);
    (compiledBase /+ compiledName(rel), rel)
  })
};

let findDependencyDirectories = root => {
  let config = Json.parse(Files.readFile(root /+ "bsconfig.json") |! "No bsconfig.json found");
  let isNative = isNative(config);
  let compiledBase = oneShouldExist("Cannot find directory for compiled artifacts.",
    isNative
      ? [root /+ "lib/bs/js", root /+ "lib/bs/native"]
      : [root /+ "lib/bs", root /+ "lib/ocaml"]
  );
  let jsBase = Files.ifExists(root /+ "lib/js") |! "lib/js not found";
  let mine = [compiledBase, ...Files.collectDirs(compiledBase)] |> List.map(path => (path, jsBase /+ Files.relpath(compiledBase, path)));
  mine @ getDependencyDirs(root, config)
};











let help = {|
# docre - a clean & easy documentation generator

Usage: docre [options]

  --root (default: current directory)
      expected to contain bsconfig.json, and bs-platform in the node_modules
  --target (default: {root}/docs)
      where we should write out the docs
  --name (default: the name of the directory, capitalized)
      what this project is called
  --project-file
      specified as /abs/path/to/.cmt:rel/path/from/repo/root
  --dependency-directory
      a directory containing ".cmj" files that should be '-I'd when compiling snippets
  --bs-root (default: root/node_modules/bs-platform)
  --doctest (default: false)
      execute the documentation snippets to make sure they run w/o erroring
  -h, --help
      print this help
|};

let fail = (msg) => {
  print_endline(msg);
  print_endline(help);
  exit(1);
};

let parse = Minimist.parse(
  ~alias=[("h", "help"), ("test", "doctest")],
  ~presence=["help", "doctest"],
  ~multi=["project-file", "dependency-directory"],
  ~strings=["target", "root", "name", "bs-root"]
);

open State.Input;

let getRefmt = bsRoot => {
  Files.ifExists(bsRoot /+ "lib/refmt3.exe") |?? Files.ifExists(bsRoot /+ "lib/refmt.exe")
};

let getPackageJsonName = config => {
  Json.get("name", config) |?>> (Json.string |.! "name must be a string")
};

let optsToInput = (selfPath, {Minimist.strings, multi: multiMap, presence}) => {
  open Minimist;
  let root = get(strings, "root") |? Unix.getcwd();
  let bsRoot = get(strings, "bs-root") |?>> shouldExist("provided bs-root doesn't exist") |?? Files.ifExists(root /+ "node_modules/bs-platform");
  let refmt = get(strings, "refmt") |?>> shouldExist("provided refmt doesn't exist") |?? (bsRoot |?> getRefmt);
  let target = get(strings, "target") |? (root /+ "docs");
  let projectName = get(strings, "name") |? String.capitalize(Filename.basename(root));
  let projectFiles = multi(multiMap, "project-file") |> List.map(line => {
    switch (Str.split(Str.regexp_string(":"), line)) {
    | [cmt, relpath] => (cmt, relpath)
    | _ => fail("Invalid project file " ++ line)
    }
  });
  let dependencyDirectories = multi(multiMap, "dependency-directory") |> List.map(line => {
    switch (Str.split(Str.regexp_string(":"), line)) {
    | [cmt, js] => (cmt, js)
    | _ => fail("Invalid dependency directory " ++ line)
    }
  });

  let packageJson = Files.ifExists(root /+ "package.json") |?>> (Files.readFile |.! "Unable to read package.json") |?>> Json.parse;
  {
    env: {
      static: Filename.dirname(selfPath) /+ "../../../static"
    },
    target: {
      directory: target,
      search: true,
      template: None,
    },
    packageInput: {
      meta: {
        packageName: projectName,
        repo: None, /* TODO get this */
      },
      root,
      backend: (packageJson |?> getPackageJsonName |?> packageJsonName => bsRoot |?> bsRoot => refmt |?>> refmt => State.Bucklescript({
        bsRoot,
        packageRoot: root,
        refmt,
        tmp: root /+ "node_modules/.docre",
        compiledDependencyDirectories: dependencyDirectories == [] ? findDependencyDirectories(root) : dependencyDirectories,
        packageJsonName,
      })) |? NoBackend,
      sidebarFile: None,
      customFiles: findMarkdownFiles(target, root),
      moduleFiles: projectFiles == [] ? findProjectFiles(root) : projectFiles,
    },
  };
};

let parse = argv => {
  let (selfPath, args) = switch (Array.to_list(argv)) {
  | [] => fail("Unable to determine my location")
  | [selfPath, ...args] => (selfPath, args)
  };

  switch (parse(args)) {
  | Minimist.Error(err) => fail(Minimist.report(err))
  | Ok(opts) => optsToInput(selfPath, opts)
  }
};
