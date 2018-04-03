
let head = name => Printf.sprintf({|
<!doctype html>
<meta charset=utf8>
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
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

h4.item,
p code {
  font-family: 'SF Mono', Menlo, monospace;
  letter-spacing: 0;
  font-size: 17px;
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

.body > p:first-child {
  margin-top: 0px;
}

.body > p:last-child {
  margin-bottom: 8px;
}

p code {
  padding: 1px 4px;
  background: #eee;
  border-radius: 3px;
  font-family: 'sf mono', monospace;
  font-size: 0.9em;
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
}

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

.project-listing .project-title {
  font-weight: bold;
  margin: 16px 0 8px;
}

.project-listing a:visited {
  color: unset;
}

.sidebar-expander {
  display: none;
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

.table-of-contents a:visited {
  color: unset;
}

.table-of-contents a {
  color: unset;
  padding: 2px 4px
}
.table-of-contents a:hover {
  background-color: #fafafa;
}

.table-of-contents a.header {
  font-weight: bold;
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
}

</style>
<script>
var checkHash = () => {
  var id = window.location.hash.slice(1)
  if (id && !document.getElementById(id)) {
    document.getElementById("error-message").style.display = 'block'
    var parts = id.split('-')
    document.querySelector('#error-message span').textContent = parts[0]
    document.querySelector('#error-message code').textContent = parts[1]
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
}
window.onhashchange = checkHash
</script>
<title>%s</title>
<body>
<div id='error-message'>
  ⚠️ Oops! This page doesn't appear to define a <span>type</span> called <code>_</code>.
</div>
|}, name);
