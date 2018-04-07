
let codeBlockPrefix = "DOCRE_CODE_BLOCK_";

let (/+) = Filename.concat;

type codeContext = Normal | Node | Window | Iframe | Canvas;
type codeOptions = {
  context: codeContext,
  shouldFail: bool,
  dontRun: bool,
  isolate: bool,
};

let parseCodeOptions = lang => {
  let parts = Str.split(Str.regexp_string(";"), lang);
  if (List.mem("skip", parts)
  || List.mem("bash", parts)
  || List.mem("txt", parts)
  || List.mem("js", parts)
  || List.mem("javascript", parts)
  || List.mem("sh", parts)) {
    None
  } else {
    Some(List.fold_left((options, item) => {
      switch item {
      | "raises" => {...options, shouldFail: true}
      | "window" => {...options, context: Window}
      | "canvas" => {...options, context: Canvas}
      | "isolate" => {...options, isolate: true}
      | "dont-run" => {...options, dontRun: true}
      | "reason" => options
      | _ => {
        print_endline("Skipping unexpected code option: " ++ item);
        options
      }
      }
    }, {
      context: Normal,
      shouldFail: false,
      dontRun: false,
      isolate: false,
    }, parts))
  }
};

let highlight = (lang, content, cmt, js) => {

  "<pre class='code'><code>" ++ CodeHighlight.highlight(content, cmt) ++ "</code></pre>"
};

let removeHashes = text => Str.global_replace(Str.regexp("^# "), "  ", text);

/* TODO allow package-global settings, like "run this in node" */
let process = (~test, markdowns, cmts, base) =>  {
  let codeBlocks = ref((0, []));
  let addBlock = (el, fileName, lang, contents) => {
    let options = parseCodeOptions(lang);
    switch (options) {
    | None => ()
    | Some(options) => {
      let (id, blocks) = codeBlocks^;
      codeBlocks := (id + 1, [(el, id, fileName, options, contents), ...blocks]);
    }
    }
  };

  let collect = (fileName, md) => Omd.Representation.visit(el => switch el {
    | Omd.Code_block(lang, contents) => {
      addBlock(el, fileName, lang, contents);
      None
    }
    | _ => None
  }, md) |> ignore;

  markdowns |> List.iter(((path, contents, name)) => {
    collect(path, contents);
  });

  cmts |> List.iter(((name, cmt, _, topDoc, allDocs)) => {
    Infix.(topDoc |?>> collect(cmt) |> ignore);
    allDocs |> List.iter(PrepareDocs.iter(((name, docString, _)) => {
      switch docString {
      | None => ()
      | Some(docString) => collect(cmt ++ " > " ++ name, docString)
      }
    }))
  });

  let (_, blocks) = codeBlocks^;
  let src = base /+ "src";
  let blockFileName = id => codeBlockPrefix ++ string_of_int(id);
  blocks |> List.iter(((_el, id, fileName, options, content)) => {
    Files.writeFile(src /+ blockFileName(id) ++ ".re", removeHashes(content) ++ " /* " ++ fileName ++ " */") |> ignore
  });
  let (output, err, success) = Commands.execFull(base /+ "node_modules/.bin/bsb" ++ " -make-world"); /*  -backend js */
  if (!success) {
    print_endline("Bsb output:");
    print_endline(String.concat("\n", output));
    print_endline("Error while running bsb on examples");
  };
  if (test) {
    print_endline("Running tests");
  };

  let blocksByEl = Hashtbl.create(100);

  /* TODO run in parallel - maybe all in the same node process?? */
  /* if (false) { */
    blocks |> List.iter(((el, id, fileName, options, content)) => {
      let name = blockFileName(id);
      /* let cmt = base /+ "lib/bs/js/src/" ++ name ++ ".cmt"; */
      let cmt = base /+ "lib/bs/src/" ++ name ++ ".cmt";
      let js = base /+ "lib/js/src/" ++ name ++ ".js";
      Hashtbl.replace(blocksByEl, el, (cmt, js));
      if (test && !options.dontRun) {
        print_endline(string_of_int(id) ++ " - " ++ fileName);
        let (output, err, success) = Commands.execFull("node " ++ js ++ "");
        if (options.shouldFail) {
          if (success) {
            print_endline(String.concat("\n", output));
            print_endline(String.concat("\n", err));
            print_endline("Expected to fail but didnt " ++ name ++ " in " ++ fileName);
          }
        } else {
          if (!success) {
            print_endline(String.concat("\n", output));
            print_endline(String.concat("\n", err));
            print_endline("Failed to run " ++ name ++ " in " ++ fileName);
          };
        }
      };
      let jsContents = Files.readFile(js);
      /* Unix.unlink(src /+ name ++ ".re"); */
      ()
    });
  /* }; */

  (element) => switch element {
  | Omd.Code_block(lang, content) => {
    switch (Hashtbl.find(blocksByEl, element)) {
    | exception Not_found => {
      print_endline("Not found code block " ++ content);
      None
    }
    | (cmt, js) => {
      Some(highlight(lang, content, cmt, js))
    }
    }
  }
  | _ => None
  };
};