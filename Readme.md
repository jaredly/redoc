
# Docre

A clean & easy documentation generator for reason/bucklescript/ocaml.

## How to use:

get the binary (either by [downloading it](https://github.com/jaredly/docre/releases/), or building it yourself).

To build:

```bash
npm install
npm start
```

The binary is then in `./lib/bs/native/main.native`. You can run `./docre.sh`, which delegates to that.

### Common options

```txt
  --root (default: current directory)
      expected to contain bsconfig.json, and bs-platform in the node_modules
  --target (default: {root}/docs)
      where we should write out the docs
  --name (default: the name of the directory, capitalized)
      what this project is called
  --ignore-code-errors
      don't print warnings about parse & type errors in code blocks
  --ml
      assume code snippets are in ocaml syntax, not reason
  -h, --help
      print this help
```

### Less used options

```txt
  --project-file (can be used multiple times)
      specified as /abs/path/to/.cmt:rel/path/from/repo/root
  --project-directory (can be used multiple times)
      path/to/cmt/directory:rel/path/from/root
  --dependency-directory (can be used multiple times)
      a directory containing ".cmj" files that should be '-I'd when compiling snippets
  --bs-root (default: root/node_modules/bs-platform)
  --skip-stdlib-completions
      don't include completions for the stdlib in the playground
  --no-bundle
      don't bundle the code examples. This disables editor support
  --just-input
      just parse the options & show the debug output of parsing cli args
  --debug
      output debugging information
```


## Related work

http://davidchristiansen.dk/drafts/final-pretty-printer-draft.pdf

ooh check this out
https://github.com/martinklepsch/cljdoc

