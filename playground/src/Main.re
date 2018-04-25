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
    width(px(300)),
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

let initialString = {|
let x = 10;
Js.log(x);
Js.log("hello folks");
|};

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
    autorun: bool,
    mutable cm: option(codemirror),
    context,
    mutable shareInput: option(Dom.element),
    resultJs: string,
    syntax,
    status,
  };
  type action =
    | Text(string)
    | Reset(string)
    | Js(string)
    | ToOCaml
    | ToReason
    | SetStatus(status);

  let component = ReasonReact.reducerComponent("Main");
  let make = _children => {
    ...component,
    initialState: () => {
      text: initialString,
      autorun: true,
      shareInput: None,
      context: Window({
        canvas: false,
        div: false,
        log: false,
      }),
      resultJs: "/* Evaluate to see generated js */",
      status: Clean,
      syntax: Reason,
      cm: None
    },

    reducer: (action, state) => Update(switch action {
    | Text(text) => {...state, text}
    | Js(js) => {...state, status: Clean, resultJs: js}
    | Reset(text) => {
      state.cm |?< cm => setValue(cm, text);
      {...state, text}
    }
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
        <div className=Styles.previewPane>
          <div>
            <input
              ref={r => Js.toOption(r) |?< node => state.shareInput = Some(node)}
            />
            <button
              className=Styles.button
              onClick=(evt => {
                state.shareInput |?< input => state.cm |?< cm => {
                  setInput(input, compress(getValue(cm)))
                }
                /* let input = document.getElementById('shareableUrl');
      input.select();
      document.execCommand('copy');
      const compress = lzString.compressToEncodedURIComponent;
      const decompress = lzString.decompressFromEncodedURIComponent; */
              })
            >
              (str("Copy link"))
            </button>
          </div>
          <div>
            <h1>(str("Welcome to the Playground!"))</h1>
            (str("Press ctrl+enter or cmd+enter to evaluate"))
          </div>
          <div className=Styles.line />
          <div>
            (str("A 200 x 200 canvas w/ id #canvas"))
          </div>
          <canvas id="canvas" width="200px" height="200px" className=Styles.canvas/>
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
            backgroundColor(hex("eee"))
          ]))>(str(state.resultJs))</pre>
        </div>
      </div>
    }
  };
};

ReactDOMRe.renderToElementWithId(<Main />, "main");