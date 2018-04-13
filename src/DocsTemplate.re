
let searchStyle = {|
#search-input {
  box-sizing: border-box;
  width: 100%;
  padding: 8px 16px;
  font-size: 20px;
}

.result .result-highlighted {
  color: #a33fa3!important;
}

.result {
  padding: 8px;
  border-bottom: 1px solid #eee;
}
|};











let codeBlocks = {|
.code-block {
  position: relative;
}

.block-target-large {
  height: 24px;
  background-color: #afa;
  cursor: pointer;
  text-align: center;
}

.block-target-right {
  background-color: #afa;
  cursor: pointer;
  height: 24px;
  background-color: #afa;
  border-radius: 3px;
  position: absolute;
  top: 0;
  left: 100%;
  margin-left: 16px;
  width: 32px;
  opacity: 1;
  display: flex;
  align-items: center;
  justify-content: center;
}

.block-target-small {
  cursor: pointer;
  height: 24px;
  background-color: #afa;
  border-radius: 3px;
  position: absolute;
  top: 0;
  right: 0;
  width: 32px;
  height: 2.5em;
  opacity: 0.1;
  transition: opacity 0.1s ease;
  display: flex;
  align-items: center;
  justify-content: center;
}

.code-block:hover .block-target-small {
  opacity: 1;
}

.block-target-container {
  position: absolute;
  left: 100%;
  top: 0;
  min-height: 42px;
  margin-left: 16px;
  padding: 8px 16px;
  border-radius: 3px;
  box-sizing: border-box;
  width: 200px;
}
.block-target-container.active {
  box-shadow: 0 0 1px #aaa inset;
}


.block-canvas-container {
  position: absolute;
  top: 0;
  left: 100%;
  box-shadow: 0 0 1px #aaa;
  border-radius: 3px;
  margin-left: 16px;
}

.block-canvas-play {
  position: absolute;
  top: 50%;
  left: 50%;
  font-size: 64px;
  /* margin-left: -26px; */
  color: rgba(0, 0, 0, 0.2);
  /* margin-top: -17px; */
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  display: flex;
  justify-content: center;
  align-items: center;
  cursor: pointer;
}

@media(max-width: 1000px) {
  .block-target-container {
    position: static;
    margin-left: 0;
    margin-top: 8px;
  }
  .block-canvas-container {
    top: 0;
    left: 0;
    position: relative;
    margin-left: 0;
    margin-top: 8px;
    display: flex;
    justify-content: center;
  }
}

|};



let styles = Base.css ++ SyntaxHighlighting.css ++ codeBlocks;

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

let script = ";(function() {" ++ SearchScript.framework ++ typeScript ++ {|
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
|} ++ "})();";

let head = (~relativeToRoot, ~cssLoc=?, ~jsLoc=?, name) => Printf.sprintf({|
<!doctype html>
<meta charset=utf8>
<meta name="viewport" content="width=device-width, initial-scale=1">
%s
%s
<title>%s</title>
<body>
<script>window.relativeToRoot=%S</script>
<script defer src="%s/block-script.js"></script>
<div id='error-message'>
  ⚠️ Oops! This page doesn't appear to define a <span>type</span> called <code>_</code>.
</div>
|}, switch cssLoc {
| None => "<style>" ++ styles ++ "</style>"
| Some(loc) => "<link rel=stylesheet href='" ++ loc ++ "'>"
}, switch jsLoc {
| None => "<script>" ++ script ++ "</script>"
| Some(loc) => "<script defer src='" ++ loc ++ "'></script>"
}, name, relativeToRoot, relativeToRoot);
