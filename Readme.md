
# Docre

A clean & easy documentation generator for reason/bucklescript/ocaml.


## Work to do

- [x] aliases - only show the last item of a type path (full on hover)
  - if the last item is "t", then also show the parent
- [x] A sidebar!
  - [x] a table of contents
  - [x] listing of other modules in this package
  - [ ] highlight the currently selected thing in the sidebar. scroll-tracking
- [x] make sure mobile looks nice
- [ ] make it easy to build for a whole project
- [x] collapse top thing when on mobile
- [ ] Integrated search! see [this example](https://rustbyexample.com/primitives/tuples.html?search=thin) (powered by [this rust code](https://github.com/rust-lang-nursery/mdBook/blob/5fb36751514a83ce245099df3057efd53b5819df/src/renderer/html_handlebars/search.rs#L19) and [this js code](https://github.com/rust-lang-nursery/mdBook/blob/master/src/theme/searcher/searcher.js))
  - will pre-create an elasticlunr index, and load it up when the user selects the search field
  - maybe allow you to indicate that there are other indexes (e.g. for other libraries) that you'd like to load? So reason's docs could load reasonreact for better cross-searching
- [ ] inline interactive code samples!
  - make them editable! This may require some gymnastics, but I'm confident pack.re can pull it off.
  - on mobile, dont have them be editable. Have a run link that will take you to the playground with the code pre-filled.
  - I'll want a way to specify a "wrapper" for the code, e.g. if it's "in a reprocessing draw function"
  - also specify that the code should have a canvas created adjacent to it?
  - the default should probably be "run in a web worker", but you can override to write to a canvas or similar
  - probably want to lazy-load codemirror, the bucklescript compiler, etc. to be easy on the perf.
  - don't auto-eval, probably. When you click on a codeblock, you can click "run", and then run it. At that point, we'll load the bucklescript compiler? Although maybe we'll include a precompiled version of each inline script because why not.
- [ ] Handle markdown files just fine. Include them in the sidebar, process them in a similar way (including allowing interactive inline code samples!). The only difference is there will be no declared items.
- [ ] have a zero-config "run this @ the project root and do everyting" mode.
  - have a flag for "just me" vs "me & all my dependencies"
  - it's a little funny to generate the docs for all your dependencies, maybe, but also it's probably fine
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
