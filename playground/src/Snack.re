

let appJs = "import React from 'react'; import Reason from './reason.js'; export default class App extends React.Component { render() { return <Reason /> } }";

type file = {. "type": string, "contents": string};
type files = {. "app.js": file, "reason.js": file};
type config = {.
  "files": files,
  "sessionId": string,
  "sdkVersion": string,
  "deviceId": string,
  "name": string,
};

let sessionId = [%bs.raw {|window.localStorage.snackSessionId || (window.localStorage.snackSessionId = Math.random().toString(32).slice(2))|}];

type snackSession;
[@bs.new] [@bs.module "snack-sdk"] external snackSession : config => snackSession = "SnackSession";
[@bs.send] external startAsync: snackSession => Js.Promise.t(unit) = "";
[@bs.send] external addLogListener: snackSession => ('a => unit) => unit = "";
[@bs.send] external addErrorListener: snackSession => ('a => unit) => unit = "";
[@bs.send] external addPresenceListener: snackSession => ('a => unit) => unit = "";
[@bs.send] external updateFiles: snackSession => files => Js.Promise.t(unit) = "sendCodeAsync";

let files = reasonBundle => { "app.js": {
  "type": "CODE", "contents":appJs},
  "reason.js": {"type": "BUNDLED_CODE",
    "contents": reasonBundle
  } };

let newSession = (bundledJs, deviceId) => {
  let session = snackSession({
    "files": files(bundledJs),
    "sessionId": sessionId,
    "sdkVersion": "27.0.0",
    "deviceId": deviceId,
    "name": "Reason Snack",
  });
  [%bs.raw {|(window.ss = session)|}];
  session
};

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

/* let component = ReasonReact.reducerComponent("Snack"); */

let module IdForm = {
  let component = ReasonReact.reducerComponent("Snack");
  let make = (~onSubmit, _children) => {
    ...component,
    initialState: () => [%bs.raw "window.localStorage.snackDeviceId || ''"],
    reducer: (newState, _) => {
      [%bs.raw "window.localStorage.snackDeviceId = newState"];
      ReasonReact.Update(newState)
    },
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

/* let make = (~bundledJs, _children) => {
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
        ()
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
}; */
