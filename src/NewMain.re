
open State;
open Infix;

let startsWith = (prefix, string) => {
  let lp = String.length(prefix);
  lp <= String.length(string) && String.sub(string, 0, lp) == prefix
};
let invert = (f, a) => !f(a);

let compileBucklescript = ({State.packageRoot, packageJsonName, browserCompilerPath} as bucklescript, package) => {
  Files.mkdirp(bucklescript.State.tmp);
  let pack = Packre.Pack.process(
    ~renames=[(packageJsonName, packageRoot)],
    ~base=packageRoot
  );
  let jsFiles = ref([]);
  let codeBlocks = ProcessCode.codeFromPackage(package) |> List.mapi(CompileCode.block(
    ~editingEnabled=browserCompilerPath != None,
    ~bundle=js => {
      jsFiles := [js, ...jsFiles^];
      pack(~mode=Packre.Types.ExternalEverything, [js])
    },
    bucklescript,
    package
  ));
  let jsFiles = jsFiles^;

  let stdlib = bucklescript.bsRoot /+ "lib/js";
  let stdlibRequires = Files.exists(stdlib) ? (Files.readDirectory(stdlib) |> List.filter(invert(startsWith("node_"))) |> List.map(name => stdlib /+ name)) : [];

  let bundles = if (jsFiles != []) {
    let runtimeDeps = try (pack(
      ~mode=Packre.Types.JustExternals,
      ~extraRequires=stdlibRequires,
      jsFiles
    )) {
      | err => {
        print_endline("Failed to bundle!!! " ++ Printexc.to_string(err));
        "alert('Failed to bundle')"
      }
    };
    let compilerDeps = browserCompilerPath |?>> browserCompilerPath => {
      let buffer = Buffer.create(10000);
      /* TODO maybe write directly to the target? This indirection might not be worth it. */
      CodeSnippets.writeDeps(
        ~output_string=Buffer.add_string(buffer),
        ~dependencyDirs=bucklescript.compiledDependencyDirectories,
        ~stdlibRequires,
        ~bsRoot=bucklescript.bsRoot,
        ~base=packageRoot
      );
      (browserCompilerPath, buffer)
    };
    Some((runtimeDeps, compilerDeps));
  } else {
    None
  };

  (codeBlocks, bundles)
};

let compilePackage = (package) => {
  switch package.Model.backend {
  | NoBackend => None
  | Bucklescript(bucklescript) => Some(compileBucklescript(bucklescript, package))
  }
};

let main = () => {
  let input = CliToInput.parse(Sys.argv);
  let package = InputToModel.package(input.Input.packageInput);
  let compilationResults = compilePackage(package);
  /* outputPackage(package, allCodeBlocks, input.Input.target); */
  ModelToOutput.package(package, compilationResults, input.Input.target, input.Input.env);
};

let () = main();