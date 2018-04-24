
open Infix;

let module Styles = {
  open Css;
  let card = style([
    padding(px(16))
  ]);
};

open ReasonReact;

type syntax = OCaml | Reason;
type context = Window | Div | Canvas | Worker;

[@bs.val] [@bs.scope "ocaml"] external reason_compile: string => 'result = "";

type result('a, 'b) = Ok('a) | Error('b);

type pos = {row: int, column: int};
type compilationResult = result(string, (string, pos, pos));

let reasonCompile = code => {
  let result = reason_compile(code);
  switch (Js.Nullable.to_opt(result##js_code)) {
  | Some(js) => Ok(js)
  | None => Error((result##js_error_msg, {row: result##row, column: result##column}, {row: result##endRow, column: result##endColumn}))
  }
};

let module Main = {
  type state = {
    syntax,
    compilationResult,
  };
  let component = ReasonReact.reducerComponent("Main");
  let make = (_children) => {
    ...component,
    initialState: () => (),
    reducer: ((), ()) => ReasonReact.NoUpdate,
    render: (_self) => <div/>
  }
};

ReactDOMRe.renderToElementWithId(<Main />, "main");