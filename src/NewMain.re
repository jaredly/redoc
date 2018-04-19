
let inputFromArgs = argv => {
  /* TODO parse */
  failwith("Not impl")
};

let packageFromInput = (package, env) => {
  failwith("nope")
};

open State;
open Infix;

let main = () => {
  let input = CliToInput.parse(Sys.argv);
  let package = InputToModel.package(input.Input.packageInput);
  let allCodeBlocks = input.Input.env.compilation |?>> (compilation) => package.Model.packageJsonName |?>> packageJsonName => {
    Files.mkdirp(compilation.Input.tmp);
    ProcessCode.codeFromPackage(package) |> List.mapi(CompileCode.block(
      ~editingEnabled=true,
      ~bundle=js => Packre.Pack.process(
        ~mode=Packre.Types.ExternalEverything,
        ~renames=[(packageJsonName, package.Model.root)],
        ~base=package.Model.root,
        [js]
      ),
      compilation,
      package
    ))
  };
  /* outputPackage(package, allCodeBlocks, input.Input.target); */
};
