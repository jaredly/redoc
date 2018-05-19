# Writing Documentation

## Top-level module documentation

The first "standalone" comment in a module is treated as the main documentation block for that module. Note the trailing semicolon, and that it starts with exactly two asterisks.

Your top-level documentation should guide the user through the exposed types & values in your module, in order of importance. If the module exports a "main" function, that should be listed at the top, with lesser-used items listed later. It can be helpful to split the documentation into sections via markdown headers, especially if there are many items exported from a module.

> 🙏 Please include at least one example in the top-level documentation of each module. See "Interactive code snippets" for details.

```re;no-run
/**
 * # FlorpBloop
 *
 * This module is for turning florps into bloops.
 *
 * Here's how to use it:
 * \```re
 * open FlorpBloop;
 * let bloop = florpToBloop(Florp.create());
 * let florp = bloopToFlorp(bloop);
 * assert(isValidFlorp(florp));
 * \```
 *
 * ## General data transformation functions
 *
 * @doc florpToBloop, bloopToFlorp, convertManyFlorpsToBloops
 *
 * ## Less-used, but also helpful utilities
 *
 * @doc isValidFlorp, canConvertToBloop
 *
 */;
```

If there's no standalone comment at the top of a module, a "default text" is used, which looks like:

```md
# [name of module]

This module does not have a toplevel documentation block.

@all
```

`@all` is a pragma (see below)

## Per-value documentation

A preceeding doc-comment will be parsed as markdown & rendered.

```re;no-run
/**
 * Note: if the florp is invalid, this will generate a fresh bloop.
 *
 * \```re
 * Js.log(florpToBloop("florp"));
 * \```
 */
let florpToBloop = (florp) => {
  "bloop"
};
```

## Pragmas

Pragmas are valid in the top-level documentation block only, not in per-value doc-comments. They must be on their own line, with a blank line above and below.

### `@doc` followed by a comma-separated list of names

e.g. `@doc someItem, anotherItem`

This lists the provided items in that order, along with their formatted doc comments.

### `@rest`

This lists all of the items that have not yet been listed via `@docs`. If you don't list all of the items exported by a module, `@rest` will be automatically added to the end of your documentation.

*If you don't want something to show up in the documentation, don't expose it to the user in your module.*

### `@all`

This just lists all of the exported items, along with their documentation. It is not recommended for general use, as it doesn't guide the user at all.