

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

  var search = text => {
    var results = index.search(text, config).slice(0, 30);
    render(document.getElementById('search-results'), div(
      {},
      results.map(({ref, score, doc: {href, title, contents, rendered}}) => div(
        {class: 'result'},
        [
          a({href, class: 'title'}, [title]),
          div({}, [raw(rendered)])
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

