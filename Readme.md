






# Types gameplan

- the typedtree has each identifier uniquified. So you can see all useages of an identifier.
- we can match it up either
  a) aligning the two trees, or
  b) just tracking Locations in a hashmap
- b appeals to be more, because I don't actually know if the trees line up 100%. Maybe they do.
- but b will be easier I think.
- anyway, lets do it so that you can, while going through the ast, say "what's the type that matches this loc", and I'll see how .. umm often if fails?
Also I totally want to take advantage of the resolution we've got.
So mapping those uniqueIds back.
What does that look like?
- maybe, adding that as @attributes to all things?
- that's maybe doable. Could also have a map of (node) to id, type, etc.

Ok, so maybe first pass is:
collect a listing of:
- [((cstart, cend), printtype string)]

Thennn hang on to unique IDs
- [((cstart, cend), id), ...]

Thenn also like paths or stuff? Might have to track each type of thing separately. Can't do homogeneous.








# Initial thoughts
# # Ok folks, what's the plan?

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

