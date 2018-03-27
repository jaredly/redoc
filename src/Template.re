
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

.type-value-identifier,
.type-module-identifier {
  color: #1400a5;
}

.open-module-identifier,
.type-module-identifier,
.let-module-identifier,
.constructor-module-identifier,
.switch-module-identifier,
.record-module-identifier,
.field-module-identifier {
  color: #a0a;
}

.open-value-identifier,
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
    color: #5656cc;
}

.boolean {
    color: #ff8f8f;
}

.float {
    color: #d49523;
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

.type-hovered {
  outline: 1px solid #aaa;
}

/* span {
  display: inline-block;
  position: relative;
}
.id-badge {
  position: absolute;
  font-size: 0.5em;
  top: 100%;
  left: 0;
} */

[data-global]:not(.operator) {
  /* font-style: italic; */
  /* background-color: #fff3f2; */
  /* text-decoration: underline;
  text-decoration-color: rgba(0, 0, 0, 0.5);
  text-decoration-style: dashed; */
}

.open-exposing {
  box-shadow: 0 0 2px #d2d2d2;
  border-radius: 3px;
  padding: 0 2px;
}

.open-record,
.open-type {
  color: #1400a5;
}

.open-value {
  color: #000;
}


/* .module-identifier,
.let-module-identifier,
.constructor-module-identifier,
.switch-module-identifier,
.record-module-identifier,
.field-module-identifier,
.let-value-identifier,
.switch-value-identifier,
.record-value-identifier,
.field-value-identifier,
.unused-identifier,
.declaration-var {
  color: #000;
} */

#type_hover {
  position: absolute;
  margin-top: 30px;
  margin-left: 10px;
  padding: 5px 10px;
  box-sizing: border-box;
  font-family: 'sf mono', monospace;
  background-color: white;
  box-shadow: 0 0 2px #aaa;
}

</style>
|};

let final = {|
  <div id="type_hover">Hello</div>
<script>

  const t = document.getElementById('type_hover')
  document.getElementById('main').addEventListener('mousemove', evt => {
    t.style.top = evt.pageY + 'px'
    t.style.left = evt.pageX + 'px'
  });

  document.getElementById('main').addEventListener('mouseover', evt => {
    const id = evt.target.getAttribute('data-id')
    if (id) {
      [].map.call(document.querySelectorAll('[data-id="' + id + '"]'), el => {
        el.classList.add('hovered')
      })
    }
    let el = evt.target
    while (el && el !== document.body) {
      const type = el.getAttribute('data-type')
      if (type) {
        t.innerText = TYPES_LIST[type]
        /* console.log(TYPES_LIST[type]) */
        ;[].map.call(document.querySelectorAll('.type-hovered'), x => x.classList.remove('type-hovered'))
        el.classList.add('type-hovered')
        break
      }
      el = el.parentElement
    }
  })

  document.getElementById('main').addEventListener('mouseout', evt => {
    const id = evt.target.getAttribute('data-id')
      evt.target.classList.remove('type-hovered')
    if (id) {
      [].map.call(document.querySelectorAll('[data-id="' + id + '"]'), el => {
        el.classList.remove('hovered')
      })
    }
  })

</script>
|};

let make = (body, typeText) => {
  header ++ "<pre id=\"main\">" ++ body ++ "</pre><script>" ++ typeText ++ "</script>" ++ final
};
