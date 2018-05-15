
const fs = require('fs')
const path = require('path')

const packagedModules = {};
const flatModules = {};

const walk = (base, fn) => fs.readdirSync(base).forEach(name => {
  const full = path.join(base, name)
  const stat = fs.statSync(full)
  if (stat.isFile()) {
    fn(full)
  } else if (stat.isDirectory()) {
    walk(full, fn)
  }
});

const packageFlat = (directory) => {
  walk(directory, full => {
    if (full.endsWith('.js')) {
      const name = full.split('/').slice(-1)[0].split('.')[0];
      const cap = name[0].toUpperCase() + name.slice(1)
      flatModules[cap] = fs.readFileSync(full).toString('utf8')
    }
  })
};

const packageNamespaced = (package, directory) => {
  walk(directory, full => {
    if (full.endsWith('.js')) {
      const name = full.split('/').slice(-1)[0].split('.')[0];
      if (full == path.join(directory, 'index.js')) {
        flatModules[package] = ''
        return
      }
      const cap = name[0].toUpperCase() + name.slice(1)
      if (!packagedModules[package]) {
        packagedModules[package] = {}
      }
      packagedModules[package][cap] = fs.readFileSync(full).toString('utf8')
    }
  })
}

packageFlat('../node_modules/bs-platform/lib/js')
packageNamespaced('BsReactNative', '../lib/js')
packageFlat('../node_modules/reason-react/lib/js')

fs.writeFileSync('./all-source-files.js', `
window.packagedModules = ${JSON.stringify(packagedModules)}
window.flatModules = ${JSON.stringify(flatModules)}
`)
