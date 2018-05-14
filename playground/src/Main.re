open Infix;
open Utils;

/*
 * Things I want
 *
 * - show js if you want it
 * - toggle to ocaml if you want it
 *
 * [Right sidebar]
 * [generated js]
 * [canvas]
 * [div]
 * [logs]
 *
 */

module Styles = {
  open Css;
  global(".CodeMirror", [
    flex(1),
    height(`auto)
  ]);
  let card = style([padding(px(16))]);
  let container = style([
    flex(1),
    display(`flex),
    flexDirection(`row),
  ]);
  let editorPane = style([
    flex(1),
    position(`relative),
    display(`flex),
    flexDirection(`column),
  ]);
  let previewPane = style([
    position(`relative),
    display(`flex),
    flexDirection(`column),
    alignItems(`center),
    minWidth(px(500)),
    overflow(`auto),
    zIndex(10),
    boxShadow(~blur=px(3), hex("aaa")),
    padding(px(16)),
  ]);
  let error = style([
    whiteSpace(`preWrap),
    fontFamily("monospace"),
    padding(px(8)),
    border(px(4), `solid, `hex("faa")),
    position(`absolute),
    bottom(px(0)),
    right(px(0)),
    zIndex(10),
    backgroundColor(white),
  ]);
  let codeMirrorMark = style([
    borderBottom(px(1), `dashed, red),
    backgroundColor(hex("fee")),
  ]);

  let top = style([
    display(`flex),
    alignItems(`center),
    flexDirection(`row),
    padding2(~v=px(4), ~h=px(8)),
  ]);
  let canvas = style([
    boxShadow(~x=px(0), ~y=px(1), ~blur=px(5), hex("aaa")),
    margin(px(16))
  ]);
  let line = style([
    backgroundColor(hex("aaa")),
    margin2(~v=px(8), ~h=zero),
    height(px(1)),
    alignSelf(`stretch)
  ]);

  let button = style([
    backgroundColor(white),
    boxShadow(~blur=px(3), hex("aaa")),
    borderStyle(`none),
    padding2(~v=px(8), ~h=px(16)),
    cursor(`pointer),
    disabled([
      backgroundColor(hex("eee")),
      cursor(`default),
    ]),
  ]);

};

let spacer = n => <div style=ReactDOMRe.Style.(make(~flexBasis=(string_of_int(n) ++ "px"), ())) />;

open ReasonReact;

type syntax =
  | OCaml
  | Reason;

let showSyntax = s => switch s {
| OCaml => "OCaml"
| Reason => "Reason"
};

let syntaxFromString = s => switch s {
| "OCaml" => OCaml
| _ => Reason
};

let initialString = ExamplesDropdown.examplesData[0]##code;

let parseUrl = s => {
  switch (Js.String.split("?", s)) {
  | [|_|] => (Reason, initialString, 200)
  | [|_, params|] => {
    let items = Js.String.split("&", params) |> Array.to_list |> List.map(item => switch (Js.String.split("=", item)) {
    | [|name|] => (name, "")
    | [|name, value|] => (name, value)
    | _ => ("", "")
    });
    let syntax = switch (List.assoc("syntax", items)) {
    | exception Not_found => Reason
    | name => syntaxFromString(name)
    };
    let canvasSize = switch (List.assoc("canvas", items)) {
    | exception Not_found => 200
    | text => switch (int_of_string(text)) {
      | exception _ => 200
      | num => num
      }
    };
    let code = switch (List.assoc("code", items)) {
    | exception Not_found => initialString
    | code => decompress(code)
    };
    (syntax, code, canvasSize)
  }
  | _ => (Reason, initialString, 200)
  }
};

let makeUrl = (code, syntax, canvasSize) => {
  let data = compress(code);
  origin ++ pathname ++ "?syntax=" ++ showSyntax(syntax) ++ "&code=" ++ data ++ "&canvas=" ++ string_of_int(canvasSize);
};

type compilationResult = result(string, (string, pos, pos));

type window;
[@bs.val] external window: window = "";
type console;
[@bs.get] external console: window => console = "";
[@bs.set] external setConsole: window => console => unit = "console";

let runCode = (code, addLog) => {
  /* let oldConsole = console(window); */
  let fn = {j|(function(exports, module, require, addLog) {
    var oldConsole = window.console;
    var console = Object.assign({}, window.console, {
      log: (...items) => {oldConsole.log(...items); addLog('log', items.map(i => JSON.stringify(i)).join(' '))},
      warn: (...items) => {
        oldConsole.warn(...items); addLog('warn', JSON.stringify(items))
      },
      error: (...items) => {
        oldConsole.error(...items); addLog('error', JSON.stringify(items))
      },
    });
    /* try { */
    $code
    /* } catch(e) { */
      /* window.console = oldConsole; */
      /* throw e */
    /* } */
  })|j};
  let fn: 'obj => 'module_ => (string => 'package) => ((. string, string) => unit) => unit = eval(fn);
  let exports = Js.Obj.empty;
  let require = path => {
    switch (Js.Dict.get(bsRequirePaths, path)) {
    | Some(result) => packRequire(result)
    | None => packRequire(path)
    }
  };
  try {
    fn(exports, {"exports": exports}, require, addLog);
  } {
    | exn => {
      Js.log(exn);
      let e: Js.Exn.t = Obj.magic(exn);
      switch (Js.Exn.message(e), Js.Exn.stack(e)) {
      | (Some(message), Some(stack)) => addLog(. "error", message ++ "\n" ++ stack)
      | _ => {
        switch exn {
        | Failure(message) => addLog(. "error", "Failure(" ++ message ++ ")")
        | _ => addLog(. "error", Js.Json.stringifyAny(e) |? "Unknown error")
        }
      }
      };
      Js.Global.setTimeout(() => {
        Js.log("Running again so you can catch it");
        fn(exports, {"exports": exports}, require, addLog);
      }, 10) |> ignore
    }
  };
};

type status =
  | Clean
  | Failed(string, pos, pos)
  | ParseFailure(string)
  | Dirty;

type windowContext = {
  canvas: bool,
  div: bool,
  log: bool,
};
type context = Worker | Window(windowContext);

let str = ReasonReact.stringToElement;

module HighlightResult = {
  open ReasonReact;
  let component = reducerComponent("HighlightResult");
  let make = (~rendered, ~tokens, _children) => {
    ...component,
    initialState: () => ref(None),
    reducer: ((), _) => NoUpdate,
    render: ({state}) => {
      <div
        dangerouslySetInnerHTML={"__html": rendered}
        ref={node => Js.toOption(node) |?< node => {
          if (state^ == None) {
            state := Some(node);
            tokens |> Array.iter(token => highlightNode(. node, token))
          }
        }}
      />
    }
  };
};

let previewPane = (
  ~toggleExpand,
  ~canvasSize,
  ~onChange,
  ~clearSearch,
  ~onChangeCanvas,
  ~searching,
  ~expandJs,
  ~resultJs,
  ~logs,
) =>
  <div className=Styles.previewPane style=ReactDOMRe.Style.make(~width=string_of_int(canvasSize) ++ "px", ())>
  <div className=Css.(style([
    /* display(`flex), */
    /* flexDirection(`row), */
    /* alignItems(`center), */
    position(`relative),
    alignSelf(`stretch),
  ]))>
  <input
    className=Css.(style([
    border(px(1), `solid, hex("ccc")),
      padding2(~v=px(8), ~h=px(16)),
      borderStyle(`none),
      /* flex(1), */
      width(`percent(100.)),
      boxSizing(`borderBox),
    ]))
    value=searching
    onChange=onChange
    placeholder="Search the docs inline"
  />
  (searching != ""
  ? <button onClick=(_evt => clearSearch()) className=Css.(style([
    position(`absolute),
    top(px(5)),
    right(px(5)),
    fontSize(px(16)),
    fontWeight(600),
    borderStyle(`none),
    cursor(`pointer),
    zIndex(20),
  ]))>(str("x"))</button>
  : ReasonReact.nullElement)
  </div>
  <div>
    <h1 className=Css.(style([
    fontSize(px(30)),
    lineHeight(1.1),
    textAlign(`center),
    ]))>(str("Welcome to the Playground!"))</h1>
    (str("Press ctrl+enter or cmd+enter to evaluate"))
  </div>
  <div className=Styles.line />
  <div>
    (str("A"))
    <input
      onChange=onChangeCanvas
      className=Css.(style([width(px(40))]))
      value=(string_of_int(canvasSize))
      _type="number"
    />
    (str("x " ++ string_of_int(canvasSize) ++ " canvas w/ id #canvas"))
  </div>
  <canvas id="canvas" width=(string_of_int(canvasSize) ++ "px") height=(string_of_int(canvasSize) ++ "px") className=Styles.canvas/>
  <div className=Styles.line />
  <div>
  (str("A div w/ id #target"))
  </div>
  <div className=Css.(style([
    padding2(~v=px(4), ~h=px(8)),
    margin2(~v=px(8), ~h=zero),
    boxShadow(~blur=px(3), hex("aaa")),
    ]))>
  <div id="target">
    (str("Render to #target to replace this content"))
  </div>
  </div>
  <div className=Styles.line />
  (str("The Javascript Output"))
  <pre className=Css.(style([
    whiteSpace(`preWrap),
    wordBreak(`breakAll),
    padding(px(8)),
    minHeight(px(100)),
    overflow(`auto),
    ...(expandJs ? [
      position(`absolute),
      top(px(50)),
      bottom(px(10)),
      height(`auto),
      left(px(5)),
      right(px(5)),
      width(`auto)
    ] : [
      maxHeight(px(200)),
      position(`relative),
      width(`percent(100.)),
    ])
  ]))>
  <div className=Css.(style([
    position(`absolute),
    top(px(5)),
    zIndex(100),
    cursor(`pointer),
    right(px(10)),
  ])) onClick=(_evt => toggleExpand())>
    (str({j|⇱|j}))
  </div>
  <code>(str(resultJs))</code></pre>
  <div className=Styles.line />
  (str("Log output"))
  <div className=Css.(style([
  alignSelf(`stretch),
  width(`percent(100.)),
  marginTop(px(16))
  ]))>
  {ReasonReact.arrayToElement(
    List.rev(logs)
    |> Array.of_list
    |> Array.mapi((i, (typ, item)) => (
      <div key=(string_of_int(i)) className=Css.(style([
        backgroundColor(typ == "warn" ? hex("faf") : (typ == "error" ? hex("faa") : white)),
        wordBreak(`breakAll),
        overflow(`auto),
        borderTop(px(1), `solid, hex("eee")),
        padding(px(4))
      ]))>
        (str(item))
      </div>
    ))
  )}
  </div>
  {searching != ""
  ?
  <div className=Css.(style([
    position(`absolute),
    top(px(50)),
    bottom(zero),
    overflow(`auto),
    left(zero),
    right(zero),
    backgroundColor(white),
  ]))>
  ({
    let results = searchIndex(searching) |> Js.Array.slice(~start=0, ~end_=20);
    let results = results |> Array.mapi((i, result) => (
      <div className="result" key=(string_of_int(i))>
        <div className=Css.(style([
          display(`flex),
          justifyContent(`spaceBetween),
        ]))>
          <div className="title">(str(result##doc##title))</div>
          <div className="breadcrumb">(str(result##doc##breadcrumb))</div>
        </div>
          <HighlightResult
            rendered=(result##doc##rendered)
            tokens=(searching |> Js.String.splitByRe([%bs.re {|/\s+/g|}]))
          />
      </div>
    ));
    if (results == [||]) {
      str("No results")
    } else {
      ReasonReact.arrayToElement(results)
    }
  })
  </div>
  : ReasonReact.nullElement}
</div>
;

module Main = {
  type state = {
    text: string,
    /* autorun: bool, */
    mutable cm: option(codemirror),
    context,
    canvasSize: int,
    mutable shareInput: option(Dom.element),
    logs: list((string, string)),
    resultJs: string,
    expandJs: bool,
    searching: string,
    currentCompletion: option(completionItem),
    syntax,
    status,
  };


  type action =
    | Text(string)
    | Reset(string)
    | Js(string)
    | SetCanvasSize(int)
    | AddLog(string, string)
    | ToggleJsExpand
    | ClearLogs
    | ToOCaml
    | ToReason
    | AutoFormat
    | CompletionSelected(Utils.completionItem)
    | CompletionCleared
    | SetSearch(string)
    | SetStatus(status);

  let (syntax, text, canvasSize) = parseUrl(href);

  let component = ReasonReact.reducerComponent("Main");
  let make = _children => {
    ...component,
    initialState: () => {
      text,
      logs: [],
      searching: "",
      canvasSize,
      expandJs: false,
      currentCompletion: None,
      /* autorun: true, */
      shareInput: None,
      context: Window({
        canvas: false,
        div: false,
        log: false,
      }),
      resultJs: "/* Evaluate to see generated js */",
      status: Clean,
      syntax,
      cm: None
    },

    reducer: (action, state) => Update(switch action {
    | Text(text) => {...state, text}
    | Js(js) => {...state, status: Clean, resultJs: js}
    | SetSearch(searching) => {...state, searching}
    | Reset(text) => {
      state.cm |?< cm => setValue(cm, text);
      {...state, text}
    }
    | ToggleJsExpand => {...state, expandJs: !state.expandJs}
    | CompletionCleared => {...state, currentCompletion: None}
    | CompletionSelected(item) => {...state, currentCompletion: Some(item)}
    | AddLog(typ, text) => {...state, logs: [(typ, text), ...state.logs]}
    | ClearLogs => {...state, logs: []}
    | SetCanvasSize(canvasSize) => {...state, canvasSize}
    | ToOCaml => {
      state.cm |?>> (cm => {
        let text = getValue(cm);
        try {
          setValue(cm, printML(parseRE(text)));
          {...state, syntax: OCaml}
        } {
          /* show an error */
          | _ => {...state, status: ParseFailure("Syntax error")}
        }
      }) |? state;
    }
    | AutoFormat => {
      state.cm |?>> (cm => {
        let text = getValue(cm);
        try {
          setValue(cm, printRE(parseRE(text)));
          state
        } {
          /* show an error */
          | _ => {...state, status: ParseFailure("Syntax error")}
        }
      }) |? state;
    }
    | ToReason => {
      state.cm |?>> (cm => {
        let text = getValue(cm);
        try {
          setValue(cm, printRE(parseML(text)));
          {...state, syntax: Reason}
        } {
          /* show an error */
          | _ => {...state, status: ParseFailure("Syntax error")}
        }
      }) |? state;
    }
    | SetStatus(status) => {...state, status}
    }),

    render: ({state, send}) => {
      let run = text => {
        let url = makeUrl(text, state.syntax, state.canvasSize);
        replaceState(url);
        send(ClearLogs);
        state.cm |?< cm => clearMarks(cm);
        switch (state.syntax == Reason ? reasonCompile(text) : ocamlCompile(text)) {
        | Ok(js) => {
          /* runCode(js, (. typ, text) => {
            send(AddLog(typ, text))
          }); */
          send(Js(Bundle.bundle(js, Js.Dict.empty())))
        }
        | Error((text, spos, epos)) => {
          state.cm |?< cm => markText(cm, jsPos(spos), jsPos(epos), {"className": Styles.codeMirrorMark});
          send(SetStatus(Failed(text, spos, epos)))
        }
        }
      };

      <div className=Styles.container>
        <div className=Styles.editorPane>
          <div className=Styles.top>
            <ExamplesDropdown
              onSelect=(text => send(Reset(text)))
            />
            <div className=Css.(style([flex(1)]))/>
            <button
              className=Styles.button
              onClick=(evt => state.cm |?< cm => run(getValue(cm)))
            >
              (str("Run"))
            </button>
            (spacer(8))
            <button
              disabled=(state.syntax == OCaml)
              className=Styles.button
              onClick=(evt => send(AutoFormat))
              /* title="Cmd+f / Ctrl+f" */
            >
              (str("Auto Format"))
            </button>
            (spacer(8))
            (str("Syntax:"))
            (spacer(8))
            <button
              disabled=(state.syntax == OCaml)
              className=Styles.button
              onClick=(evt => send(ToOCaml))
            >
              (str("OCaml"))
            </button>
            <button
              disabled=(state.syntax == Reason)
              className=Styles.button
              onClick=(evt => send(ToReason))
            >
              (str("Reason"))
            </button>
            <input
              ref={r => Js.toOption(r) |?< node => state.shareInput = Some(node)}
              style=ReactDOMRe.Style.make(~width="0", ~visibility="hidden", ())
            />
            <button
              className=Styles.button
              onClick=(evt => {
                state.shareInput |?< input => state.cm |?< cm => {
                  let url = makeUrl(getValue(cm), state.syntax, state.canvasSize);
                  setInput(input, url);
                  select(input);
                  execCommand("copy");
                  replaceState(url);
                }
              })
            >
              (str("Copy permalink"))
            </button>
          </div>
          <textarea
            value={state.text}
            ref={r => Js.toOption(r) |?< node => {
              if (state.cm == None) {
                let cm = fromTextArea(. node, run);
                state.cm = Some(cm);
                setCm(Utils.window, cm);
                let onSelect = item => send(CompletionSelected(item));
                let onClose = () => send(CompletionCleared);
                registerComplete(cm, cm => autoComplete(cm, onSelect, onClose));
              }
            }}
          />
          {switch state.status {
          | Failed(message, spos, epos) => {
            let inner = {"__html": fixEscapes(message) };
            <div className=Styles.error dangerouslySetInnerHTML={inner} />
          }
          | ParseFailure(message) => <div className=Styles.error>(str(message))</div>
          | _ => ReasonReact.nullElement
          }}
          {state.currentCompletion |?> (item => Js.toOption(item##docs) |?>> (docs => {

            <div
              className=Css.(style([
                /* position(`absolute), */
                maxHeight(px(400)),
                overflow(`auto),
                bottom(zero),
                left(zero),
                right(zero),
                padding2(~v=px(8), ~h=px(16)),
                backgroundColor(white),
                boxShadow(~blur=px(3), hex("aaa")),
                zIndex(1000),
              ]))
            >
              <div
                className=Css.(style([
                  /* whiteSpace(`preWrap), */
                ]))
                dangerouslySetInnerHTML={"__html": docs}
              />
            </div>
          })) |? ReasonReact.nullElement}
        </div>

        (previewPane(
          ~toggleExpand=() => send(ToggleJsExpand),
          ~canvasSize=state.canvasSize,
          ~searching=state.searching,
          ~expandJs=state.expandJs,
          ~resultJs=state.resultJs,
          ~logs=state.logs,
          ~onChange=(evt => send(SetSearch(getInputValue(evt)))),
          ~clearSearch=() => send(SetSearch("")),
          ~onChangeCanvas=(evt => send(SetCanvasSize(min(800, max(50, int_of_string(getInputValue(evt))))))),
        ))

      </div>
    }
  };
};

ReactDOMRe.renderToElementWithId(<Main />, "main");