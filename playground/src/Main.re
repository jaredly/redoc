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
  let card = style([padding(px(16))]);
  let container = style([
    flex(1),
    display(`flex),
    flexDirection(`row),
  ]);
  let editorPane = style([
    flex(1),
    position(`relative),
  ]);
  let previewPane = style([
    width(px(300))
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
};

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

module Main = {
  type state = {
    text: string,
    autorun: bool,
    mutable cm: option(codemirror),
    context,
    syntax,
    status,
  };
  type action =
    | Text(string)
    | SetStatus(status);
  let component = ReasonReact.reducerComponent("Main");
  let make = _children => {
    ...component,
    initialState: () => {
      text: initialString,
      autorun: true,
      context: Window({
        canvas: false,
        div: false,
        log: false,
      }),
      status: Clean,
      syntax: Reason,
      cm: None
    },
    reducer: (action, state) => Update(switch action {
    | Text(text) => {...state, text}
    | SetStatus(status) => {...state, status}
    }),
    render: ({state, send}) => {
      <div className=Styles.container>
        <div className=Styles.editorPane>
          <textarea
            value={state.text}
            ref={r => Js.toOption(r) |?< node => {
              if (state.cm == None) {
                let cm = fromTextArea(. node, text => {
                  state.cm |?< cm => clearMarks(cm);
                  switch (reasonCompile(text)) {
                  | Ok(js) => {
                    runCode(js);
                    send(SetStatus(Clean))
                  }
                  | Error((text, spos, epos)) => {
                    state.cm |?< cm => markText(cm, jsPos(spos), jsPos(epos), {"className": Styles.codeMirrorMark});
                    send(SetStatus(Failed(text, spos, epos)))
                  }
                  }
                });
                state.cm = Some(cm)
              }
            }}
          />
          {switch state.status {
          | Failed(message, spos, epos) => {
            switch (state.cm) {
            | None => ()
            | Some(cm) => {
              ()
            }
            };
            let inner = {"__html": fixEscapes(message) };
            <div className=Styles.error dangerouslySetInnerHTML={inner} />
          }
          | Clean => ReasonReact.nullElement
          | Dirty => ReasonReact.nullElement
          }}
        </div>
      </div>
    }
  };
};

ReactDOMRe.renderToElementWithId(<Main />, "main");