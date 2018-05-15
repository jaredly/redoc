

let appJs = "import React from 'react'; import Reason from './reason.js'; export default class App extends React.Component { render() { return <Reason /> } }";

type config = {.
  "files": {. "app.js": string, "reason.js": string},
  "sdkVersion": string,
  "deviceId": string,
  "name": string,
};

type snackSession;
[@bs.new] [@bs.module "snack-sdk"] external snackSession : config => snackSession = "SnackSession";
[@bs.send] external startAsync: snackSession => Js.Promise.t(unit) = "";
[@bs.send] external addLogListener: snackSession => ('a => unit) => unit = "";
[@bs.send] external addErrorListener: snackSession => ('a => unit) => unit = "";
[@bs.send] external addPresenceListener: snackSession => ('a => unit) => unit = "";

let files = reasonBundle => { "app.js": appJs, "reason.js": reasonBundle };

type state = {
  session: snackSession,
  log: string,
  error: string,
  presence: string,
  status: [ `NotStarted | `Started],
};

let withSession = session => {log: "", error: "", presence: "", session, status: `NotStarted};

type action =
  | UseSession(snackSession)
  | Started
  ;

let component = ReasonReact.reducerComponent("Snack");

let module IdForm = {
  let component = ReasonReact.reducerComponent("Snack");
  let make = (~onSubmit, _children) => {
    ...component,
    initialState: () => "",
    reducer: (newState, _) => ReasonReact.Update(newState),
    render: ({state, send}) => <div>
      (ReasonReact.stringToElement("Enter your deviceId to connect"))
      <input
        onChange=(evt => send(Utils.getInputValue(evt)))
        value={state}
        placeholder="e.g. xxxx-xxxx"
      />
      <button
        onClick=(_evt => onSubmit(state))
      >
        (ReasonReact.stringToElement("Connect"))
      </button>
    </div>
  }

};

let make = (~bundledJs, _children) => {
  ...component,
  initialState: () => None,
  reducer: (action, state) => switch state {
  | None => switch action {
    | UseSession(session) => ReasonReact.Update(Some(withSession(session)))
    | _ => ReasonReact.NoUpdate
    }
  | Some(state) => switch action {
    | Started => ReasonReact.Update(Some({...state, status: `Started}))
    | _ => ReasonReact.NoUpdate
  }
  },
  render: ({state, send}) => {
    <div>
      <IdForm onSubmit=(deviceId => {
        let session = snackSession({
          "files": files(bundledJs),
          "sdkVersion": "27.0.0",
          "deviceId": deviceId,
          "name": "Reason Snack",
        });
        send(UseSession(session));
        addLogListener(session, log => Js.log(log));
        addErrorListener(session, log => Js.log(log));
        addPresenceListener(session, log => Js.log(log));
        startAsync(session) |> Js.Promise.then_(() => {
          send(Started);
          Js.Promise.resolve(())
        }) |> ignore;
      }) />
      (switch state {
      | None => ReasonReact.nullElement
      | Some({session, log, error, presence}) =>
        <div>
          (ReasonReact.stringToElement("Connected! I think."))
        </div>
      })
    </div>
  }
};
