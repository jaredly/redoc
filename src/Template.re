
let header = {|
<html>
<head>
<title>Reason code</title>
<style>
.value-identifier {
    color: #000;
}

.module-identifier {
  color: #aa0;
}

.record-module-identifier,
.field-module-identifier {
  color: #a0a;
}

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
</style>
|};

let make = body => {
  header ++ "<pre id=\"main\">" ++ body ++ "</pre>"
};
