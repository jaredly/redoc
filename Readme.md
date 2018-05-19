
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

## Example of inline scratchboxes

If you put this in your doc-comments:

```txt
\```reason
print_endline("Hello");
\```
```

Then you get this, with full type-for-hover, and in-browser running & editing. (In this example there's not editing, because this app is compiled natively).

```reason
print_endline("Hello");
```

When you execute, will trap the console & display below (should also send to real console).

### Displaying errors

```txt
\```re
This is a syntax error
\```
```

```re;parse-fail
This is a syntax error
```

If you *intend* to have a syntax error, add `parse-fail` to the header, like `re;parse-fail`. Other wise you'll get a big warning when you run docre.

```txt
\```re
3 + "type error"
\```
```

```re;type-fail
3 + "type error"
```

Similarly, if you *intend* to have a type error, add `type-fail` to the header, like `re;type-fail`.

### More fancy output options

#### `#` Hiding prefix & suffix lines

```txt
\```
#let x = "this line will be hidden";
#let y = "this line will also be hidden";
let z = x ++ y; /* wow where did that come from */
# /* also this line will be hidden */
!#Js.log("And this line will be visible, but read-only at the end.");
\```
```

```re
#let x = "this line will be hidden";
#let y = "this line will also be hidden";
let z = x ++ y; /* wow where did that come from */
# /* also this line will be hidden */
!#Js.log("And this line will be visible, but read-only at the end.");
```


#### `canvas` Have a canvas

```txt
\```canvas
Js.log("A shared canvas is created, and floats over to the right. The canvasId is available as 'sandboxId'.");
[@bs.val] external sandboxId: string = "";
\```
```

#### `shared(name)` Share something

```txt
\```shared(awesome)
let something = "A string I want to use later";
\```
```

```shared(awesome)
let something = "A string I want to use later";
```

And then use it later:

```txt
\```use(awesome)
Js.log(something);
\```
```

```use(awesome)
/* Yay now this type checks */
Js.log(something);
```

#### `hide` Hide a code block
Nice if you want a shared block that doesn't make sense on its own:

```txt
\```hide
let x = 10;
\```
```

```hide
let x = 10;
```

#### Write the source in OCaml

This will show up as reason

```txt
\```ml
Js.log "this was written in ocaml";
\```
```

```ml
Js.log "this was written in ocaml";
```



## Related work

http://davidchristiansen.dk/drafts/final-pretty-printer-draft.pdf

ooh check this out
https://github.com/martinklepsch/cljdoc


# Contributing

## Things still to be implemented

- [x] Interactive code samples!
  - [x] First pass - include the compiled javascript for code samples so you can see the result
  - [x] Second pass - make the code samples editable, with an in-page compiler so you can experiment
- [x] Parse the bsconfig.json and package.json of a project
  - [x] to determine the github url
    - [ ] support all types of github specifications https://docs.npmjs.com/files/package.json
  - [x] name, source directories, etc.
- [ ] Handle ocamldoc (see included octavius source) so we can build ocamly projects too
- [ ] Support crowdin translations
- [ ] Support docs versioning -- hang on to older versions & provide links to them
- [ ] Better tokenization, split camel-cased words up to tokenize separately

## itemized work to do

- [x] "edit" on readme doesn't go to the right place (docs/index.md)
- [x] accept cli args
- [x] highlighting in code blocks + hover-for-type
- [ ] argument-level documentation (refmt doesn't parse this properly :/)
- [ ] topologically sort the items in the sidebar - or just allow you to specify order
- [ ] allow embedding of the docs for another module in a markdown page / module docs
- [ ] add cli options for debug, verbose mode, etc.
- [ ] add meta tag cards for social media sharing
- [ ] respect @deprecated (and other things?)
- [x] aliases - only show the last item of a type path (full on hover)
  - if the last item is "t", then also show the parent
- [x] A sidebar!
  - [x] a table of contents
  - [x] listing of other modules in this package
  - [ ] highlight the currently selected thing in the sidebar. scroll-tracking
- [ ] have an "edit this file" link on the page
- [x] make sure mobile looks nice
- [x] make it easy to build for a whole project
- [x] collapse top thing when on mobile
- [x] also process normal markdown files, and add them to the sidebar.
- [x] Integrated search! see [this example](https://rustbyexample.com/primitives/tuples.html?search=thin) (powered by [this rust code](https://github.com/rust-lang-nursery/mdBook/blob/5fb36751514a83ce245099df3057efd53b5819df/src/renderer/html_handlebars/search.rs#L19) and [this js code](https://github.com/rust-lang-nursery/mdBook/blob/master/src/theme/searcher/searcher.js))
  - [x] will pre-create an elasticlunr index, and load it up when the user selects the search field
  - [x] include the markdown files in the index
  - [ ] maybe allow you to indicate that there are other indexes (e.g. for other libraries) that you'd like to load? So reason's docs could load reasonreact for better cross-searching
- [ ] inline interactive code samples!
  - make them editable! This may require some gymnastics, but I'm confident pack.re can pull it off.
  - on mobile, dont have them be editable. Have a run link that will take you to the playground with the code pre-filled.
  - I'll want a way to specify a "wrapper" for the code, e.g. if it's "in a reprocessing draw function"
  - also specify that the code should have a canvas created adjacent to it?
  - the default should probably be "run in a web worker", but you can override to write to a canvas or similar
  - probably want to lazy-load codemirror, the bucklescript compiler, etc. to be easy on the perf.
  - don't auto-eval, probably. When you click on a codeblock, you can click "run", and then run it. At that point, we'll load the bucklescript compiler? Although maybe we'll include a precompiled version of each inline script because why not.
- [x] Handle markdown files just fine. Include them in the sidebar, process them in a similar way (including allowing interactive inline code samples!). The only difference is there will be no declared items.
- [x] have a zero-config "run this @ the project root and do everyting" mode.
- [ ] integrate into redex, such that it creates documentation for literally everything.


## Thoughts on gitbook-like functionality

Crawl `./docs` looking for markdown files. If there's an `index.md`, that's the main page. Otherwise, we use `Readme.md`.
The main file is always listed at the top in directory listings.

For all other files:
- if a file or directory is prefixed with `\d_`, then that number will be its index in the listing
- files also do the `index.md` or `readme.md` thing (maybe readme.md in the folder as well, for better github browsing?)
- code blocks are magic'd to be editable & evaluable
- links to other pages should work, including to api docs things.
  - you can do an absolute link, and it will work out the relative link, so that if the files are hosted not at the root it will be ok
- should the api docs be placed in `./docs/api`? Maybe. Probably.
- maybe allow you to `@doc` include bits of docs from the api? That could be fun.
- probably want to allow "splat"ing in code from different places. Like example code, etc.