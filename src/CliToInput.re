
open Infix;

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

let ifOneExists = (items) => {
  let rec loop = left => switch left {
  | [] => None
  | [one, ...more] => Files.exists(one) ? Some(one) : loop(more)
  };
  loop(items)
};

let startsWith = (text, prefix) => String.length(prefix) <= String.length(text)
  && String.sub(text, 0, String.length(prefix)) == prefix;

let findMarkdownFiles = (projectName, target, base) => {
  let targetIsInBase = startsWith(target, base);
  let foundFiles = Files.collect(~checkDir=name => {
    print_endline(name);
    name != target /+ "fonts"
  }, target, name => Filename.check_suffix(name, ".md"))
  |> List.map(path => {
    (path, if (targetIsInBase) { Some(Files.relpath(base, path)) } else {None},
      Files.relpath(target, String.lowercase(Filename.basename(path)) == "readme.md"
      ? Filename.dirname(path) /+ "index.html"
      : Filename.chop_extension(path) ++ ".html")
    )
  });
  let isTopLevelReadme = path =>
    String.lowercase(path) == String.lowercase(target) /+ "readme.md" ||
    String.lowercase(path) == String.lowercase(target) /+ "index.md";
  if (!List.exists(((path, _, _)) => isTopLevelReadme(path), foundFiles) && Files.exists(base /+ "Readme.md")) {
    let readme = base /+ "Readme.md";
    let readmeName = Files.readDirectory(base) |> List.find(name => String.lowercase(name) == "readme.md");
    let readme = base /+ readmeName;
    [(base /+ readmeName, Some(readmeName), "./index.html"), ...foundFiles]
  } else {
    foundFiles
  }
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
        [(compiledBase, loc /+ "lib/js"), ...(getSourceDirectories(loc, inner) |> List.map(name => (
          compiledBase /+ name,
          loc /+ "lib/js" /+ name,
        )))];
      } else {
        []
      }
    | None =>
      print_endline("Skipping dependency: " ++ name);
      []
    }
  }) |> List.concat
};

let isCompiledFile = name =>
  Filename.check_suffix(name, ".cmt")
  || Filename.check_suffix(name, ".cmti");

let isSourceFile = name =>
  Filename.check_suffix(name, ".re")
  || Filename.check_suffix(name, ".rei")
  || Filename.check_suffix(name, ".ml")
  || Filename.check_suffix(name, ".mli");

let compiledNameSpace = name => Str.split(Str.regexp_string("-"), name) |> List.map(String.capitalize) |> String.concat("");

let compiledName = (~namespace, name) =>
  Filename.chop_extension(name)
  ++ (switch namespace { | None => "" | Some(n) => "-" ++ compiledNameSpace(n) })
  ++ (name.[String.length(name) - 1] == 'i' ? ".cmti" : ".cmt");

let getName = x => Filename.basename(x) |> Filename.chop_extension;
let filterDuplicates = cmts => {
  /* Remove .cmt's that have .cmti's */
  let intfs = Hashtbl.create(100);
  cmts |> List.iter(path => if (Filename.check_suffix(path, ".rei") || Filename.check_suffix(path, ".mli") || Filename.check_suffix(path, ".cmti")) {
    Hashtbl.add(intfs, getName(path), true)
  });
  cmts |> List.filter(path => {
    !((Filename.check_suffix(path, ".re") || Filename.check_suffix(path, ".ml") || Filename.check_suffix(path, ".cmt")) && Hashtbl.mem(intfs, getName(path)))
  });
};

let ifDebug = (debug, name, fn, v) => {
  if (debug) {
    print_endline(name ++ ": " ++ fn(v))
  };
  v
};

let findProjectFiles = (~debug, ~namespace, root) => {
  let config = Json.parse(Files.readFile(root /+ "bsconfig.json") |! "No bsconfig.json found");
  let isNative = isNative(config);
  let compiledBase = oneShouldExist("Cannot find directory for compiled artifacts.",
    isNative
      ? [root /+ "lib/bs/js", root /+ "lib/bs/native"]
      : [root /+ "lib/bs", root /+ "lib/ocaml"]
  );
  getSourceDirectories(root, config)
  |> ifDebug(debug, "Source directories from bsconfig", items => String.concat("\n", items))
  |> List.map(Infix.fileConcat(root))
  |> List.sort(compare)
  |> ifDebug(debug, "With root", items => String.concat("\n", items))
  |> List.map(name => Files.collect(name, isSourceFile) |> List.sort(compare))
  |> List.concat
  |> ifDebug(debug, "Source files found", String.concat(" : "))
  |> filterDuplicates
  |> List.map(path => {
    let rel = Files.relpath(root, path);
    (compiledBase /+ compiledName(~namespace, rel), rel)
  })
  |> ifDebug(debug, "With compiled base", (items) =>String.concat("\n", List.map(((a, b)) => a ++ " : " ++ b, items)))
  |> List.filter(((full, rel)) => Files.exists(full))
};


let findDependencyDirectories = root => {
  let config = Json.parse(Files.readFile(root /+ "bsconfig.json") |! "No bsconfig.json found");
  let isNative = isNative(config);
  let compiledBase = oneShouldExist("Cannot find directory for compiled artifacts.",
    isNative
      ? [root /+ "lib/bs/js", root /+ "lib/bs/native"]
      : [root /+ "lib/bs", root /+ "lib/ocaml"]
  );
  let jsBase = root /+ "lib/js";
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
  --skip-stdlib-completions
      don't include completions for the stdlib in the playground
  --no-bundle
      don't bundle the code examples. This disables editor support
  --ignore-code-errors
      don't print warnings about parse & type errors in code blocks
  --project-directory
      path/to/cmt/directory:rel/path/from/root
  --dependency-directory
      a directory containing ".cmj" files that should be '-I'd when compiling snippets
  --bs-root (default: root/node_modules/bs-platform)
  --doctest (default: false)
      execute the documentation snippets to make sure they run w/o erroring
  --ml
      assume code snippets are in ocaml syntax, not reason
  -h, --help
      print this help

  --just-input
      just parse the options & show the debug output of parsing cli args
  --debug
      output debugging information
|};

let fail = (msg) => {
  print_endline(msg);
  print_endline(help);
  exit(1);
};

let parse = Minimist.parse(
  ~alias=[("h", "help"), ("test", "doctest"), ("d", "debug")],
  ~presence=[
    "help", "doctest", "ml",
    "ignore-code-errors",
    "skip-stdlib-completions",
    "debug", "just-input",
    "no-bundle",
  ],
  ~multi=["project-file", "dependency-directory", "project-directory"],
  ~strings=["target", "root", "name", "bs-root"]
);

open State.Input;

let getRefmt = bsRoot => {
  Files.ifExists(bsRoot /+ "lib/refmt3.exe") |?? Files.ifExists(bsRoot /+ "lib/refmt.exe")
};

let getPackageJsonName = config => {
  Json.get("name", config) |?>> (Json.string |.! "name must be a string")
};

let getBsbVersion = base => {
  let (out, success) = Commands.execSync(base /+ "lib/bsb.exe -version");
  if (!success) {
    "2.2.3"
  } else {
    let out = String.concat("", out) |> String.trim;
    out
  }
};

let optsToInput = (selfPath, {Minimist.strings, multi: multiMap, presence}) => {
  open Minimist;
  let root = get(strings, "root") |?>> Files.absify |? Unix.getcwd();
  let bsRoot = get(strings, "bs-root") |?>> Files.absify |?>> shouldExist("provided bs-root doesn't exist") |?? Files.ifExists(root /+ "node_modules/bs-platform");
  if (bsRoot == None) {
    print_endline("⚠️ Warning! No bs-root provided, and " ++ root ++ "/node_modules/bs-platform doesn't exist. Code blocks will not be processed, but everything else will work.");
  };
  let refmt = get(strings, "refmt") |?>> shouldExist("provided refmt doesn't exist") |?? (bsRoot |?> getRefmt);
  let target = get(strings, "target") |? (root /+ "docs");
  let projectName = get(strings, "name") |? String.capitalize(Filename.basename(root));
  let projectFiles = multi(multiMap, "project-file") |> List.map(line => {
    switch (Str.split(Str.regexp_string(":"), line)) {
    | [cmt, relpath] => (cmt, relpath)
    | _ => fail("Invalid project file " ++ line)
    }
  });

  let projectFiles = projectFiles @ (multi(multiMap, "project-directory") |> List.map(line => {
    switch (Str.split(Str.regexp_string(":"), line)) {
    | [cmt, relpath] => Files.readDirectory(cmt) |> List.filter(isCompiledFile) |> filterDuplicates
    |> List.map(name => (cmt /+ name, relpath /+ Filename.chop_extension(name) ++ ".ml"))
    | _ => fail("Invalid project file " ++ line)
    }
  }) |> List.concat);

  let dependencyDirectories = multi(multiMap, "dependency-directory") |> List.map(line => {
    switch (Str.split(Str.regexp_string(":"), line)) {
    | [cmt, js] => (cmt, js)
    | _ => fail("Invalid dependency directory " ++ line)
    }
  });

  let packageJson = Files.ifExists(root /+ "package.json") |?>> (Files.readFile |.! "Unable to read package.json") |?>> Json.parse;
  let static = Filename.dirname(selfPath) /+ "../../../static";
  let debug = has("debug", presence);
  let bsConfig = Files.readFile(root /+ "bsconfig.json") |?>> (contents => Json.parse(contents));
  let namespaced = bsConfig |?> Json.get("namespace") |?> Json.bool |? false;
  {
    env: {
      static: static,
      debug,
    },
    target: {
      directory: target,
      skipStdlibCompletions: has("skip-stdlib-completions", presence),
      search: true,
      template: None,
    },
    packageInput: {
      meta: {
        packageName: projectName,
        repo: ParseConfig.getUrl(root),
      },
      defaultCodeOptions: has("ml", presence) ? Some({
        ...State.Model.defaultOptions,
        lang: OCaml
      }) : None,
      root,
      namespaced,
      canBundle: has("no-bundle", presence) ? false : true,
      backend: (packageJson |?> getPackageJsonName |?> packageJsonName => bsRoot |?> bsRoot => refmt |?>> refmt => State.Bucklescript({
        let version = getBsbVersion(bsRoot);
        {
          bsRoot,
          packageRoot: root,
          silentFailures: has("ignore-code-errors", presence),
          refmt,
          version,
          browserCompilerPath: Files.ifExists(static /+ "bs-" ++ version ++ ".js"),
          tmp: root /+ "node_modules/.docre",
          compiledDependencyDirectories: dependencyDirectories == [] ? findDependencyDirectories(root) : dependencyDirectories,
          packageJsonName,
        }
      })) |? NoBackend,
      sidebarFile: None,
      customFiles: findMarkdownFiles(projectName, target, root),
      moduleFiles: projectFiles == [] ? findProjectFiles(~debug, ~namespace=namespaced ? Some(projectName) : None, root) : projectFiles,
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
  | Ok(opts) => {
    if (Minimist.has("help", opts.presence)) {
      print_endline(help);
      exit(0);
    } else {
      let input = optsToInput(selfPath, opts);
      if (input.env.debug) {
        print_endline(State.Input.show(input))
      };
      if (Minimist.has("just-input", opts.presence)) {
        exit(0);
      } else {
        input
      }
    }
  }
  }
};
