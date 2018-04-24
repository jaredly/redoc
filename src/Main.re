
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
      let res = try(pack(~mode=Packre.Types.ExternalEverything, [js])) {
      | Failure(message) => "alert('Failed to bundle " ++ message ++ "')"
      };
      res
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
      | Failure(message) => {
        print_endline("Failed to bundle!!! " ++ message);
        "alert('Failed to bundle " ++ message ++ "')"
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
  open Model;
  switch package.backend {
  | NoBackend => None
  | Bucklescript(bucklescript) => {
    let (codeBlocks, bundles) = compileBucklescript(bucklescript, package);
    let (parseFail, typeFail, good, skip) = List.fold_left(
      (((parse, typ, good, skip), {langLine, raw, page, filePath, compilationResult}) => {
        switch compilationResult {
        | Skipped => (parse, typ, good, skip + 1)
        | ParseError(_) => (parse + 1, typ, good, skip)
        | TypeError(_, _) => (parse, typ + 1, good, skip)
        | Success(_, _) => (parse, typ, good + 1, skip)
        }
      }),
      (0, 0, 0, 0),
      codeBlocks
    );
    Printf.printf("Code block results: %d parse failures, %d type failures, %d success, %d skips\n", parseFail, typeFail, good, skip);
    Some((codeBlocks, bundles))
  }
  }
};

let main = () => {
  let input = CliToInput.parse(Sys.argv);
  print_endline("<<< Converting input to model!");
  let package = InputToModel.package(input.Input.packageInput);
  print_endline("<<< Compiling!");
  let compilationResults = compilePackage(package);
  print_endline("<<< Compiled!");
  /* outputPackage(package, allCodeBlocks, input.Input.target); */
  ModelToOutput.package(package, compilationResults, input.Input.target, input.Input.env);
};

let () = main();