# Interactive Code Snippets

If you put this in your doc-comments:

```txt
\```reason
print_endline("Hello");
\```
```

Then you get this, with full type-for-hover, and in-browser running & editing.

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

```txt
\```ml
Js.log "this was written in ocaml";
\```
```

```ml
Js.log "this was written in ocaml";
```

If you're seeing it in `reason`, toggle the syntax switch in the top right.

You can have code blocks default to ocaml syntax by passing the `--ml` flag.

Also, all snippets in ocamldoc comments (in ml files) will be assumed to be ocaml syntax.


