
let sanitize = name => Str.global_replace(Str.regexp("[^a-zA-Z0-9_]"), "_", name);

let block = (
  ~editingEnabled,
  ~bundle,
  {State.bsRoot, refmt, tmp, compiledDependencyDirectories, browserCompilerPath, silentFailures},
  {State.Model.name},
  i,
  (page, langLine, raw, fullContent, options)
) => {
  open State.Model;
  let name = sanitize(name) ++ "__" ++ sanitize(page) ++ "_CODE_BLOCK_" ++ string_of_int(i);
  let comment = options.State.Model.lang == State.Model.OCaml ? "(* " ++ name ++ " *)" : "/* " ++ name ++ " */";
  let reasonContent = CodeSnippets.removeHashes(fullContent) ++ " " ++ comment;
  let compilationResult = CodeSnippets.processBlock(
    ~silentFailures=silentFailures,
    bsRoot, tmp,
    name, refmt,
    options,
    reasonContent,
    compiledDependencyDirectories |> List.map(fst)
  );
  let html = options.codeDisplay.hide ? "" : CodeSnippets.highlight(
    ~editingEnabled,
    i, /* TODO stop using this data structure, and pass in the name */
    fullContent,
    options,
    compilationResult,
    bundle
  );
  {State.Model.langLine, html, raw, page, filePath: name, compilationResult}
};
