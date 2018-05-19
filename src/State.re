
let indent = t => "  " ++ Str.global_replace(Str.regexp_string("\n"), "\n  ", t);
let showOption = (value, f) => switch value { | None => "(none)" | Some(v) => f(v) };
let showOptionString = v => showOption(v, s => s);

type bucklescriptOptions = {
  packageRoot: string,
  bsRoot: string,
  refmt: string,
  version: string,
  browserCompilerPath: option(string),
  silentFailures: bool,
  tmp: string, /* Where to put compilation artifacts */
  /* (cmt directory, js directory) */
  compiledDependencyDirectories: list((string, string)),
  packageJsonName: string,
};

let showBucklescriptOptions = ({
  packageRoot,
  bsRoot,
  refmt,
  version,
  browserCompilerPath,
  silentFailures,
  tmp,
  compiledDependencyDirectories,
  packageJsonName,
}) => Printf.sprintf({|packgeRoot: %s
bsRoot: %s
compiledDependencyDirectories:
%s
|}, packageRoot, bsRoot,
  compiledDependencyDirectories |> List.map(((cmt, js)) => "  " ++ cmt ++ " : " ++ js) |> String.concat("\n")
);

type backend = NoBackend | Bucklescript(bucklescriptOptions);

let showBackend = backend => switch backend {
| NoBackend => "no backend"
| Bucklescript(options) => showBucklescriptOptions(options)
};

module Model = {
  type codeContext = Normal | Node | Window | Iframe | Canvas | Div | Log;

  let contextString = c => switch c {
  | Normal => "normal"
  | Log => "log"
  | Node => "node"
  | Window => "window"
  | Iframe => "iframe"
  | Canvas => "canvas"
  | Div => "div"
  };

  type expectation =
    | Succeed
    | Raise
    | DontRun
    | TypeFail
    | DontType
    | ParseFail
    | Skip
    ;

  type codeDisplay = {
    prefix: int,
    suffix: int,
    noEdit: bool,
    hide: bool,
  };

  type lang = Reason | OCaml | Txt | OtherLang(string);
  let showLang = lang => switch lang {
  | Reason => "re"
  | OCaml => "ml"
  | Txt => "txt"
  | OtherLang(lang) => "lang(" ++ lang ++ ")"
  };

  type codeOptions = {
    context: codeContext,
    lang,
    expectation,
    codeDisplay,
    inferred: bool,
    /* openModule: bool, */
    sharedAs: option(string),
    uses: list(string),
  };

  let defaultOptions = {
    context: Normal,
    lang: Reason,
    inferred: true,
    expectation: Succeed,
    /* openModule: false, */
    codeDisplay: {
      prefix: 0,
      suffix: 0,
      noEdit: false,
      hide: false,
    },
    sharedAs: None,
    uses: [],
  };

  /* This doesn't apply if I only want to parse */
  type compilationResult =
    | Skipped
    | ParseError(string)
    | TypeError(string, string) /* error & cmt file */
    | Success(string, string); /* cmt, js files */
    /* ^ the js file bit doesn't apply */

  /** This represents the final result of a code block, all that's needed to render it */
  type codeBlock = {
    langLine: string,
    raw: string,
    html: string,
    page: string,
    filePath: string,
    /* Has it been evaluated yet? */
    compilationResult: compilationResult,
  };

  type id = string;

  type docWithExamples = Omd.t;
  /* (Omd.t, list(codeBlock)); */

  module Docs = {
    type docItem =
      | Value(Types.type_expr)
      | Type(Types.type_declaration)
      | Module(moduleContents)
      | Include(option(Path.t), list(doc))
      | StandaloneDoc(Omd.t)
    and moduleContents =
      | Items(list(doc))
      | Alias(Path.t)
    and doc = (string, option(Omd.t), docItem);

    let itemName = item => switch item {
    | Value(_) => "value"
    | Type(_) => "type"
    | Module(_) => "module"
    | Include(_) => "include"
    | StandaloneDoc(_) => "doc"
    };

    let rec iter = (fn, (name, docString, item) as doc) => {
      fn(doc);
      switch item {
      | Include(_, children) | Module(Items(children)) => List.iter(iter(fn), children)
      | _ => ()
      }
    };

    let rec iterWithPath = (~modulesAtPath, path, fn, (name, docString, item) as doc) => {
      fn(path, doc);
      switch item {
      | Include(_, children) => List.iter(iterWithPath(~modulesAtPath, path, fn), children)
      | Module(Items(children)) => List.iter(iterWithPath(~modulesAtPath, [name, ...path], fn), children)
      | Module(Alias(aliasPath)) => switch (Hashtbl.find(modulesAtPath, Path.name(aliasPath))) {
        | exception Not_found => print_endline("Unable to resolve module alias: " ++ Path.name(aliasPath))
        | children => List.iter(iterWithPath(~modulesAtPath, [name, ...path], fn), children)
        }
      | _ => ()
      }
    };
  };

  type customPage = {
    title: string,
    /* Missing if the page was generated. relative to repo root */
    sourcePath: option(string),
    destPath: string,
    contents: docWithExamples,
  };

  type sidebarListing = SidebarItem(string) | SidebarHeader(string, list(sidebarListing));
  type sidebar = {
    pages: list(sidebarListing),
    modules: list(string),
  };

  type topModule = {
    name: string,
    sourcePath: string,
    docs: option(docWithExamples),
    items: list(Docs.doc),
    stamps: CmtFindStamps.T.stamps,
  };

  type package = {
    name: string,
    repo: option(string),
    custom: list(customPage),
    sidebar: option(sidebar),
    modules: list(topModule),
    canBundle: bool,
    noPlayground: bool,

    /* For compiling snippets */
    namespaced: bool,
    backend,
    defaultCodeOptions: option(codeOptions),
  };

  /* Run through packages & collect codeBlocks for later processing */
  type codeBlocks = Hashtbl.t((string, string, string), codeBlock);

  /* Have some kind of "front-page"? idk */
  type world = {
    packages: list((string, package)),
  };
};

/**
 * Ok folks, so the above is what I think I want as the middle stage
 *
 * From this middle stage I'm confident I can produce some nice documentation.
 * Not 100% sure when compilation (code block processing) happens tho
 *
 * And now, how do I go from "cli args" to "that middle stage"
 *
 * There's probably a "first stage" that we get from cli args
**/
module Input = {
  type env = {
    static: string,
    debug: bool,
  };

  let showEnv = ({static, debug}) => Printf.sprintf("static: %S\ndebug: %B", static, debug);

  type meta = {
    packageName: string,
    repo: option(string),
  };

  let showMeta = ({packageName, repo}) => Printf.sprintf("packageName: %S\nrepo: %S", packageName, showOptionString(repo));

  type packageInput = {
    root: string,
    /* TODO might be nice to allow things that don't have a bsconfig */
    meta,
    backend,
    sidebarFile: option(string),
    /* abs path to .md, relpath to source, abs path to destination */
    customFiles: list((string, option(string), string)),
    /* abs path to .cmt(i), relpath to source */
    moduleFiles: list((string, string)),
    defaultCodeOptions: option(Model.codeOptions),
    namespaced: bool,
    canBundle: bool,
    noPlayground: bool,
  };

  let showPackageInput = ({root, meta, backend, sidebarFile, customFiles, moduleFiles, defaultCodeOptions, namespaced}) => Printf.sprintf(
    {|root: %S
meta:
%s

backend:
%s
sidebarFile: %S
customFiles:
%s
moduleFiles:
%s
|},
    root,
    showMeta(meta) |> indent,
    showBackend(backend) |> indent,
    sidebarFile |> showOptionString,
    customFiles |> List.map(
      ((absMd, relPath, absDest)) => Printf.sprintf("  abs-md: %S  rel-src: %S  abs-dest: %S", absMd, showOptionString(relPath), absDest)
    ) |> String.concat("\n"),
    moduleFiles |> List.map(
      ((absCmt, relPath)) => Printf.sprintf("  abs-cmt: %S  rel-src: %S", absCmt, relPath)
    ) |> String.concat("\n")
  );

  type target = {
    directory: string,
    /* TODO maybe use mustache? https://github.com/rgrinberg/ocaml-mustache */
    template: option(string),
    skipStdlibCompletions: bool,
    search: bool,
  };

  type t = {
    target,
    /* TODO allow multiple packages at some point */
    packageInput,
    env,
  };

  let show = ({target, packageInput, env}) => showPackageInput(packageInput) ++ "\nenv:\n" ++ indent(showEnv(env));
};
