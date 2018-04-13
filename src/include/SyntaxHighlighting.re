
let css = {|
pre.code > code {
  color: #aaa;
}

.code-block > .CodeMirror,
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
  color: #81006f;
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
  color: #808;
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
    color: #30620d;
}

.code .int {
    color: #36369c;
}

.code .boolean {
    color: #a74444;
}

.code .float {
    color: #a06000;
}

.code .operator {
  color: #6060a3;
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
