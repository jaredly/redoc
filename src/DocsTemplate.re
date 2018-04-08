
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


@media(max-width: 1000px) {
  .block-target-container {
    position: static;
    margin-left: 0;
    margin-top: 8px;
  }
}

|};



let styles = Base.css ++ SyntaxHighlighting.css ++ codeBlocks;

let blockScript = {|
  let loadingPromise = null
  var loadDeps = () => {
    if (loadingPromise) {
      return loadingPromise
    }
    loadingPromise = new Promise((res, rej) => {
      const src = window.relativeToRoot + '/all-deps.js'
      const script = node('script', {src});
      script.onload = () => res();
      script.onerror = e => rej(e);
      document.body.appendChild(script)
    })
    return loadingPromise
  };

  var initBlocks = () => {
    ;[].forEach.call(document.querySelectorAll('div.block-target'), el => {
      const context = el.getAttribute('data-context');
      const id = el.getAttribute('data-block-id');
      const parent = el.parentNode;

      const logs = div({class: 'block-logs'}, []);

      const addLog = (level, items) => {
        var text = ''
        if (items.length === 1 && typeof items[0] === 'string') {
          text = items[0]
        } else {
          text = JSON.stringify(items)
        }
        logs.appendChild(div({class: 'block-log level-' + level}, [text]))
      };

      let ran = false

      window.process = {env: {NODE_ENV: 'production'}}

      const runBlock = (context) => {
        if (ran) {
          return
        }
        ran = true
        loadDeps().then(() => {
          const bundle = document.querySelector('script[type=docre-bundle][data-block-id="' + id + '"]')
          console.log(id)
          if (!bundle) {
            console.error('bundle not found')
            return
          }
          const oldConsole = window.console
          window.console = {
            ...window.console,
            log: (...items) => {oldConsole.log(...items); addLog('log', items)},
            warn: (...items) => {oldConsole.warn(...items); addLog('warn', items)},
            error: (...items) => {oldConsole.error(...items); addLog('error', items)},
          }
          Object.assign(window, context)
          // ok folks we're done
          try {
            // TODO check if it's a promise or something... and maybe wait?
            eval(bundle.textContent);
          } catch (error) {
            oldConsole.error(error)
            addLog('error', [error && error.message])
          }
          window.console = oldConsole
          for (let name in context) {
            window[name] = null
          }
        })
      }

      if (context === 'canvas') {
        const play = div({class: 'block-canvas-play'}, ["▶"])
        const canvas = node('canvas', {id: 'block-canvas-' + id})
        play.onclick = () => {
          console.log('start the music!')
          startBlock.style.display = 'none'
          runBlock({sandboxCanvas: canvas, sandboxCanvasId: canvas.id})
        }
        const canvasBlock = div({class: 'block-canvas-container'}, [
          canvas,
          play
        ]);
        parent.appendChild(canvasBlock)
      } else if (context === 'div') {
        const target = div({id: 'block-target-div-' + id})
        const container = div({class: 'block-target-container'}, [target])
        parent.appendChild(container)
        const startBlock = div({class: 'block-target-right'}, ["▶"])
        startBlock.onclick = () => {
          startBlock.style.display = 'none'
          container.classList.add('active')
          runBlock({sandboxDiv: target, sandboxDivId: target.id})
        }
        parent.appendChild(startBlock)
      } else {
        /*
        const startBlock = div({class: 'block-target-small'}, ["▶"])
        parent.appendChild(startBlock)
        startBlock.onclick = () => {
          startBlock.style.display = 'none'
          runBlock({})
        }
        */
      }

      parent.appendChild(logs)
    })
  }


|};

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

let script = ";(function() {" ++ SearchScript.framework ++ blockScript ++ typeScript ++ {|
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
  initBlocks();
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
