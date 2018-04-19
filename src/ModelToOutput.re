
open Infix;

let expectSuccess = (message, success) => success ? () : failwith(message);

let package = (
  {State.Model.name, repo, custom, sidebar, modules},
  compilationResults,
  {State.Input.directory, template, search},
  {State.Input.static}
) => {
  Files.mkdirp(directory);

  let codeBlocks = compilationResults |?>> (((codeBlocks, bundles)) => {
    bundles |?< ((runtimeDeps, compilerDeps)) => {
      compilerDeps |?< ((browserCompilerPath, compilerDepsBuffer)) => {
        Files.copy(~source=browserCompilerPath, ~dest=directory /+ "bucklescript.js") |> expectSuccess("Unable to copy");
        let out = open_out(directory /+ "bucklescript-deps.js");
        Buffer.output_buffer(out, compilerDepsBuffer);
        close_out(out);
      };
      Files.writeFile(directory /+ "all-deps.js", runtimeDeps ++ ";window.loadedAllDeps = true;") |> expectSuccess("Unable to write all-deps.js");
    };
    codeBlocks;
  }) |? [];

  print_endline("Ok packaged folks " ++ directory);
};
