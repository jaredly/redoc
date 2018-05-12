
let codeBlockPrefix = "DOCRE_CODE_BLOCK_";

open Infix;

let matchOption = (text, option) => if (Str.string_match(Str.regexp("^" ++ option ++ "(\\([^)]+\\))$"), text, 0)) {
  Some(Str.matched_group(1, text));
} else {
  None
};

let parseCodeOptions = (lang, defaultOptions) => {
  open State.Model;
  let parts = Str.split(Str.regexp_string(";"), lang);
  if (List.mem("bash", parts)
  || List.mem("txt", parts)
  || List.mem("js", parts)
  || List.mem("javascript", parts)
  || List.mem("sh", parts)) {
    None
  } else {
    let options = List.fold_left((options, item) => {
      let item = String.trim(item);
      switch item {
      | "alt" => options /* this option is handled separately */

      | "window" => {...options, context: Window}
      | "canvas" => {...options, context: Canvas}
      | "iframe" => {...options, context: Iframe}
      | "log" => {...options, context: Log}
      | "div" => {...options, context: Div}
      /* | "open-module" => {...options, openModule: true} */
      /* | "repl" => {...options, repl: true} */
      | "raises" => {...options, expectation: Raise}
      | "parse-fail" => {...options, expectation: ParseFail}
      | "skip" => {...options, expectation: Skip}
      | "type-fail" => {...options, expectation: TypeFail}
      /* | "isolate" => {...options, isolate: true} */
      | "no-run" => {...options, expectation: DontRun}
      | "no-edit" => {...options, codeDisplay: {...options.codeDisplay, noEdit: true}}
      | "hide" => {...options, codeDisplay: {...options.codeDisplay, hide: true}}
      | "reason" | "re" => {...options, lang: Reason, inferred: false}
      | "ocaml" | "ml" => {...options, lang: OCaml, inferred: false}
      | "txt" => {...options, lang: Txt}
      | _ => {
        switch (matchOption(item, "shared")) {
        | Some(name) => {...options, sharedAs: Some(name)}
        | None => switch (matchOption(item, "use")) {
          | Some(name) => {...options, uses: [name, ...options.uses]}
          | None => switch (matchOption(item, "prefix")) {
            | Some(content) => {...options, codeDisplay: {...options.codeDisplay, prefix: int_of_string(content)}}
            | None => switch (matchOption(item, "suffix")) {
              | Some(content) => {...options, codeDisplay: {...options.codeDisplay, suffix: int_of_string(content)}}
              | None => {
                if (parts == [item]) {
                  {...options, lang: OtherLang(item)}
                } else {
                  print_endline(Printf.sprintf("Skipping unexpected code option: %S", item));
                  options
                }
              }
            }

          }
        }
        }
      }
      }
    }, defaultOptions, parts);
    if (options.lang == Reason || options.lang == OCaml) {
      Some(options)
    } else {
      None
    }
  }
};

type codeBlock = {
  el: Omd.element,
  id: int,
  fileName: string,
  options: State.Model.codeOptions,
  content: string,
};

type compiledBlock = {
  block: codeBlock,
  status: State.Model.compilationResult,
};

let sprintf = Printf.sprintf;
let html = Omd_utils.htmlentities;
let escapeScript = text => Str.global_replace(Str.regexp_string("</script"), "<\\/script", text);

let shouldBundle = expectation => switch expectation {
| State.Model.Succeed | Raise => true
| _ => false
};

let highlight = (~editingEnabled, id, content, options, status, bundle) => {
  open State.Model;
  let cmt = switch status {
  | Skipped => None
  | ParseError(_) => None
  | TypeError(_, cmt) => Some(cmt)
  | Success(cmt, _) => Some(cmt)
  };
  let (pre, code, post) = switch cmt {
  | None => {
    let (pre, _, code, post, _) = CodeHighlight.codeSections(content);
    (pre, html(code), post)
  }
  | Some(cmt) => CodeHighlight.highlight(content, cmt)
  };

  let syntax = options.lang == State.Model.OCaml ? "ml" : "re";

  let (after, editingEnabled) = switch status {
  | Skipped => ("", false)
  | ParseError(text) => (sprintf("<div class='parse-error'>Parse Error:\n%s</div>", html(text)), editingEnabled)
  | TypeError(text, _) => (sprintf("<div class='type-error'>Type Error:\n%s</div>", html(text)), editingEnabled)
  | Success(cmt, js) => (!editingEnabled || !shouldBundle(options.expectation)) ? ("", false) : {
    switch (bundle(js)) {
    | None => ("", false)
    | Some(compiledJs) =>
      (Printf.sprintf({|%s<script type='docre-bundle' data-block-id='%s'>%s</script>|},
        switch options.context {
        | Node => ""
        | _ => sprintf({|<div data-block-id='%s' data-context=%S data-block-syntax=%S class='block-target'></div>|}, id, contextString(options.context),     syntax)
        },
        id,
        compiledJs
      ), editingEnabled)
    }
    }
  };

  let preCode = pre == "" ? "" : "<div class='code-pre'>" ++ html(pre) ++ "</div>";
  let postCode = post == "" ? "" : "<div class='code-post'>" ++ html(post) ++ "</div>";

  sprintf(
    {|<div class='code-block' data-block-syntax=%S>
  %s
  <pre class='code' data-block-id='%s' id='block-%s'><code>%s</code></pre>
  %s
  %s
  %s
</div>|},
    syntax,
    preCode,
    id,
    id,
    code,
    postCode,
    (!editingEnabled || options.codeDisplay.noEdit || status == Skipped) ? "" : sprintf({|<script type='docre-source' data-block-id="%s">%s</script>|}, id, escapeScript(content)),
    after
  )
};

let splitLines = text => Str.split(Str.regexp_string("\n"), text);

let sliceToEnd = (s, num) => String.length(s) < num ? s : String.sub(s, num, String.length(s) - num);

let removeHashes = text => {
  let rec loop = lines => switch lines {
  | [] => []
  | ["", ...rest] => ["", ...loop(rest)]
  | [one, ...rest] when one.[0] == '#' => [" " ++ sliceToEnd(one, 1), ...loop(rest)]
  | [one, ...rest] when one.[0] == '!' && String.length(one) >= 2 && one.[1] == '#' => ["  " ++ sliceToEnd(one, 2), ...loop(rest)]
  | _ => lines
  };
  let front = loop(splitLines(text));
  String.concat("\n", List.rev(loop(List.rev(front))))
};

let hashAll = text => splitLines(text) |> List.map(t => (CodeHighlight.isHashed(t) ? t : "#" ++ t)) |> String.concat("\n");
let slice = (s, pre, post) => String.sub(s, pre, String.length(s) - pre + post);
let startsWith = (prefix, string) => {
  let lp = String.length(prefix);
  lp <= String.length(string) && String.sub(string, 0, lp) == prefix
};

let fullContent = (getShared, {State.Model.codeDisplay: {prefix, suffix}} as options, content) => {
  let content = prefix == 0 && suffix == 0 ? content : {
    let lines = splitLines(content) |> Array.of_list;
    for (i in 0 to prefix - 1) {
      lines[i] = "#" ++ lines[i];
    };
    let ln = Array.length(lines);
    for (i in 0 to suffix - 1) {
      lines[ln - 1 - i] = "#" ++ lines[ln - 1 - i];
    };
    String.concat("\n", Array.to_list(lines))
  };

  List.fold_left((content, name) => {
    switch (getShared(name)) {
    | exception Not_found => {
      print_endline("Unknown shared " ++ name);
      content ++ " /* unknown shared " ++ name ++ " */"
    }
    | text => {
      let text = text |> hashAll;
      let rx = Str.regexp_string("#%{code}%");
      switch (Str.search_forward(rx, text, 0)) {
      | exception Not_found => text ++ "\n" ++ content
      | _ => Str.replace_first(rx, content, text)
      }
    }
  }
  }, content, options.uses);

};

open Infix;

let optMap = (fn, items) => List.fold_left((result, item) => switch (fn(item)) { | None => result | Some(res) => [res, ...result]}, [], items);

let getSourceDirectories = (base, config) => {
  let rec handleItem = (current, item) => {
    switch item {
    | Json.Array(contents) => List.map(handleItem(current), contents) |> List.concat
    | Json.String(text) => [current /+ text]
    | Json.Object(_) =>
      let dir = Json.get("dir", item) |?> Json.string |? "Must specify directory";
      let backend = item |> Json.get("backend") |?> Json.array |?>> optMap(Json.string) |? ["js"];
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

      let compilationBase = isNative ? "lib/bs/js" : (
        Files.ifExists(loc /+ "lib/ocaml") |? (loc /+ "lib/bs")
      );
      if (List.mem("js", allowedKinds)) {
        getSourceDirectories(loc, inner) |> List.map(name => (
          compilationBase /+ name,
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

let invert = (f, a) => !f(a);

let unique = list => {
  let hash = Hashtbl.create(10);
  list |> List.filter(item => Hashtbl.mem(hash, item) ? false : {Hashtbl.add(hash, item, true); true})
};

let writeDeps = (~output_string, ~dependencyDirs, ~stdlibRequires, ~bsRoot, ~base) => {
  /* let depsToLoad = dependencyDirs |> List.map(((dir, jsDir)) => Files.readDirectory(dir) |> List.filter(name => Filename.check_suffix(name, ".cmi")) |> List.map(name => dir /+ name)) |> List.concat; */
  /* let out = open_out(dest); */

  let depsToWrite = dependencyDirs |> List.map(((dir, jsDir)) => Files.readDirectory(dir) |> List.filter(name => Filename.check_suffix(name, ".cmi")) |> List.map(name => {
    (name, dir /+ name, Filename.chop_extension(name) ++ ".cmj", Filename.chop_extension(name) ++ ".js", jsDir)
  })) |> List.concat |> unique;

  let depsMap = depsToWrite |> List.map(((name, path, cmj, js, jsDir)) => {

    /* let path = dir /+ name;
    let cmj = Filename.chop_extension(name) ++ ".cmj";
    let js = Filename.chop_extension(name) ++ ".js"; */

    output_string("ocaml.load_module(\"/static/cmis/" ++ name ++ "\", ");
    SerializeBinary.pp_string(output_string, Files.readFile(path) |! "file not readable " ++ path);
    output_string(",\n\"" ++ cmj ++ "\", ");
    let cmjPath = Filename.chop_extension(path) ++ ".cmj";
    if (Files.exists(cmjPath)) {
      SerializeBinary.pp_string(output_string, Files.readFile(cmjPath) |! "cmj not readable " ++ path);
    } else {
      output_string({|"<no cmj file>"|});
    };
    output_string(");\n");

    ("stdlib" /+ String.uncapitalize(Filename.chop_extension(name)), jsDir /+ js)
  });
  let depsMap = depsMap @ (stdlibRequires |> List.map(path => {
    ("stdlib" /+ String.uncapitalize(Filename.chop_extension(Filename.basename(path))), path)
  }));
  output_string("window.bsRequirePaths = {\n");
  depsMap |> List.iter(((bsRequire, path)) => {
    output_string(
      Printf.sprintf({|"%s": "%s",
|},
        bsRequire,
        Files.relpath(base, path)
      )
    );
  });
  output_string("}\n");
  /* close_out(out); */
};

let refmtCommand = (base, re, refmt, parseAs) => {
  Printf.sprintf({|cat %s | %s --parse %s --print binary > %s.ast && %s %s.ast %s_ppx.ast|},
  re,
  refmt,
  parseAs,
  re,
  base /+ "lib/reactjs_jsx_ppx_2.exe",
  re,
  re
  )
};

let justBscCommand = (base, sourceFile, includes) => {
  Printf.sprintf(
    {|%s -w -A %s -impl %s|},
    base /+ "lib/bsc.exe",
    includes |> List.map(Printf.sprintf("-I %S")) |> String.concat(" "),
    sourceFile
  )
};

let processBlock = (~silentFailures=false, bsRoot, tmp, name, refmt, options, reasonContent, dependencyDirs) => {
  let re = tmp /+ name ++ ".re";
  let cmt = tmp /+ name ++ ".re_ppx.cmt";
  let js = tmp /+ name ++ ".re_ppx.js";
  open State.Model;

  Files.writeFile(re, reasonContent) |> ignore;

  let cmd = refmtCommand(bsRoot, re, refmt, options.lang == OCaml ? "ml" : "re");
  let (output, err, success) = Commands.execFull(cmd);
  open State.Model;
  if (!success && options.inferred) {
    /* If we inferred that it was code, but it didn't parse, then assume it wasn't code. */
    Skipped
  } else if (!success) {
    let out = String.concat("\n", output) ++ String.concat("\n", err);
    if (options.expectation != State.Model.ParseFail && !silentFailures) {
      print_endline("Failed to parse " ++ re);
      print_endline(out);
      print_endline(reasonContent);
      print_newline();
    };
    let out = Str.global_replace(Str.regexp_string(re), "<snippet>", out);
    ParseError(out);
  } else {
    let includes = dependencyDirs;
    let cmd = justBscCommand(bsRoot, re ++ "_ppx.ast", includes);
    let (output, err, success) = Commands.execFull(cmd);
    if (!success) {
      let out = String.concat("\n", output) ++ String.concat("\n", err);
      if (options.expectation != State.Model.TypeFail && !silentFailures) {
        print_endline(cmd);
        print_endline("Failed to compile " ++ re);
        print_endline(out);
        print_endline(reasonContent);
        print_newline();
      };
      let out = Str.global_replace(Str.regexp_string(re), "<snippet>", out);
      TypeError(out, cmt);
    } else { Success(cmt, js) };
  };
};

let escape = text => text
|> Str.global_replace(Str.regexp_string("\\"), "\\\\")
|> Str.global_replace(Str.regexp_string("\n"), " ")
|> Str.global_replace(Str.regexp_string("\""), "\\\"")
;

let shouldTest = expectation => switch expectation {
| State.Model.Succeed | Raise => true
| _ => false
};

let snippetLoader = (name, basePath, snippetPath) => Printf.sprintf({|
var path = require('path');
var Module = require('module');
var oldResolveFilename = Module._resolveFilename;
Module._resolveFilename = function (request, parent, isMain) {
  var name = '%s/';
  var base = '%s';
  if (request.indexOf(name) === 0) {
    return oldResolveFilename.call(this, path.join(base, request.slice(name.length)), parent, isMain);
  }

  return oldResolveFilename.call(this, request, parent, isMain);
};
require('%s')
|}, name, basePath, snippetPath);

let testBlock = (packageJsonName, ~base, status, options, fileName, id) => {
  open State.Model;
  if (shouldTest(options.expectation) && options.context == Normal) {
    print_endline(string_of_int(id) ++ " - " ++ fileName);
    switch status {
    | Success(_, js) =>
    let cmd = Printf.sprintf("node -e \"%s\"", snippetLoader(packageJsonName, Files.absify(base), js) |> escape);
    let (output, err, success) = Commands.execFull(cmd);
    if (options.expectation == State.Model.Raise) {
      if (success) {
        print_endline(String.concat("\n", output));
        print_endline(String.concat("\n", err));
        print_endline("Expected to fail but didnt " ++ string_of_int(id) ++ " in " ++ fileName);
      }
    } else {
      if (!success) {
        print_endline(String.concat("\n", output));
        print_endline(String.concat("\n", err));
        print_endline("Failed to run " ++ string_of_int(id) ++ " in " ++ fileName);
      };
    }
    | _ => print_endline("Not running because of error")
    }
  };

};
