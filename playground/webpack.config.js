const path = require('path');

module.exports = {
  entry: './lib/js/src/Main.js',
  output: {
    path: path.join(__dirname, "../static"),
    filename: 'playground.js',
  },
};
