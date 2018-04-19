
let block = (
  ~editingEnabled,
  ~bundle,
  {State.Input.bsRoot, refmt, tmp},
  {State.Model.name, compiledDependencyDirectories},
  i,
  (page, lang, raw, fullContent, options)
) => {
  open State.Model;
  let name = name ++ "_CODE_BLOCK_" ++ string_of_int(i);
  let compilationResult = CodeSnippets.processBlock(
    bsRoot, tmp,
    name, refmt,
    options,
    fullContent,
    compiledDependencyDirectories
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