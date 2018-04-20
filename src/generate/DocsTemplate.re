
let searchStyle = {|
#search-input {
  box-sizing: border-box;
  width: 100%;
  padding: 8px 16px;
  font-size: 20px;
}

.result .result-highlighted {
  color: #9e009e!important;
  font-weight: 400;
}

.result {
  padding: 8px;
  border-bottom: 1px solid #eee;
}
|};


open Infix;

let head = (~relativeToRoot, name) => Printf.sprintf({|
<!doctype html>
<meta charset=utf8>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel=stylesheet href='%s'>
<script defer src='%s'></script>
<title>%s</title>
<body>
<script>window.relativeToRoot=%S</script>
<script defer src="%s"></script>
<div id='error-message'>
  ⚠️ Oops! This page doesn't appear to define a <span>type</span> called <code>_</code>.
</div>
|},
relativeToRoot /+ "styles.css",
relativeToRoot /+ "script.js",
name, relativeToRoot, relativeToRoot /+ "block-script.js");
