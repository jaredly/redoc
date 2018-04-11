
/* from https://github.com/ocsigen/js_of_ocaml/blob/master/compiler/lib/js_output.ml#L279 */
/* also https://github.com/astrada/reason-react-playground/blob/source/compiler/bin2js.js */
/* also https://github.com/reasonml/reasonml.github.io/commit/74604cfbebf2c11f81f4b23f84bfc89bf8d564de */
/* https://github.com/astrada/reason-react-playground */
let array_str1 = Array.init(256, (i) => String.make(1, Char.chr(i)));

let array_conv = Array.init(16, (i) => String.make(1, "0123456789abcdef".[i]));

module PP = {
  let string = (f, s) => output_string(f, s);
};

let pp_string = (f, ~quote='"', ~utf=false, s) => {
  let quote_s = String.make(1, quote);
  PP.string(f, quote_s);
  let l = String.length(s);
  for (i in 0 to l - 1) {
    let c = s.[i];
    switch c {
    | '\000' when i == l - 1 || s.[i + 1] < '0' || s.[i + 1] > '9' => PP.string(f, "\\0")
    | '\b' => PP.string(f, "\\b")
    | '\t' => PP.string(f, "\\t")
    | '\n' => PP.string(f, "\\n")
    /* This escape sequence is not supported by IE < 9
          | '\011' -> "\\v"
       */
    | '\012' => PP.string(f, "\\f")
    | '\\' when ! utf => PP.string(f, "\\\\")
    | '\r' => PP.string(f, "\\r")
    | '\000'..'\031'
    | '\127' =>
      let c = Char.code(c);
      PP.string(f, "\\x");
      PP.string(f, Array.unsafe_get(array_conv, c lsr 4));
      PP.string(f, Array.unsafe_get(array_conv, c land 15));
    | '\128'..'\255' when ! utf =>
      let c = Char.code(c);
      PP.string(f, "\\x");
      PP.string(f, Array.unsafe_get(array_conv, c lsr 4));
      PP.string(f, Array.unsafe_get(array_conv, c land 15));
    | _ =>
      if (c == quote) {
        PP.string(f, "\\");
        PP.string(f, Array.unsafe_get(array_str1, Char.code(c)));
      } else {
        PP.string(f, Array.unsafe_get(array_str1, Char.code(c)));
      }
    };
  };
  PP.string(f, quote_s);
};

