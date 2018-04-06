
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
  if (List.mem("skip", parts)) {
    None
  } else {
    Some(List.fold_left((options, item) => {
      switch item {
      | "raises" => {...options, shouldFail: true}
      | "window" => {...options, context: Window}
      | "canvas" => {...options, context: Canvas}
      | "isolate" => {...options, isolate: true}
      | "dont-run" | "just-check" => {...options, dontRun: true}
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

/** TODO don't parse the docstrings twice */
let iterDocstrings = (fn, cmt) => {
  let blocks = ref([]);
  let annots = Cmt_format.read_cmt(cmt).Cmt_format.cmt_annots;
  switch annots {
  | Cmt_format.Implementation({str_items} as s) => {
    let (topdoc, allDocs) = PrepareDocs.findAllDocs(str_items);
    allDocs |> List.iter(PrepareDocs.iter(((name, docString, _)) => {
      fn(name, docString)
    }))
  }
  | Cmt_format.Interface({sig_items} as s) => {
    let (topdoc, allDocs) = PrepareDocs.findAllDocsIntf(sig_items);
    allDocs |> List.iter(PrepareDocs.iter(((name, docString, _)) => {
      fn(name, docString)
    }))
  }
  | _ => failwith("Not a valid cmt file")
  };
};

  /* TODO allow package-global settings, like "run this in node" */
let process = (markdowns, cmts, base) =>  {
    let codeBlocks = ref((0, []));
    let addBlock = (fileName, lang, contents) => {
      let options = parseCodeOptions(lang);
      switch (options) {
      | None => ()
      | Some(options) => {
        let (id, blocks) = codeBlocks^;
        codeBlocks := (id + 1, [(id, fileName, options, contents), ...blocks]);
      }
      }
    };

    let collect = (fileName) => Omd.Representation.visit(el => switch el {
      | Omd.Code_block(lang, contents) => {
        addBlock(fileName, lang, contents);
        None
      }
      | _ => None
    });

    markdowns |> List.iter(((path, contents, name)) => {
      let _ = collect(path, Omd.of_string(contents));
    });

    cmts |> List.iter(cmt => {
      iterDocstrings((name, docString) => {
        switch docString {
        | None => ()
        | Some(docString) =>
        let _ = collect(cmt ++ " > " ++ name, Omd.of_string(docString))
        }
      }, cmt)
    });

    let (_, blocks) = codeBlocks^;
    let src = base /+ "src";
    let blockFileName = id => codeBlockPrefix ++ string_of_int(id);
    blocks |> List.iter(((id, fileName, options, content)) => {
      Files.writeFile(src /+ blockFileName(id) ++ ".re", content ++ "/* " ++ fileName ++ " */") |> ignore
    });
    let (output, err, success) = Commands.execFull(base /+ "node_modules/.bin/bsb" ++ " -make-world -backend js");
    if (!success) {
      print_endline("Bsb output:");
      print_endline(String.concat("\n", output));
      failwith("Unable to run bsb on examples");
    };
    print_endline("Running tests");
    /* TODO run in parallel - maybe all in the same node process?? */
    blocks |> List.iter(((id, fileName, options, content)) => {
      print_endline(string_of_int(id) ++ " - " ++ fileName);
      let name = blockFileName(id);
      let cmt = base /+ "lib/bs/js/src/" ++ name ++ ".cmt";
      let js = base /+ "lib/js/src/" ++ name ++ ".js";
      if (!options.dontRun) {
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
      Unix.unlink(src /+ name ++ ".re");
      ()
    });
  };