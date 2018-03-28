

/* https://github.com/BuckleScript/bucklescript/blob/ea857727f1d327d69fe9363a4f77f22e3c685d18/jscomp/common/ml_binary.ml */
let read_ast = ic => {
  let magic = Config.ast_impl_magic_number;
  let buffer = really_input_string(ic, String.length(magic));
  assert (buffer == magic); /* already checked by apply_rewriter */
  Location.input_name := input_value(ic);
  input_value(ic);
};


/* https://github.com/BuckleScript/bucklescript/blob/ea857727f1d327d69fe9363a4f77f22e3c685d18/jscomp/depends/binary_ast.ml */
let read_ast = fn => {
  let ic = open_in_bin(fn);
  try {
    let dep_size = input_binary_int(ic);
    seek_in(ic, pos_in(ic) + dep_size);
    let ast = read_ast(ic);
    close_in(ic);
    ast;
  } {
  | exn =>
    close_in(ic);
    raise(exn);
  };
};

