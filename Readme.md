
# Docre

A clean & easy documentation generator for reason/bucklescript/ocaml.


## Work to do

- [x] A sidebar!
  - [x] a table of contents
  - [ ] listing of other modules in this package
  - [ ] highlight the currently selected thing in the sidebar. scroll-tracking
- [x] make sure mobile looks nice
- [ ] build for a whole project
- [ ] Integrated search! see [this example](https://rustbyexample.com/primitives/tuples.html?search=thin) (powered by [this rust code](https://github.com/rust-lang-nursery/mdBook/blob/5fb36751514a83ce245099df3057efd53b5819df/src/renderer/html_handlebars/search.rs#L19) and [this js code](https://github.com/rust-lang-nursery/mdBook/blob/master/src/theme/searcher/searcher.js))
  - will pre-create an elasticlunr index, and load it up when the user selects the search field
- [ ] inline interactive code samples!
  - make them editable! This may require some gymnastics, but I'm confident pack.re can pull it off.
  - I'll want a way to specify a "wrapper" for the code, e.g. if it's "in a reprocessing draw function"
  - also specify that the code should have a canvas created adjacent to it?
  - the default should probably be "run in a web worker", but you can override to write to a canvas or similar
  - probably want to lazy-load codemirror, the bucklescript compiler, etc. to be easy on the perf.
- [ ] Handle markdown files just fine. Include them in the sidebar, process them in a similar way (including allowing interactive inline code samples!). The only difference is there will be no declared items.
- [ ] have a zero-config "run this @ the project root and do everyting" mode.
  - have a flag for "just me" vs "me & all my dependencies"
  - it's a little funny to generate the docs for all your dependencies, maybe, but also it's probably fine
- [ ] integrate into redex, such that it creates documentation for literally everything.


