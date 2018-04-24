open Infix;

[@bs.val] [@bs.scope "ocaml"] external reason_compile : string => 'result = "";
[@bs.val] [@bs.scope "Colors"] external parseAnsi : string => {. "spans": array({. "text": string, "css": string})} = "parse";
[@bs.val] external eval: string => 'a = "";

type codemirror;
type textarea = Dom.element;

let fromTextArea: (. textarea, string => unit) => codemirror = [%bs.raw {|
  function(textarea, onRun) {
    var betterShiftTab = /*onInfo => */cm => {
      var cursor = cm.getCursor()
        , line = cm.getLine(cursor.line)
        , pos = {line: cursor.line, ch: cursor.ch}
      cm.execCommand('indentLess')
    }

    var betterTab = /*onComplete => */cm => {
      if (cm.somethingSelected()) {
        return cm.indentSelection("add");
      }
      const cursor = cm.getCursor()
      const line = cm.getLine(cursor.line)
      const pos = {line: cursor.line, ch: cursor.ch}
      cm.replaceSelection(Array(cm.getOption("indentUnit") + 1).join(" "), "end", "+input");
    }

    var run = function(cm) {
      onRun(cm.getValue())
    }

    var cm = CodeMirror.fromTextArea(textarea, {
      lineNumbers: true,
      lineWrapping: true,
      viewportMargin: Infinity,
      extraKeys: {
        'Cmd-Enter': (cm) => onRun(cm.getValue()),
        'Ctrl-Enter': (cm) => onRun(cm.getValue()),
        Tab: betterTab,
        'Shift-Tab': betterShiftTab,
      },
      mode: 'rust',
    })
    return cm
  }
|}];

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
  ]);
  let previewPane = style([
    width(px(300))
  ]);
};

open ReasonReact;

type syntax =
  | OCaml
  | Reason;

type context =
  | Window
  | Div
  | Canvas
  | Worker;

type result('a, 'b) =
  | Ok('a)
  | Error('b);

type pos = {
  row: int,
  column: int
};

type compilationResult = result(string, (string, pos, pos));

let htmlEscape = text => text
|> Js.String.replace("&", "&amp;")
|> Js.String.replace("<", "&lt;")
|> Js.String.replace(">", "&gt;")
;

let fixEscapes = message => message
|> Js.String.replace({js|\u001b[1;|js}, {js|\u001b[|js})
|> Js.String.replace({js|\u001b[0m|js}, {js|\u001b[39m|js})
|> parseAnsi
|> result => result##spans
|> Array.map(span => {
  let css = span##css;
  let text = htmlEscape(span##text);
  {j|<span style="$css">$text</span>|j}
});

let reasonCompile = code => {
  let result = reason_compile(code);
  switch (Js.Nullable.toOption(result##js_code)) {
  | Some(js) => Ok(js)
  | None =>
    Error((
      result##js_error_msg,
      {row: result##row, column: result##column},
      {row: result##endRow, column: result##endColumn}
    ))
  };
};

let runCode = code => {
  let fn = {j|(function(exports, module, require) {
    $code
  })|j};
  let fn = eval(fn);
  let exports = Js.Obj.empty;
  let require = path => {
    Js.log("Wanting " ++ path);
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
    initialState: () => {text: initialString, autorun: true, context: Div, status: Clean, syntax: Reason, cm: None},
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
                state.cm = Some(fromTextArea(. node, text => {
                  Js.log("Executing text " ++ text);
                  switch (reasonCompile(text)) {
                  | Ok(js) => {
                    Js.log("Got js " ++ js);
                    runCode(js);
                  }
                  | Error((text, spos, epos)) => {
                    send(SetStatus(Failed(text, spos, epos)))
                  }
                  }
                }))
              }
            }}
          />
        </div>
      </div>
    }
  };
};

ReactDOMRe.renderToElementWithId(<Main />, "main");