
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

let withSections = (transformer, code) => {
  transformer(code)
};

open State.Model;

let block = (
  ~debug,
  ~editingEnabled,
  ~bundle,
  {State.bsRoot, refmt, tmp, compiledDependencyDirectories, browserCompilerPath, silentFailures},
  {name},
  i,
  (page, langLine, raw, fullContent, options, alt)
) => {
  open State.Model;
  let name = sanitize(name) ++ "__" ++ sanitize(page) ++ "_CODE_BLOCK_" ++ string_of_int(i);
  let comment = options.lang == OCaml ? "(* " ++ name ++ " *)" : "/* " ++ name ++ " */";
  let plainContent = CodeSnippets.removeHashes(fullContent);
  let compilationResult = CodeSnippets.processBlock(
    ~debug,
    ~silentFailures=silentFailures,
    bsRoot, tmp,
    name, refmt,
    options,
    plainContent ++ " " ++ comment,
    compiledDependencyDirectories |> List.map(fst)
  );

  let altName = name ++ "_alt";
  let altLang = options.lang == OCaml ? Reason : OCaml;
  let (altCode, altOptions, altResult) = switch alt {
  | Some((altOptions, fullContent)) => {
    let altOptions = {...altOptions, lang: altLang, inferred: false};
    let comment = altOptions.lang == OCaml ? "(* " ++ name ++ " *)" : "/* " ++ name ++ " */";
    let plainContent = CodeSnippets.removeHashes(fullContent);
    let compilationResult = CodeSnippets.processBlock(
      ~debug,
      ~silentFailures,
      bsRoot, tmp,
      altName, refmt,
      altOptions,
      plainContent ++ " " ++ comment,
      compiledDependencyDirectories |> List.map(fst)
    );
    (fullContent, altOptions, compilationResult)
  }
  | None => {
    let altOptions = {...options, lang: altLang};
    let (altCode, altResult) = switch compilationResult {
    | Skipped => ("This code was skipped", Skipped)
    | ParseError(parseError) => (plainContent, ParseError("Unable to refmt code with a syntax error. The original error was\n\n" ++ parseError))
    | TypeError(_, _) | Success(_, _) => {
        let altContent = options.lang == OCaml ? toReason(refmt, plainContent) : toMl(refmt, bsRoot, tmp, name, plainContent);
        let compilationResult = CodeSnippets.processBlock(
          ~debug,
          ~silentFailures,
          bsRoot, tmp,
          altName, refmt,
          altOptions,
          altContent,
          compiledDependencyDirectories |> List.map(fst)
        );
        (altContent, compilationResult)
      }
    };
    (altCode, altOptions, altResult)
  }
  };

  let html = options.codeDisplay.hide ? "" : CodeSnippets.highlight(
    ~editingEnabled,
    string_of_int(i),
    fullContent,
    options,
    compilationResult,
    bundle
  );

  let htmlAlt = options.codeDisplay.hide ? "" : CodeSnippets.highlight(
    ~editingEnabled,
    string_of_int(i) ++ "-alt",
    altCode,
    altOptions,
    altResult,
    bundle
  );

  let html =
    Printf.(sprintf("<div %s class='code-block-pair'>",
                    (switch (options.id) { | None => "" | Some(id) => sprintf("id='%s'", id) })))
    ++ html
    ++ htmlAlt
    ++ "</div>";

  {State.Model.langLine, html, raw, page, filePath: name, compilationResult}
};
