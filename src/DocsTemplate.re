
let searchStyle = {|
#search-input {
  box-sizing: border-box;
  width: 100%;
  padding: 8px 16px;
  font-size: 20px;
}

.result .result-highlighted {
  color: #ff6dff!important;
}

.result {
  padding: 8px;
  border-bottom: 1px solid #eee;
}
|};

let searchScript = {|
(function() {
  var node = (tag, attrs, children) => {
    var node = document.createElement(tag)
    for (var attr in attrs) {
      if (attr === 'style') {
        Object.assign(node.style, attrs[attr])
      } else {
        node.setAttribute(attr, attrs[attr])
      }
    }
    children && children.forEach(child => node.appendChild(typeof child === 'string' ? document.createTextNode(child) : child))
    return node
  }
  var named = tag => (attrs, children) => node(tag, attrs, children)
  var div = named('div')
  var span = named('span')
  var a = named('a')
  var raw = text => {
    var node = document.createElement('div')
    node.innerHTML = text
    return node
  };

  var render = (target, node) => {
    target.innerHTML = ''
    target.appendChild(node)
  }

  var input = document.getElementById('search-input');
  var index = elasticlunr.Index.load(window.searchindex);
  var config = {bool: 'AND', fields: {title: {boost: 2}, contents: {boost: 1}}, expand: true};

  function escapeRegExp(string) {
    return string.replace(/[.*+?^${}()|[\]\\]/g, '\\$&'); // $& means the whole matched string
  }

  var walk = (node, fn) => {
    var nodes = [].slice.call(node.childNodes)
    nodes.forEach(child => {
      if (false === fn(child)) return;
      if (child.parentNode === node) {
        walk(child, fn)
      }
    })
  }

  var highlightNode = (node, token) => {
    walk(node, node => {
      if (node.nodeName === '#text') {
        let at = 0;
        let pieces = [];
        node.textContent.replace(new RegExp(escapeRegExp(token), 'gi'), (matched, pos, full) => {
          pieces.push(document.createTextNode(full.slice(at, pos)))
          pieces.push(span({class: 'result-highlighted'}, [matched]))
          at = pos + matched.length
        })
        if (pieces.length === 0) {
          return
        }
        if (at < node.textContent.length) {
          pieces.push(document.createTextNode(node.textContent.slice(at)))
        }
        node.replaceWith(...pieces)
      }
    })
  }

  var highlightingNode = (text, tokens) => {
    var node = raw(text);
    tokens.forEach(token => highlightNode(node, token))
    return node
  };

  window.highlightNode = highlightNode

  var search = text => {
    var results = index.search(text, config).slice(0, 30);
    render(document.getElementById('search-results'), div(
      {},
      results.map(({ref, score, doc: {href, title, contents, rendered}}) => div(
        {class: 'result'},
        [
          a({href, class: 'title'}, [title]),
          div({}, [
            highlightingNode(rendered, text.split(/\s+/g))
            // raw(text.split(/\s+/g).reduce(
            //   (text, item) => text.replace(new RegExp(escapeRegExp(item), 'ig'), "<span class='result-highlighted'>$&</span>"), rendered
            // ))
          ])
        ]
      ))
    ))
  }

  if (location.search.match(/^\?search=/)) {
    var query = location.search.slice('?search='.length)
    search(query)
    input.value = query
  }

  input.addEventListener('keyup', evt => {
    var text = evt.target.value
    window.history.replaceState({}, '', '?search=' + encodeURIComponent(text))
    search(text)
  })
})();
|};






let syntaxHighlighting = {|
pre.code > code {
  color: #aaa;
}
pre.code {
  border-radius: 3px;
  box-shadow: 0 0.5px 3px #aaa;
  background-color: white;
}
.code .ident, .code .pattern-ident {
    color: #000;
}

.code .module-identifier {
  color: #aa0;
}

.code .constructor,
.code .pattern-constructor {
  color: #0af;
}

.code .type-value-identifier,
.code .type-constructor,
.code .type-module-identifier {
  color: #c100af;
}

.code .type-vbl,
.code .open-module-identifier,
.code .type-module-identifier,
.code .let-module-identifier,
.code .constructor-module-identifier,
.code .switch-module-identifier,
.code .record-module-identifier,
.code .field-module-identifier
{
  color: #a0a;
}

.code .field
{
  color: #0aa;
}

.code .unused-identifier {
  color: #00a;
}

.code .declaration-var {
  color: #a50000;
}

.code .string {
    color: #33a20d;
}

.code .int {
    color: #5656cc;
}

.code .boolean {
    color: #ff8f8f;
}

.code .float {
    color: #d49523;
}

.code .operator {
  color: #9b9bff;
  font-weight: bold;
}

.type-hovered {
  text-decoration: underline;
}

.type-viewer {
  position: absolute;
  display: none;
  background-color: white;
  white-space: pre;
  padding: 8px 16px;
  pointer-events: none;
  margin-top: 10px;
  margin-left: 10px;
  box-shadow: 0 1px 6px #555;
  border-radius: 3px;
}

|};








let styles = {|
body {
  font-family: system-ui;
  font-weight: 200;
  margin: 48px auto;
}

body {
  font-size: 17px;
  line-height: 26px;
  font-weight: 400;
  letter-spacing: -0.021em;
  font-family: "SF Pro Text", "SF Pro Icons", "Helvetica Neue", "Helvetica", "Arial", sans-serif;

  font-weight: 200;
  letter-spacing: 0.04em;
}

h4.item {
  font-family: sf mono, monospace;
  padding-top: 8px;
  border-top: 1px solid #ddd;
  white-space: pre;
  padding-bottom: 16px;
  margin-bottom: 0;
  margin-top: 16px;
  font-weight: 400;

  font-weight: 200;
  letter-spacing: 0.4em;
}

blockquote {
  border-left: 2px solid #006fc9;
  margin-left: 0;
  padding-left: 16px;
}

pre {
  padding: 8px 16px;
  margin: 32px 0;
  background-color: #f1f8ff;
  overflow: auto;
}

div.compile-error {
  padding: 8px 16px;
  background-color: #ffebeb;
  margin-top: -24px;
  margin-bottom: 32px;
  white-space: pre-wrap;
}

pre > code,
h4.item,
.type-viewer,
div.compile-error,
p code {
  font-family: 'SF Mono', Menlo, monospace;
  letter-spacing: 0;
  font-size: 15px;
  line-height: 1.5em;

  font-weight: 200;
  color: #666;
}

.body {
  margin-left: 24px;
  margin-bottom: 48px;
  line-height: 1.5em;
  font-size: 20px;
  letter-spacing: 1px;
}
.body-empty,
.include-body .body {
  margin-bottom: 0;
}

.include-body .item {
  padding: 0;
  border-top: 0;
  margin: 0;
}

.missing {
  font-style: italic;
  font-size: 16px;
  color: #777;
}
h1, h2 {
  margin-top: 24px;
}

h4.module {
  font-size: 110%%;
  font-weight: 600;
}
.module-body {
  border-left: 1px solid #ddd;
  padding-left: 24px;
}

.body > pre:first-child {
  margin-top: 8px;
}
.body > p:first-child {
  margin-top: 0px;
}

.body > pre:last-child,
.body > p:last-child {
  margin-bottom: 8px;
}

p code {
  padding: 1px 4px;
  background: #eee;
  border-radius: 3px;
  font-family: 'sf mono', monospace;
  font-size: 0.9em;
  background: white;
  /* color: #222; */
  box-shadow: 0 0 1px #aaa;
}

a {
  text-decoration: none;
}
a:hover, a:focus {
  text-decoration: underline;
}

.doc-item {
  font-size: 16px;
}



.container {
  display: flex;
  justify-content: center;
  margin: 48px auto;
}

.main {
  width: 600px;
  padding: 0 16px;
  box-sizing: border-box;
  position: relative;
}

.edit-link {
  position: absolute;
  top: 0;
  right: 16px;
  margin: 24px 0;
}

a, a:visited,
.table-of-contents a.module,
.project-listing a,
.main a, .main a:visited {
  color: #0070c9;
}

.right-blank {
  width: 200px;
}

.sidebar {
  width: 200px;
  position: sticky;
  position: -webkit-sticky;
  top: 0;
  overflow: auto;
  max-height: 100vh;
  word-break: break-word;
}

.table-of-contents {
  display: flex;
  flex-direction: column;
  padding: 8px;
}
.project-listing {
  display: flex;
  flex-direction: column;
  padding: 8px;
  font-size: 14px;
  padding-bottom: 32px;
}

.table-of-contents .toc-header,
.project-listing .project-title {
  font-size: 14px;
  font-weight: bold;
  margin: 16px 0 8px;
}

.sidebar-expander {
  display: none;
}

.docs-listing {
  display: flex;
  flex-direction: column;
  padding: 8px;
}

@media(max-width: 1000px) {
  .sidebar {
    position: static;
    width: 600px;
    margin: auto;
    max-height: unset;
    display: none;
  }
  .sidebar-expander {
    text-align: center;
    width: 600px;
    margin: auto;
    display: block;
  }

  .sidebar.expanded {
    display: block;
  }

  .container {
    display: block;
  }

  .right-blank {
    display: none;
  }

  .main {
    margin: auto;
  }
}

@media(max-width: 620px) {
  .sidebar-expander,
  .sidebar {
    width: auto;
    margin: 0;
  }
  .main {
    width: auto;
    padding: 0;
    margin: 0;
  }
  .container {
    padding: 0 20px;
  }
  h4.item {
    font-size: 14px;
    overflow: auto;
    max-width: 100%%;
    padding-right: 16px;
  }
  .body {
    font-size: 17px;
    margin-left: 0;
    margin-bottom: 32px;
  }
}

.table-of-contents a {
  color: unset;
  padding: 2px 0;
}
.table-of-contents a:hover {
  background-color: #fafafa;
}

.table-of-contents a.header {
  font-weight: 400;
}

a.level-1 {
  margin-left: 0px;
}

a.level-2 {
  margin-left: 6px;
}
a.level-3 {
  margin-left: 12px;
}
a.level-4 {
  margin-left: 18px;
}
a.level-5 {
  margin-left: 24px;
}

#error-message {
  display: none;
  background-color: #fde6e6;
  padding: 8px 16px;
  border-radius: 4px;
  box-shadow: 0px 1px 3px #d8a2a2;
  margin-bottom: 32px;
  margin: 0 auto;
  max-width: 600px;
}

.external-link:after {
  /* from font-awesome */
  background: url('data:image/svg+xml;utf8,<svg version="1.1" id="Capa_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="511.626px" height="511.627px" viewBox="0 0 511.626 511.627" style="enable-background:new 0 0 511.626 511.627;" xml:space="preserve"><g><path d="M392.857,292.354h-18.274c-2.669,0-4.859,0.855-6.563,2.573c-1.718,1.708-2.573,3.897-2.573,6.563v91.361 c0,12.563-4.47,23.315-13.415,32.262c-8.945,8.945-19.701,13.414-32.264,13.414H82.224c-12.562,0-23.317-4.469-32.264-13.414 c-8.945-8.946-13.417-19.698-13.417-32.262V155.31c0-12.562,4.471-23.313,13.417-32.259c8.947-8.947,19.702-13.418,32.264-13.418 h200.994c2.669,0,4.859-0.859,6.57-2.57c1.711-1.713,2.566-3.9,2.566-6.567V82.221c0-2.662-0.855-4.853-2.566-6.563 c-1.711-1.713-3.901-2.568-6.57-2.568H82.224c-22.648,0-42.016,8.042-58.102,24.125C8.042,113.297,0,132.665,0,155.313v237.542 c0,22.647,8.042,42.018,24.123,58.095c16.086,16.084,35.454,24.13,58.102,24.13h237.543c22.647,0,42.017-8.046,58.101-24.13 c16.085-16.077,24.127-35.447,24.127-58.095v-91.358c0-2.669-0.856-4.859-2.574-6.57 C397.709,293.209,395.519,292.354,392.857,292.354z"/><path d="M506.199,41.971c-3.617-3.617-7.905-5.424-12.85-5.424H347.171c-4.948,0-9.233,1.807-12.847,5.424 c-3.617,3.615-5.428,7.898-5.428,12.847s1.811,9.233,5.428,12.85l50.247,50.248L198.424,304.067 c-1.906,1.903-2.856,4.093-2.856,6.563c0,2.479,0.953,4.668,2.856,6.571l32.548,32.544c1.903,1.903,4.093,2.852,6.567,2.852 s4.665-0.948,6.567-2.852l186.148-186.148l50.251,50.248c3.614,3.617,7.898,5.426,12.847,5.426s9.233-1.809,12.851-5.426 c3.617-3.616,5.424-7.898,5.424-12.847V54.818C511.626,49.866,509.813,45.586,506.199,41.971z"/></g></svg>');
  margin-left: 4px;
  content: ' ';
  width: 10px;
  height: 10px;
  display: inline-block;
  background-size: contain;
}
|} ++ syntaxHighlighting;

let typeScript = {|
var listenForTypes = () => {
  var typeViewer = document.createElement('div')
  typeViewer.className = 'type-viewer'
  document.body.appendChild(typeViewer)
  ;[].forEach.call(document.querySelectorAll('pre.code'), el => {
    el.addEventListener('mousemove', evt => {
      typeViewer.style.top = evt.pageY + 'px'
      typeViewer.style.left = evt.pageX + 'px'
    });
    el.addEventListener('mouseover', evt => {
      if (evt.target.getAttribute('data-type')) {
        evt.target.classList.add('type-hovered')
        typeViewer.textContent = evt.target.getAttribute('data-type')
        typeViewer.style.display = 'block'
      }
    })
    el.addEventListener('mouseout', evt => {
      if (evt.target.getAttribute('data-type')) {
        evt.target.classList.remove('type-hovered')
        typeViewer.style.display = 'none'
      }
    })
  })
}
|};

let script = typeScript ++ {|
var checkHash = () => {
  if (!window.shouldCheckHashes) {
    return
  }
  var id = window.location.hash.slice(1)
  if (id && !document.getElementById(id)) {
    document.getElementById("error-message").style.display = 'block'
    var parts = id.split('-')
    document.querySelector('#error-message span').textContent = parts[0]
    document.querySelector('#error-message code').textContent = parts[1]
  } else {
    document.getElementById("error-message").style.display = 'none'
  }
}
window.onload = () => {
  checkHash()
  var expander = document.querySelector('.sidebar-expander')
  expander.onclick = () => {
    var sidebar = document.querySelector('.sidebar');
    if (sidebar.classList.contains('expanded')) {
      sidebar.classList.remove('expanded')
      expander.textContent = 'Show navigation'
    } else {
      sidebar.classList.add('expanded')
      expander.textContent = 'Hide navigation'
    }
  }
  listenForTypes();
}
window.onhashchange = checkHash
|};

let head = (~relativeToRoot, ~cssLoc=?, ~jsLoc=?, name) => Printf.sprintf({|
<!doctype html>
<meta charset=utf8>
<meta name="viewport" content="width=device-width, initial-scale=1">
%s
%s
<title>%s</title>
<body>
<script>window.relativeToRoot=%S</script>
<div id='error-message'>
  ⚠️ Oops! This page doesn't appear to define a <span>type</span> called <code>_</code>.
</div>
|}, switch cssLoc {
| None => "<style>" ++ styles ++ "</style>"
| Some(loc) => "<link rel=stylesheet href='" ++ loc ++ "'>"
}, switch jsLoc {
| None => "<script>" ++ script ++ "</script>"
| Some(loc) => "<script defer src='" ++ loc ++ "'></script>"
}, name, relativeToRoot);
