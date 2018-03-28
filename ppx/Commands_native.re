type job = (unit => unit, unit => unit);

/**
 * Get the output of a command, in lines.
 */
let execSync = (~cmd, ~onOut=?, ()) => {
  let chan = Unix.open_process_in(cmd);
  try {
    let rec loop = () =>
      switch (Pervasives.input_line(chan)) {
      | exception End_of_file => []
      | line => {
        switch onOut {
        | None => ()
        | Some(fn) => fn(line)
        };
        [line, ...loop()]
      }
      };
    let lines = loop();
    switch (Unix.close_process_in(chan)) {
    | WEXITED(0) => (lines, true)
    | WEXITED(_)
    | WSIGNALED(_)
    | WSTOPPED(_) => (lines, false)
    }
  } {
  | End_of_file => ([], false)
  }
};

let canRead = (desc) => {
  let (r, w, e) = Unix.select([desc], [], [], 0.01);
  r != []
};

let exec = (~cmd, ~onOut) => {
  let proc = Unix.open_process_in(cmd);
  let desc = Unix.descr_of_in_channel(proc);
  let buffer_size = 8192;
  let buffer = Bytes.create(buffer_size);
  let poll = () =>
    if (canRead(desc)) {
      let read = Unix.read(desc, buffer, 0, buffer_size);
      let got = Bytes.sub_string(buffer, 0, read);
      if (String.length(String.trim(got)) > 0) {
        onOut(got)
      }
    };
  let close = () => Unix.close_process_in(proc) |> ignore;
  (poll, close)
};

let isAlive = (pid) => {
  let (p, status) = Unix.waitpid([Unix.WNOHANG, Unix.WUNTRACED], pid);
  p === 0
};

let keepAlive = (~cmd, ~onOut=line => (), ~onErr=line => (), ~onStart=() => (), ~checkInterval=1., ()) => {
  let buffer_size = 8192;
  let buffer = Bytes.create(buffer_size);
  let start = () => {
    onStart();
    let (r_in, w_in) = Unix.pipe();
    let (r_out, w_out) = Unix.pipe();
    let (r_err, w_err) = Unix.pipe();
    let pid = Unix.create_process("bash", [|"bash", "-c", cmd|], r_in, w_out, w_err);
    (pid, r_out, r_err)
  };
  let process = ref(start());
  let lastCheck = ref(Unix.gettimeofday());
  let poll = () => {
    let (pid, out, err) = process^;
    if (canRead(out)) {
      let read = Unix.read(out, buffer, 0, buffer_size);
      let got = Bytes.sub_string(buffer, 0, read);
      if (String.length(String.trim(got)) > 0) {
        onOut(got)
      }
    };
    if (canRead(err)) {
      let read = Unix.read(err, buffer, 0, buffer_size);
      let got = Bytes.sub_string(buffer, 0, read);
      if (String.length(String.trim(got)) > 0) {
        onErr(got)
      }
    };
    if (Unix.gettimeofday() -. lastCheck^ > checkInterval) {
      lastCheck := Unix.gettimeofday();
      if (! isAlive(pid)) {
        process := start()
      }
    }
  };
  let close = () => {
    let (pid, out, err) = process^;
    Unix.kill(pid, 9)
  };
  (poll, close)
};

let poll = ((poll, close)) => poll();

let run = ((poll, close)) => while (true) poll();

let runAll = jobs => while (true) List.iter(f => (), jobs);

let kill = ((poll, close)) => close();