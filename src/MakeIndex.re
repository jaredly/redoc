
/**
 * Get the output of a command, in lines.
 */
let execSync = (cmd, input) => {
  let (stdout, stdin) = Unix.open_process(cmd);
  output_string(stdin, input);
  close_out(stdin);
  try {
    let rec loop = () =>
      switch (Pervasives.input_line(stdout)) {
      | exception End_of_file => []
      | line => {
        [line, ...loop()]
      }
      };
    let lines = loop();
    switch (Unix.close_process((stdout, stdin))) {
    | WEXITED(0) => (lines, true)
    | WEXITED(_)
    | WSIGNALED(_)
    | WSTOPPED(_) => (lines, false)
    }
  } {
  | End_of_file => ([], false)
  }
};

let source = {|
console.log(process.argv);
var elasticlunr = process.argv[1];
var json = process.argv[2];
var relative = function (n) { return n[0] == '.' || n[0] == '/' ? n : './' + n; };
var elastic = require(relative(elasticlunr));
var data = require(relative(json));

var index = new elastic.Index();
index.addField("title");
index.addField("contents");
index.setRef("id");

data.forEach(function(doc, i) {
  doc.id = '' + i;
  index.addDoc(doc);
});

var fs = require('fs');
fs.writeFileSync(json + ".index.js", "window.searchindex = " + JSON.stringify(index.toJSON()));
console.log("Finished generating index!");
|} |> Str.global_replace(Str.regexp_string("\n"), "");

let run = (elasticLunrLoc, jsonLoc) => {
  let (output, success) = execSync(Printf.sprintf({|node -e %S -- %S %S|}, source, elasticLunrLoc, jsonLoc), source);
  if (!success) {
    print_endline("ERROR generating search index. Your site will mostly work, but people wont be able to search.");
    print_endline(String.concat("\n", output))
  /* } else { */
    /* print_endline("Good"); */
    /* print_endline(String.concat("\n", output)) */
  };
};

