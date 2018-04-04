
const elastic = require('./elasticlunr')
console.log(process.argv)
const [_, __, json] = process.argv;
const data = require(json)

const index = new elastic.Index();
index.addField("title");
index.addField("contents");
index.setRef("id");

data.forEach((doc, i) => {
  doc.id = '' + i;
  index.addDoc(doc)
})

const fs = require('fs')
fs.writeFileSync(json + ".index.js", "window.searchindex = " + JSON.stringify(index.toJSON()))