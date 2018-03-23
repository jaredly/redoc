
let header = {|
<html>
<head>
<title>Reason code</title>
<style>
.identifier {
    color: #000;
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
