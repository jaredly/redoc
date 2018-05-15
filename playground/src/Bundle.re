/**

make a map of modules
find requires
resolve requires
bundle that one (or leave the require if we shouldn't bundle)
move on

*/

let serialize = (modules, mainId) => {
  let modules = Hashtbl.fold((id, text, res) => [(id, text), ...res], modules, []);
  let contents = modules |> List.map(((id, text)) => Printf.sprintf({|
    "%d": function(module, exports, packed$require) {
      %s
    },
|}, id, text)) |> String.concat("");
  ";(function() {var allModules = {" ++ contents ++ Printf.sprintf({|
  };
  var loaded = {}
  var load = id => {
    if (!loaded[id]) {
      var module = {exports: {}};
      loaded[id] = module;
      allModules[id](module, module.exports, load)
    }
    return loaded[id].exports
  }
  module.exports = load(%d)
})();
|}, mainId);
};

[@bs.send] external replace: (string, Js.Re.t, (. string, string) => string) => string = "";

let fixRequires = (text, resolveRequire) => {
  replace(text, [%bs.re {|/\brequire\(['"]([^'"]+)['"]\)/g|}], (. full, requirePath) => {
    switch (resolveRequire(requirePath)) {
    | None => full
    | Some(id) => Printf.sprintf("packed$require(%d)", id)
    }
  });
};

let bundle = (text, packagedModules, flatModules) => {
  let modules = Hashtbl.create(100);
  let ids = Hashtbl.create(100);
  let id = ref(0);

  let getProcessed = (packageName, moduleName) => switch (Hashtbl.find(ids, (packageName, moduleName))) {
  | exception Not_found => switch (Hashtbl.find(ids, ("", moduleName))) {
    | exception Not_found => None
    | x => Some(x)
    }
  | x => Some(x)
  };

  let rec getId = (packageName, moduleName) =>
  switch (getProcessed(packageName, moduleName)) {
  | Some(id) => Some(id)
  | None =>
    switch (Js.Dict.get(packagedModules, packageName)) {
    | None => switch (Js.Dict.get(flatModules, moduleName)) {
      | None => {
        Js.log("No flat " ++ moduleName);
        None
      }
      | Some(text) => Some(processModule("", moduleName, text))
      }
    | Some(package) => switch (Js.Dict.get(package, moduleName)) {
      | None => {
        Js.log("Missing in package!!!" ++ packageName ++ " " ++ moduleName);
        None
      }
      | Some(text) => Some(processModule(packageName, moduleName, text))
      }
    }
  }

  and processModule = (packageName, moduleName, text) => {
    let next = id^;
    id := next + 1;
    Hashtbl.replace(ids, (packageName, moduleName), next);
    Hashtbl.replace(modules, next, fixRequires(text, requirePath => {
      /* Js.log(requirePath); */
      let parts = Js.String.split("/", requirePath);
      /* Not an absolute require */
      if (Array.length(parts) < 2) { None } else {
        let moduleName = parts[Array.length(parts) - 1];
        let moduleName = String.capitalize(moduleName);
        let moduleName = Js.String.endsWith(".js", moduleName) ? String.sub(moduleName, 0, String.length(moduleName) - 3) : moduleName;
        let packageName = requirePath.[0] == '.' ? packageName : parts[0];
        if (packageName == "stdlib") {
          switch(Js.String.split("-", moduleName)) {
          | [|single|] => getId("", single)
          | [|moduleName, packageName|] => getId(packageName, moduleName)
          | _ => None
          }
        } else {
          getId(packageName, moduleName)
        }
      }
    }));
    next
  };

  /* let main = "$main$"; */
  let mainId = processModule("$top-package$", "$main$", text);
  Js.log("all modules");
  Hashtbl.iter((k, v) => {
    Js.log(k);
  }, ids);
  serialize(modules, mainId)
};