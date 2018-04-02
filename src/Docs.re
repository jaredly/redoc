
open Parsetree;


let generate = (name, input) => {
  let (stampsToPaths, (toplevel, allDocs)) = switch input {
  | `Structure(structure, ast) => {
    let (sp, tl) = PrepareDocs.organizeTypes((name, []), structure.Typedtree.str_items);
    Printast.implementation(Format.str_formatter, ast);
    let out = Format.flush_str_formatter();
    Files.writeFile("./ast.impl", out) |> ignore;
    (sp, PrepareDocs.findAllDocs(ast, tl))
  }
  | `Signature(signature, ast) => {
    Printast.interface(Format.str_formatter, ast);
    let out = Format.flush_str_formatter();
    Files.writeFile("./ast.inft", out) |> ignore;
    let (sp, tl) = PrepareDocs.organizeTypesIntf((name, []), signature.Typedtree.sig_items);
    (sp, PrepareDocs.findAllDocsIntf(ast, tl))
  }
  };

  let mainMarkdown = switch (toplevel) {
  | None => GenerateDoc.defaultMain(name)
  | Some(doc) => doc
  };

  let formatHref = ((modName, inner, ptype)) => {
    let modName = if (modName == "<global>") {
      "globals"
    } else {
      modName
    };
    let hash = "#" ++ GenerateDoc.makeId(inner, ptype);
    if (modName == name) {
      hash
    } else {
      modName ++ ".html" ++ hash
    }
  };

  GenerateDoc.head(name) ++
  GenerateDoc.docsForModule(formatHref, stampsToPaths, [], name, mainMarkdown, allDocs)
};
