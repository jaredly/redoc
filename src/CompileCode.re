
let sanitize = name => Str.global_replace(Str.regexp("[^a-zA-Z0-9_]"), "_", name);

let block = (
  ~editingEnabled,
  ~bundle,
  {State.bsRoot, refmt, tmp, compiledDependencyDirectories},
  {State.Model.name},
  i,
  (page, lang, raw, fullContent, options)
) => {
  open State.Model;
  let name = sanitize(name) ++ "__" ++ sanitize(page) ++ "_CODE_BLOCK_" ++ string_of_int(i);
  let reasonContent = CodeSnippets.removeHashes(fullContent) ++ " /* " ++ name ++ " */";
  let compilationResult = CodeSnippets.processBlock(
    bsRoot, tmp,
    name, refmt,
    options,
    reasonContent,
    compiledDependencyDirectories |> List.map(fst)
  );
  let html = CodeSnippets.highlight(
    ~editingEnabled=true,
    i, /* TODO stop using this data structure, and pass in the name */
    fullContent,
    options,
    compilationResult,
    bundle
  );
  {State.Model.lang, html, raw, page, filePath: name, compilationResult}
};
