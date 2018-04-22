
let sanitize = name => Str.global_replace(Str.regexp("[^a-zA-Z0-9_]"), "_", name);

let toReason = (refmt, code) => {
  let (out, err, success) = Commands.execFull(~input=code, refmt ++ " --parse ml --print re");
  if (!success) {
    print_endline("Failed to convert to reason");
    "/* Unable to convert to reason */"
  } else {
    out |> String.concat("\n")
  }
};

open Infix;

let toMl = (refmt, bsRoot, tmp, name, code) => {
  let tmpFile = tmp /+ name ++ ".alt";
  let (out, err, success) = Commands.execFull(~input=code, refmt ++ " --parse re --print binary > " ++ tmpFile);
  if (!success) {
    print_endline("Failed to convert to ocaml");
    "(* Unable to convert to ocaml *)"
  } else {
    let bin = out |> String.concat("\n");
    let (out, err, success) = Commands.execFull(bsRoot /+ "lib/reactjs_jsx_ppx_2.exe " ++ tmpFile ++ " " ++ tmpFile ++ "2");
    if (!success) {
      print_endline("Failed to run ppx");
      "(* Unable to convert to ocaml (run ppx) *)"
    } else {
      let binary = Files.readFileExn(tmpFile ++ "2");
      let (out, err, success) = Commands.execFull(~input=binary, refmt ++ " --parse binary --print ml");
      if (!success) {
        print_endline("Failed to run refmt second time");
        "(* Unable to convert to ocaml (run refmt 2) *)"
      } else {
        out |> String.concat("\n")
      }
    }
  }
};

/* type pos = Front | Middle | Back */
let withSections = (transformer, code) => {
  /* let lines = Str.split(Str.regexp_string("\n"), text);
  let rec loop = (pos, lines, (prefix, main, post)) => {
    switch lines {
    | [] => (prefix, main, post)
    | [line, ...rest] when CodeHighlight.isHashed(line) => switch pos {
    | Front => ([CodeHighlight.un])
    }
    }
  }; */
  transformer(code)
};

open State.Model;

let block = (
  ~editingEnabled,
  ~bundle,
  {State.bsRoot, refmt, tmp, compiledDependencyDirectories, browserCompilerPath, silentFailures},
  {name},
  i,
  (page, langLine, raw, fullContent, options)
) => {
  open State.Model;
  let name = sanitize(name) ++ "__" ++ sanitize(page) ++ "_CODE_BLOCK_" ++ string_of_int(i);
  let comment = options.lang == OCaml ? "(* " ++ name ++ " *)" : "/* " ++ name ++ " */";
  let plainContent = CodeSnippets.removeHashes(fullContent);
  let compilationResult = CodeSnippets.processBlock(
    ~silentFailures=silentFailures,
    bsRoot, tmp,
    name, refmt,
    options,
    plainContent ++ " " ++ comment,
    compiledDependencyDirectories |> List.map(fst)
  );

  let altOptions = {...options, lang: options.lang == OCaml ? Reason : OCaml};
  let (altName, altCode, altResult) = switch compilationResult {
  | Skipped | ParseError(_) => (name ++ "_alt", "Unable to refmt code with a syntax error", Skipped)
  | TypeError(_, _) | Success(_, _) => {
      let altContent = options.lang == OCaml ? toReason(refmt, plainContent) : toMl(refmt, bsRoot, tmp, name, plainContent);
      /* let code = options.lang == OCaml ? toReason(refmt, plainContent) : toMl(refmt, bsRoot, tmp, name, plainContent); */
      let compilationResult = CodeSnippets.processBlock(
        ~silentFailures=silentFailures,
        bsRoot, tmp,
        name ++ "_alt", refmt,
        altOptions,
        altContent,
        compiledDependencyDirectories |> List.map(fst)
      );
      /* print_endline("Processed the other side: " ++ code); */
      (name ++ "_alt", altContent, compilationResult)
    }
  };

  let html = options.codeDisplay.hide ? "" : CodeSnippets.highlight(
    ~editingEnabled,
    string_of_int(i), /* TODO stop using this data structure, and pass in the name */
    fullContent,
    options,
    compilationResult,
    bundle
  );

  let htmlAlt = options.codeDisplay.hide ? "" : CodeSnippets.highlight(
    ~editingEnabled,
    string_of_int(i) ++ "-alt", /* TODO stop using this data structure, and pass in the name */
    altCode,
    altOptions,
    altResult,
    bundle
  );

  {State.Model.langLine, html: html ++ htmlAlt, raw, page, filePath: name, compilationResult}
};
