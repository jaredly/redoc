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
    display(`flex),
    flexDirection(`column),
    alignItems(`center),
    minWidth(px(300)),
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
  ]);
  let codeMirrorMark = style([
    borderBottom(px(1), `dashed, red)
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

let initialString = {|
let x = 10;
Js.log(x);
Js.log("hello folks");
|};

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

let runCode = code => {
  let fn = {j|(function(exports, module, require) {
    $code
  })|j};
  let fn: 'obj => 'module_ => (string => 'package) => unit = eval(fn);
  let exports = Js.Obj.empty;
  let require = path => {
    switch (Js.Dict.get(bsRequirePaths, path)) {
    | Some(result) => packRequire(result)
    | None => packRequire(path)
    }
  };
  fn(exports, {"exports": exports}, require);
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

module Main = {
  type state = {
    text: string,
    /* autorun: bool, */
    mutable cm: option(codemirror),
    context,
    canvasSize: int,
    mutable shareInput: option(Dom.element),
    logs: list(string),
    resultJs: string,
    syntax,
    status,
  };
  type action =
    | Text(string)
    | Reset(string)
    | Js(string)
    | SetCanvasSize(int)
    | ToOCaml
    | ToReason
    | SetStatus(status);

  let (syntax, text, canvasSize) = parseUrl(href);

  let component = ReasonReact.reducerComponent("Main");
  let make = _children => {
    ...component,
    initialState: () => {
      text,
      logs: [],
      canvasSize,
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
    | Reset(text) => {
      state.cm |?< cm => setValue(cm, text);
      {...state, text}
    }
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
        state.cm |?< cm => clearMarks(cm);
        switch (state.syntax == Reason ? reasonCompile(text) : ocamlCompile(text)) {
        | Ok(js) => {
          runCode(js);
          send(Js(js))
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
            <button
              className=Styles.button
              onClick=(evt => state.cm |?< cm => run(getValue(cm)))
            >
              (str("Run"))
            </button>
            <div className=Css.(style([flex(1)]))/>
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
                state.cm = Some(cm)
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
        </div>
        <div className=Styles.previewPane style=ReactDOMRe.Style.make(~width=string_of_int(state.canvasSize) ++ "px", ())>
          <div>
          </div>
          <div>
            <h1>(str("Welcome to the Playground!"))</h1>
            (str("Press ctrl+enter or cmd+enter to evaluate"))
          </div>
          <div className=Styles.line />
          <div>
            (str("A"))
            <input
              onChange=(evt => send(SetCanvasSize(min(800, max(50, int_of_string(getInputValue(evt)))))))
              value=(string_of_int(state.canvasSize))
              _type="number"
            />
            (str("x " ++ string_of_int(state.canvasSize) ++ " canvas w/ id #canvas"))
          </div>
          <canvas id="canvas" width=(string_of_int(state.canvasSize) ++ "px") height=(string_of_int(state.canvasSize) ++ "px") className=Styles.canvas/>
          <div className=Styles.line />
          <div>
          (str("A div w/ id #target"))
          </div>
          <div className=Css.(style([padding(px(8))]))>
          <div id="target">
            (str("Render to #target to replace this content"))
          </div>
          </div>
          <div className=Styles.line />
          (str("The Javascript Output"))
          <pre className=Css.(style([
            whiteSpace(`preWrap),
            padding(px(8)),
            maxHeight(px(200)),
            overflow(`auto),
            backgroundColor(hex("eee"))
          ]))>(str(state.resultJs))</pre>
          <div className=Styles.line />
          (str("Log output"))
        </div>
      </div>
    }
  };
};

ReactDOMRe.renderToElementWithId(<Main />, "main");