
open ReasonReact;

module Styles = {
  open Css;
  global("body", [
    fontFamily("system-ui, sans-serif")
  ]);
  let dropdown = style([
    position(`absolute),
    top(`percent(100.)),
    display(`none),
    left(zero),
    whiteSpace(`nowrap),
  ]);
  let container = style([
    position(`relative),
    selector(":hover ." ++ dropdown, [
      zIndex(1000),
      backgroundColor(white),
      display(`block)
    ])
  ]);
  let button = style([
    padding(px(8)),
    hover([
      backgroundColor(hex("eee")),
    ]),
  ]);
  let title = style([
    padding(px(16)),
    cursor(`pointer),
    hover([
      backgroundColor(hex("eee")),
    ]),
  ])
};
open Styles;

[@bs.val] external examplesData: array({. "title": string, "code": string}) = "";

let component = statelessComponent("ExamplesDropdown");
let make = (~onSelect, _children) => {
  ...component,
  render: _self => {
    <div className=container>
      <div className=button>
      (ReasonReact.stringToElement("Examples"))
      </div>
      <div className=dropdown>
        {ReasonReact.arrayToElement(examplesData |> Array.map(item => (
          <div className=title onClick=(_evt => onSelect(item##code))>
            (ReasonReact.stringToElement(item##title))
          </div>
        )))}
      </div>
    </div>
  }
};

