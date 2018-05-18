
# Docre

A clean & easy documentation generator for reason/bucklescript/ocaml.

## How to use:

get the binary (either by [downloading it](https://github.com/jaredly/docre/releases/), or building it yourself).

```txt
# docre - a clean & easy documentation generator

Usage: docre [options]

  --root (default: current directory)
      expected to contain bsconfig.json, and bs-platform in the node_modules
  --target (default: {root}/docs)
      where we should write out the docs
  --name (default: the name of the directory, capitalized)
      what this project is called
  --doctest (default: false)
      execute the documentation snippets to make sure they run w/o erroring
  -h, --help
      print this help
```

## How to build

```bash
npm install
npm start
```

The binary is then in `./lib/bs/native/main.native`.

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

## Example of inline scratchboxes

```
\```reason
print_endline("Hello");
\```
```

When you execute, will trap the console & display below (should also send to real console).
Default is to run in a worker. If you don't want that, you can do

```setup;canvas
Js.log("A shared canvas is created, and maybe floats somewhere? idk");
```


## Related work

http://davidchristiansen.dk/drafts/final-pretty-printer-draft.pdf

ooh check this out
https://github.com/martinklepsch/cljdoc
