
[@bs.val] [@bs.scope "ocaml"] external reason_compile : string => 'result = "reason_compile_super_errors";
[@bs.val] [@bs.scope "ocaml"] external ocaml_compile : string => 'result = "compile_super_errors";
[@bs.val] [@bs.scope "Colors"] external parseAnsi : string => {. "spans": array({. "text": string, "css": string})} = "parse";
[@bs.val] external eval: string => 'a = "";

[@bs.val] external bsRequirePaths: Js.Dict.t(string) = "";
[@bs.val] external packRequire: string => 'package = "";

[@bs.set "value"] external setInput: Dom.element => string => unit = "";
[@bs.send] external select: Dom.element => unit = "";
[@bs.scope "document"] [@bs.val] external execCommand: string => unit = "";

[@bs.val] [@bs.scope "location"] external origin: string = "";
[@bs.val] [@bs.scope "location"] external pathname: string = "";
[@bs.val] [@bs.scope "location"] external href: string = "";

[@bs.val] [@bs.module "lz-string"] external compress: string => string = "compressToEncodedURIComponent";
[@bs.val] [@bs.module "lz-string"] external decompress: string => string = "decompressFromEncodedURIComponent";
[@bs.val] [@bs.scope "history"] external replaceState: Js.Dict.t('a) => string => string => unit = "";

let replaceState = url => try (replaceState(Js.Dict.empty(), "", url)) { | _ => () };

let getInputValue = event => ReactDOMRe.domElementToObj(ReactEventRe.Form.target(event))##value;

type ast;
[@bs.val] external parseML: string => ast = "";
[@bs.val] external printML: ast => string = "";
[@bs.val] external parseRE: string => ast = "";
[@bs.val] external printRE: ast => string = "";

type codemirror;
[@bs.send] external setValue: (codemirror, string) => unit = "";
[@bs.send] external getValue: (codemirror) => string = "";
type textarea = Dom.element;

type window;
[@bs.val] external window: window = "";
[@bs.set] external setCm: (window, codemirror) => unit = "cm";

type jspos = {. "line": int, "ch": int};
[@bs.send] external markText: (codemirror, jspos, jspos, {. "className": string}) => unit = "";

type indexData;
type index;
[@bs.val] external indexData: indexData = "searchindex";
[@bs.val] [@bs.scope "elasticlunr.Index"] external load: indexData => index = "";
let index = load(indexData);
let config = {"bool": "AND", "fields": {"title": {"boost": 2}, "contents": {"boost": 1}}, "expand": true};
type searchResult = {.
  "score": float,
  "doc": {.
    "href": string,
    "title": string,
    "contents": string,
    "rendered": string,
    "breadcrumb": string
  }
};
[@bs.send] external searchIndex: (index, string, 'config) => array(searchResult) = "search";
let searchIndex = text => searchIndex(index, text, config);

let clearMarks: codemirror => unit = [%bs.raw {|
  (function(cm) {
    cm.getAllMarks().forEach(mark => {
      cm.removeLineWidget(mark)
    })
  })
|}];

type completionItem = {.
  "docs": Js.nullable(string),
  "kind": string,
  "name": string,
  "path": string,
  "_type": string,
};

let rec findBack = (text, char, i) => {
  if (i < 0) { 0 } else if (text.[i] == char) {
    i - 1
  } else {
    findBack(text, char, i - 1)
  }
};

let rec findOpenComment = (text, i) => {
  if (i < 1) { 0 } else if (text.[i] == '*' && text.[i - 1] == '/') {
    i - 2
  } else {
    findOpenComment(text, i - 1)
  }
};

let rec findBackSkippingCommentsAndStrings = (text, char, pair, i, level) => {
  let loop = findBackSkippingCommentsAndStrings(text, char, pair);
  if (i < 0) { 0 } else if (text.[i] == char) {
    if (level == 0) {
      i - 1
    } else {
      loop(i - 1, level - 1);
    }
  } else if (text.[i] == pair) {
    loop(i - 1, level + 1)
  } else {
    switch (text.[i]) {
    | '"' => loop(findBack(text, '"', i - 1), level)
    | '/' when (i >= 1 && text.[i - 1] == '*') => loop(findOpenComment(text, i - 2), level)
    | _ => loop(i - 1, level)
    }
  }
};

let rec skipWhite = (text, i) => if (i < 0) { 0 } else {
  switch (text.[i]) {
  | ' ' | '\n' | '\t' => skipWhite(text, i - 1)
  | _ => i
  }
};

let rec startOfLident = (text, i) => if (i < 0) { 0 } else {
  switch (text.[i]) {
  | 'a'..'z' | 'A'..'Z' | '.' | '_' | '0'..'9' => startOfLident(text, i - 1)
  | _ => i + 1
  }
};

let rec findArgLabel = (text, i) => if (i < 0) { None } else {
  switch (text.[i]) {
  | 'a'..'z' | 'A'..'Z' | '_' | '0'..'9' => findArgLabel(text, i - 1)
  /* TODO support ?punning and ~punning */
  | '~' => Some(i)
  | _ => None
  }
};

open Infix;

let findFunctionCall = text => {
  let rec loop = (commas, labels, i) => {
    if (i > 0) {
      switch (text.[i]) {
      | '}' => loop(commas, labels, findBackSkippingCommentsAndStrings(text, '{', '}', i - 1, 0))
      | ']' => loop(commas, labels, findBackSkippingCommentsAndStrings(text, '[', ']', i - 1, 0))
      | ')' => loop(commas, labels, findBackSkippingCommentsAndStrings(text, '(', ')', i - 1, 0))
      | '"' => loop(commas, labels, findBack(text, '"', i - 1))
      | '=' => switch (findArgLabel(text, i - 1)) {
        | None => loop(commas, labels, i - 1)
        | Some(i0) => loop(commas, [String.sub(text, i0 + 1, i - i0 - 1), ...labels], i0 - 1)
        }
      /* Not 100% this makes sense, but I think so? */
      | '{' | '[' => None
      | '(' => switch (text.[i - 1]) {
        | 'a'..'z' | 'A'..'Z' | '_' | '0'..'9' => {
          let i0 = startOfLident(text, i - 2);
          Some((commas, labels, String.sub(text, i0, i - i0)))
        }
        | _ => loop(commas, labels, i - 1)
      }
      | ',' => loop(commas + 1, labels, i - 1)
      | _ => if (i >= 1 && text.[i] == '/' && text.[i - 1] == '*') {
          loop(commas, labels, findOpenComment(text, i - 2))
        } else {
          loop(commas, labels, i - 1)
        }
      }
    } else {
      None;
    }
  };
  loop(0, [], String.length(text) - 1) |?>> ((commas, labels, lident)) => (commas, Array.of_list(labels), lident);
};



let findJsxTag = text => {
  let rec loop = (labels, i) => {
    if (i > 0) {
      switch (text.[i]) {
      | '}' => loop(labels, findBackSkippingCommentsAndStrings(text, '{', '}', i - 1, 0))
      | ']' => loop(labels, findBackSkippingCommentsAndStrings(text, '[', ']', i - 1, 0))
      | ')' => loop(labels, findBackSkippingCommentsAndStrings(text, '(', ')', i - 1, 0))
      | '"' => loop(labels, findBack(text, '"', i - 1))
      | '=' => switch (text.[i - 1]) {
        | 'a'..'z' | 'A'..'Z' | '_' => {
          let i0 = startOfLident(text, i - 1);
          /* TODO support punning */
          loop([String.sub(text, i0, i - i0), ...labels], i0 - 1)
        }
        | _ => loop(labels, i - 1)
        }
      | '{' | '[' | '(' | '>' | ';' => None
      | ' ' | '\n' => switch (text.[i - 1]) {
        | 'a'..'z' | 'A'..'Z' | '_' | '0'..'9' => {
          let i0 = startOfLident(text, i - 3);
          if (i0 > 0 && text.[i0 - 1] == '<') {
            Some((labels, String.sub(text, i0, i - i0)))
          } else { loop(labels, i - 1) }
        }
        | _ => loop(labels, i - 1)
      }
      | _ => if (i >= 1 && text.[i] == '/' && text.[i - 1] == '*') {
          loop(labels, findOpenComment(text, i - 2))
        } else {
          loop(labels, i - 1)
        }
      }
    } else {
      None;
    }
  };
  loop([], String.length(text) - 1) |?>> ((labels, lident)) => (Array.of_list(labels), lident);
};




let findOpens = text => {
  let opens = [||];

  let maybeOpen = i0 => {
    let rec loop = i => {
      if (i < 4) {
        0
      } else {
        switch (text.[i]) {
        | 'a'..'z' | 'A'..'Z' | '.' | '_' | '0'..'9' => loop(i - 1)
        | ' ' => {
          let at = skipWhite(text, i - 1);
          if (at >= 3 &&
            text.[at - 3] == 'o' &&
            text.[at - 2] == 'p' &&
            text.[at - 1] == 'e' &&
            text.[at] == 'n'
            ) {
            Js.Array.push(Js.String.slice(~from=i + 1, ~to_=i0 + 1, text), opens) |> ignore;
            at - 4
          } else {
            at
          }
        }
        | _ => i
        }
      }
    };
    loop(i0 - 1)
  };

  let rec loop = i => {
    if (i > 1) {
      switch (text.[i]) {
      | '}' => loop(findBackSkippingCommentsAndStrings(text, '{', '}', i - 1, 0))
      | ']' => loop(findBackSkippingCommentsAndStrings(text, '[', ']', i - 1, 0))
      | ')' => loop(findBackSkippingCommentsAndStrings(text, '(', ')', i - 1, 0))
      | '"' => loop(findBack(text, '"', i - 1))
      | 'a'..'z' | 'A'..'Z' | '_' | '0'..'9' => loop(maybeOpen(i))
      | '(' when text.[i - 1] == '.' => switch (text.[i - 2]) {
        | 'a'..'z' | 'A'..'Z' | '_' | '0'..'9' => {
          let i0 = startOfLident(text, i - 3);
          Js.Array.push(String.sub(text, i0, i - i0 - 1), opens) |> ignore;
        }
        | _ => loop(i - 1)
      }
      | _ => if (i > 1 && text.[i] == '/' && text.[i - 1] == '*') {
          loop(findOpenComment(text, i - 2))
        } else {
          loop(i - 1)
        }
      }
    }
  };
  loop(String.length(text) - 1) |> ignore;
  opens;
};

let autoComplete: (codemirror, completionItem => unit, unit => unit) => bool = [%bs.raw {|
  (function(cm, onSelect, onClose) {
    var cur = cm.getCursor();
    var t = cm.getTokenTypeAt(cur);
    if (t == 'string' || t == 'number' || t == 'comment') {
      return
    }
    var prev = cm.getRange({line:0,ch:0}, cur)

    var match = prev.match(/(^|[^~a-zA-Z0-9\._)\]}"])([a-zA-Z0-9\._]+)$/)

    var results = [];
    var name;

    // labeled arg
    if (!match) {
      match = prev.match(/(^|[^a-zA-Z0-9\._)\]}"])(~[a-zA-Z0-9\._]*)$/)
      if (!match) return
      name = match[2]
      const [[commas, labels, lident]=[]] = findFunctionCall(prev)
      if (!lident) return
      const parts = lident.split('.')
      const last = parts.pop()
      const prefix = parts.join('.')

      const opens  = findOpens(prev).reverse()
      const openPrefixes = {}
      opens.forEach((name, i) => {
        Object.keys(openPrefixes).forEach(k => openPrefixes[k + '.' + name] = true)
        openPrefixes[name] = true
      });
      openPrefixes['Pervasives'] = true

      var matching = window.complationData.filter(item => {
        if (!item.args) return
        // TODO be case agnostic?
        if (item.name !== last) return false
        if (!item.path.endsWith(prefix)) return false
        var left = prefix.length ? item.path.slice(0, -prefix.length) : item.path
        if (left[left.length - 1] == '.') left = left.slice(0, -1)
        if (left && !openPrefixes[left]) return false
        return true
      })
      if (!matching.length) return


      results = matching[0].args.filter(([label, typ]) => label.length && !labels.includes(label) && label.startsWith(name.slice(1))).map(([name, typ]) => ({
        name: '~' + name + '=',
        display: name,
        type: typ,
        kind: 'arg',
      }))

    } else {

      var [[labels, lident]=[]] = findJsxTag(prev) || [];
      if (lident) {
        /* const parts = lident.split('.') */
        const last = 'make'
        const prefix = lident
        name = match[2]
        console.log('JSX', lident, labels, match, name)

        const opens  = findOpens(prev).reverse()
        const openPrefixes = {}
        opens.forEach((name, i) => {
          Object.keys(openPrefixes).forEach(k => openPrefixes[k + '.' + name] = true)
          openPrefixes[name] = true
        });
        openPrefixes['Pervasives'] = true

        var matching = window.complationData.filter(item => {
          if (!item.args) return
          // TODO be case agnostic?
          if (item.name !== last) return false
          if (!item.path.endsWith(prefix)) return false
          var left = prefix.length ? item.path.slice(0, -prefix.length) : item.path
          if (left[left.length - 1] == '.') left = left.slice(0, -1)
          if (left && !openPrefixes[left]) return false
          return true
        })
        if (matching.length) {
          results = matching[0].args.filter(([label, typ]) => label.length && !labels.includes(label) && label.startsWith(name)).map(([name, typ]) => ({
            name: name + '=',
            display: name,
            type: typ,
            kind: 'arg',
          }))
        }

      }
      if (!results.length) {
        var parts = match[2].split('.')
        name = parts.pop()
        var prefix = parts.join('.')

        const opens  = findOpens(prev).reverse()
        const openPrefixes = {}
        opens.forEach((name, i) => {
          Object.keys(openPrefixes).forEach(k => openPrefixes[k + '.' + name] = true)
          openPrefixes[name] = true
        });
        openPrefixes['Pervasives'] = true

        results = window.complationData.filter(item => {
          // TODO be case agnostic?
          if (!item.name.startsWith(name)) return false
          if (!item.path.endsWith(prefix)) return false
          var left = prefix.length ? item.path.slice(0, -prefix.length) : item.path
          if (left[left.length - 1] == '.') left = left.slice(0, -1)
          if (left && !openPrefixes[left]) return false
          return true
        })
        if (!results.length) return
      }
    }

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
    var raw = text => {
      var node = document.createElement('div')
      node.innerHTML = text
      return node
    };

    var colors = {
      'type': '#faa',
      'value': '#afa',
      'module': '#aaf',
    }

    const data = {
      from: {line: cur.line, ch: cur.ch - name.length},
      to: cur,
      list: results.map(item => ({
        text: item.name,
        displayText: item.display || item.name,
        item,
        render: (elem, _, __) => {
          var container = node('span', {}, [
            node('span', {style: {
              backgroundColor: colors[item.kind] || '#eee',
              borderRadius: '50%',
              marginRight: '4px',
              padding: '0 2px',
              color: 'black',
            }}, [item.kind[0] || '']),
            item.display || item.name
          ])
          container.style.lineHeight = 1;
          elem.appendChild(container)
        }
      })).sort((a, b) => a.text.length - b.text.length)
    }

    var contents = raw('')
    var helper = node('div', {
      style: {
        position: 'absolute',
        left: '100%',
        top: 0,
        marginLeft: 4,
        fontFamily: 'iosevka, "sf pro mono", monospace',
        whiteSpace: 'pre-wrap',
        fontSize: '12px',
        lineHeight: 1.2,
        padding: '4px 8px',
        zIndex: 1000,
        backgroundColor: 'white',
        boxShadow: '0 0 2px #aaa',
      }
    }, [contents])

    CodeMirror.on(data, 'select', function(completion, element) {
      onSelect(completion.item)
      contents.innerHTML = completion.item.type
      var list = element.parentNode;
      var box = list.getBoundingClientRect()
      helper.style.left = list.style.left
      helper.style.top = list.style.top
      helper.style.marginLeft = box.width + 'px'
      element.parentNode.parentNode.appendChild(helper)
    })
    cm.showHint({
      completeSingle: false,
      hint: () => (data)
    });
    CodeMirror.on(data, 'close', () => {
      helper.parentNode && helper.parentNode.removeChild(helper)
      onClose()
    })
    return true
  })
|}];

let registerComplete: (codemirror, codemirror => bool) => unit = [%bs.raw{|
  (function(cm, onHint) {
    var ExcludedIntelliSenseTriggerKeys = {
      "8": "backspace",
      "9": "tab",
      "13": "enter",
      "16": "shift",
      "17": "ctrl",
      "18": "alt",
      "19": "pause",
      "20": "capslock",
      "27": "escape",
      "33": "pageup",
      "34": "pagedown",
      "35": "end",
      "36": "home",
      "37": "left",
      "38": "up",
      "39": "right",
      "40": "down",
      "45": "insert",
      "46": "delete",
      "91": "left window key",
      "92": "right window key",
      "93": "select",
      "107": "add",
      "109": "subtract",
      "110": "decimal point",
      "111": "divide",
      "112": "f1",
      "113": "f2",
      "114": "f3",
      "115": "f4",
      "116": "f5",
      "117": "f6",
      "118": "f7",
      "119": "f8",
      "120": "f9",
      "121": "f10",
      "122": "f11",
      "123": "f12",
      "144": "numlock",
      "145": "scrolllock",
      "186": "semicolon",
      "187": "equalsign",
      "188": "comma",
      "189": "dash",
      "191": "slash",
      "220": "backslash",
      "222": "quote"
    }

    var functionHelper = document.createElement('div')
    Object.assign(functionHelper.style, {
      position: 'absolute',
      display: 'none',
      left: 0,
      top: 0,
      marginLeft: 4,
      fontFamily: 'iosevka, "sf pro mono", monospace',
      whiteSpace: 'pre-wrap',
      fontSize: '12px',
      lineHeight: 1.2,
      padding: '4px 8px',
      zIndex: 1000,
      backgroundColor: 'white',
      boxShadow: '0 0 2px #aaa',
    })
    document.body.appendChild(functionHelper)

    var showFunctionHint = () => {
      var cur = cm.getCursor();
      var prev = cm.getRange({line:0,ch:0}, cur)

      const [[commas, labels, lident]=[]] = findFunctionCall(prev) || []
      if (!lident) return
      const parts = lident.split('.')
      const last = parts.pop()
      const prefix = parts.join('.')

      const opens  = findOpens(prev).reverse()
      const openPrefixes = {}
      opens.forEach((name, i) => {
        Object.keys(openPrefixes).forEach(k => openPrefixes[k + '.' + name] = true)
        openPrefixes[name] = true
      });

      var matching = window.complationData.filter(item => {
        if (!item.args) return
        // TODO be case agnostic?
        if (item.name !== last) return false
        if (!item.path.endsWith(prefix)) return false
        var left = prefix.length ? item.path.slice(0, -prefix.length) : item.path
        if (left[left.length - 1] == '.') left = left.slice(0, -1)
        if (left && !openPrefixes[left]) return false
        return true
      })
      if (!matching.length) return

      var text = matching[0].type
      var {top, left, bottom} = cm.cursorCoords(true, 'window')

      functionHelper.style.top = bottom + 'px';
      functionHelper.style.left = left + 'px';
      functionHelper.style.display = 'block'
      functionHelper.innerHTML = text

      return true
    }

    cm.on("keyup", function(editor, event) {
      if (!ExcludedIntelliSenseTriggerKeys[(event.keyCode || event.which).toString()]) {
        if (!onHint(cm) && cm.state.completionActive) {
          cm.state.completionActive.close()
        } else if (cm.state.completionActive) {
          functionHelper.style.display = 'none'
        }
      }
    });

    cm.on('cursorActivity', () => {
      if (!cm.state.completionActive) {
        // check for function call hover
        if (!showFunctionHint()) {
          functionHelper.style.display = 'none'
        }
      }
    })
  })
|}];

let highlightNode: (. Dom.element, string) => unit = [%bs.raw {|
  (function(node, token) {
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

    walk(node, node => {
      if (node.nodeName === '#text') {
        let at = 0;
        let pieces = [];
        node.textContent.replace(new RegExp(escapeRegExp(token), 'gi'), (matched, pos, full) => {
          pieces.push(document.createTextNode(full.slice(at, pos)))
          var span = document.createElement('span')
          span.textContent = matched
          span.className='result-highlighted'
          pieces.push(span)
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

  })
|}];

let fromTextArea: (. textarea, string => unit) => codemirror = [%bs.raw {|
  function(textarea, onRun) {
    var betterShiftTab = /*onInfo => */cm => {
      var cursor = cm.getCursor()
        , line = cm.getLine(cursor.line)
        , pos = {line: cursor.line, ch: cursor.ch}
      cm.execCommand('indentLess')
    }

    var betterTab = /*onComplete => */cm => {
      if (cm.somethingSelected()) {
        return cm.indentSelection("add");
      }
      const cursor = cm.getCursor()
      const line = cm.getLine(cursor.line)
      const pos = {line: cursor.line, ch: cursor.ch}
      cm.replaceSelection(Array(cm.getOption("indentUnit") + 1).join(" "), "end", "+input");
    }

    var run = function(cm) {
      onRun(cm.getValue())
    }

    var toggleComment = cm => {
      var options = {indent: true}
      var minLine = Infinity, ranges = cm.listSelections(), mode = null;
      for (var i = ranges.length - 1; i >= 0; i--) {
        var from = ranges[i].from(), to = ranges[i].to();
        if (from.line >= minLine) continue;
        if (to.line >= minLine) to = Pos(minLine, 0);
        minLine = from.line;
        if (mode == null) {
          if (cm.uncomment(from, to, options)) mode = "un";
          else { cm.blockComment(from, to, options); mode = "line"; }
        } else if (mode == "un") {
          cm.uncomment(from, to, options);
        } else {
          cm.blockComment(from, to, options);
        }
      }
    };

    var cm = CodeMirror.fromTextArea(textarea, {
      lineNumbers: true,
      lineWrapping: true,
      viewportMargin: Infinity,
      autoCloseBrackets: true,
      matchBrackets: true,
      extraKeys: {
        /* extraKeys: {"Ctrl-Space": "autocomplete"}, */
        'Cmd-Enter': (cm) => onRun(cm.getValue()),
        'Ctrl-Enter': (cm) => onRun(cm.getValue()),
        "Cmd-/": toggleComment,
        Tab: betterTab,
        'Shift-Tab': betterShiftTab,
      },
      mode: 'rust',
    })
    return cm
  }
|}];


let htmlEscape = text => text
|> Js.String.replace("&", "&amp;")
|> Js.String.replace("<", "&lt;")
|> Js.String.replace(">", "&gt;")
;

let fixEscapes = message => message
|> Js.String.replaceByRe(Js.Re.fromStringWithFlags({js|\u001b\\[1;|js}, ~flags="g"), {js|\u001b[|js})
|> Js.String.replaceByRe(Js.Re.fromStringWithFlags({js|\u001b\\[0m|js}, ~flags="g"), {js|\u001b[39m|js})
|> parseAnsi
|> result => result##spans
|> Array.map(span => {
  let css = span##css;
  let text = htmlEscape(span##text);
  Js.log2("span", span);
  {j|<span style="$css">$text</span>|j}
}) |> Js.Array.joinWith("");

type pos = {
  row: int,
  column: int
};
let jsPos = ({row, column}) => {"line": row, "ch": column};


type result('a, 'b) =
  | Ok('a)
  | Error('b);

let reasonCompile = code => {
  let result = reason_compile(code);
  switch (Js.Nullable.toOption(result##js_code)) {
  | Some(js) => Ok(js)
  | None =>
    Error((
      result##js_error_msg,
      {row: result##row, column: result##column},
      {row: result##endRow, column: result##endColumn}
    ))
  };
};

let ocamlCompile = code => {
  let result = ocaml_compile(code);
  switch (Js.Nullable.toOption(result##js_code)) {
  | Some(js) => Ok(js)
  | None =>
    Error((
      result##js_error_msg,
      {row: result##row, column: result##column},
      {row: result##endRow, column: result##endColumn}
    ))
  };
};