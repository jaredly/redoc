
let header = {|
<html>
<head>
<title>Reason code</title>
<script>

</script>
<style>
body {
  padding: 30px;
}
.value-identifier {
    color: #000;
}

.module-identifier {
  color: #aa0;
}

.let-module-identifier,
.constructor-module-identifier,
.switch-module-identifier,
.record-module-identifier,
.field-module-identifier {
  color: #a0a;
}

.let-value-identifier,
.switch-value-identifier,
.record-value-identifier,
.field-value-identifier {
  color: #0aa;
}

.unused-identifier {
  color: #00a;
}

.declaration-var {
  color: #a50000;
}

.string {
    color: #33a20d;
}

.int {
    color: blue;
}

.boolean {
    color: red;
}

.float {
    color: orange;
}

.operator {
  color: #9b9bff;
  font-weight: bold;
}

#main {
    color: #aaa;
    white-space: pre;
    font-family: 'sf mono', monospace;
}
.hovered {
  background-color: #d4ffe2;
}
/* span {
  display: inline-block;
  position: relative;
}
.id-badge {
  position: absolute;
  top: 100%;
  left: 0;
} */
[data-global]:not(.operator) {
  font-style: italic;
  /* text-decoration: underline;
  text-decoration-color: rgba(0, 0, 0, 0.5);
  text-decoration-style: dashed; */
}
</style>
|};

let final = {|
<script>

  document.getElementById('main').addEventListener('mouseover', evt => {
    const id = evt.target.getAttribute('data-id')
    if (id) {
      [].map.call(document.querySelectorAll('[data-id="' + id + '"]'), el => {
        el.classList.add('hovered')
      })
    }
  })

  document.getElementById('main').addEventListener('mouseout', evt => {
    const id = evt.target.getAttribute('data-id')
    if (id) {
      [].map.call(document.querySelectorAll('[data-id="' + id + '"]'), el => {
        el.classList.remove('hovered')
      })
    }
  })

</script>
|};

let make = body => {
  header ++ "<pre id=\"main\">" ++ body ++ "</pre>" ++ final
};
