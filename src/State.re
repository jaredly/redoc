
/**
 * Grand theory of everything.
*

The basic idea is a page
Also, larger than that we have packages
but let's talk about pages for now

Markdown page
- gets parsed into bits
- including some code snippets
- its then represented as `(Omd.t, list(lang, block))`? maybe

A markdown page can embed items
an item is a module, type, value, or include
(module types too probably)

an item can have documentation, which is in turn a markdown page(?) or markdown thing

Custom markdown things I want to represent:
- @doc [items]
- @all
- @rest

umm @includes? How can I do that...

Also, to what extent do I want to build everything into a globally addressable map?

Each @doc'able item should have a canonical home, where it can be expected to live.
It's possible to display the docs elsewhere, but it has to be shown there as well.

A markdown page is either part of the custom docs, or the api docs.
If part of the api docs, then listed in the sidebar there, and exists under api/
if in the custom docs, then listed in the custom docs portion
which takes up the top section of the sidebar

I want to mess with the sidebar to allow showing more or less of each section
(custom docs list, table of contents, api docs list)

*/

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

  /* Note: BsbNative backend doesn't support any of the code contexts */
  type backend = Jsoo | Bucklescript | BsbNative;

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

  type syntax = Reason | OCaml;

  type codeOptions = {
    context: codeContext,
    syntax,
    /* backend, */
    expectation,
    codeDisplay,
    sharedAs: option(string),
    uses: list(string),
  };

  let defaultOptions = {
    context: Normal,
    syntax: Reason,
    /* TODO I think this has to live at the package level? */
    /* backend: Bucklescript, */
    expectation: Succeed,
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

  type codeBlock = {
    raw: string,
    html: string,
    filePath: string,
    /* Has it been evaluated yet? */
    compilationResult: option(compilationResult),
  };

  type id = string;

  type docWithExamples = (Omd.t, list(codeBlock));

  type module_ = {
    contents: moduleContents,
  } and moduleItem =
    | Module(module_)
    | Type(Types.type_declaration)
    | Value(Types.type_expr)
    | Include(module_)
  and moduleContents = | Items(list(itemWithDocs)) | Alias(Path.t)
  and itemWithDocs = (string, option(docWithExamples), moduleItem)
    ;




  type customPage = {
    title: string,
    /* Missing if the page was generated. relative to repo root */
    sourcePath: option(string),
    destPath: string,
    contents: docWithExamples,
  };

  type sidebar = SidebarItem(string) | SidebarHeader(string, list(string));

  type topModule = {
    name: string,
    sourcePath: string,
    docs: option(docWithExamples),
    contents: list(itemWithDocs),
  };

  type package = {
    name: string,
    repo: option(string),
    custom: list(customPage),
    sidebar: option(sidebar),
    namespaced: bool,
    defaultCodeOptions: option(codeOptions),
    modules: Hashtbl.t(string, topModule),
    /* For compiling snippets */
    compiledDependencyDirectories: list(string),
  };

  /* Have some kind of "front-page"? idk */
  type world = {
    packages: Hashtbl.t(string, package),
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
    /* If this is absent, no compilation for you!! (or syntax highlighting) */
    bsRoot: option(string),
    refmt: option(string),
  };

  type meta = {
    packageName: string,
    repo: option(string),
  };

  type packageInput = {
    root: string,
    /* TODO might be nice to allow things that don't have a bsconfig */
    meta,
    sidebarFile: option(string),
    customFiles: list(string),
    /* abs path to .cmt(i), relpath to source */
    moduleFiles: list((string, string)),
    compiledDependencyDirectories: list(string),
  };

  type target = {
    directory: string,
    /* TODO maybe use mustache? https://github.com/rgrinberg/ocaml-mustache */
    template: option(string),
    search: bool,
  };

  type t = {
    target,
    /* TODO allow multiple packages at some point */
    packageInput,
    env,
  };
};

let inputFromArgs = argv => {
  /* TODO parse */
  failwith("Not impl")
};

let packageFromInput = (package, env) => {
  failwith("nope")
};

let outputPackage = (package, target) => {
  ()
};

let main = () => {
  let input = inputFromArgs(Sys.argv);
  let package = packageFromInput(input.Input.packageInput, input.Input.env);
  outputPackage(package, input.Input.target);
};
