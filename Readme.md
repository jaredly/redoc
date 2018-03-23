# Ok folks, what's the plan?

We have raw source code!!!

When there are DocComments...
we want to split them out

When there are Types...
we want to highlight things

What do we want to highlight?
Traditionally, the things highlighted are:
- keywords (let, switch, etc.)
- strings & numbers (I'm down with this)
- Module names
- Constructors
- (possibly namespaced) attribute access
- type identifiers

Things where I want to be able to "hover for type":
- any expression! haha.
- is there anything else?
- that's probably solid for a first pass
- then I want to have module hovering show you the module singature (interactive too! so you can click on a thing & the bubble then shows the source of that thing. I think)
- also stretch goal -- for all identifiers, do resolution. So you can hover a `let` and see usages, and you can hover an identifier, and see the declaration.
- ooooh also "show me usages" pleeease

Ok other documentation things.

I want to be able to reference a thing in a doc comment, and have it resolve.


> cmd+click jumps you to a thing
> click brings up a popover
> maybe alt-click brings a popover of usages? or something.



OOOOk, so v1:
- get position ranges for all the things, highlighting wise
- probably want to consume refmt's internal format? idk.. to get comments
- can start without that though
- get types for all expressions everywhere

Inputs:
- somefile.re somefile.cmt somefile.mlast

Outputs:
- syntax highlighted html, with a script tag containing type annotation data


Looks like `.mlast_simple` is a binary form of the ml ast.
Wonder what the full one is.
But here we are :D

<html>
<div class="root">
  <!-- code here -->
</div>
<script>
window.expressions = [
  {depth: 0, start: 0, end: 10, text: '', type: 'expression'},
]
</script>
<script src="./docre.js"></script>

