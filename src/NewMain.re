
let inputFromArgs = argv => {
  /* TODO parse */
  failwith("Not impl")
};

let packageFromInput = (package, env) => {
  failwith("nope")
};

let outputPackage = (package, target) => {
  ()
};

open State;

let main = () => {
  let input = CliToInput.parse(Sys.argv);
  let package = InputToModel.package(input.Input.packageInput, input.Input.env);
  outputPackage(package, input.Input.target);
};
