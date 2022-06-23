const path = require("path");
const config = require(path.join(__dirname, "./../build.json"));
const fs = require("fs");

//  "build_version": "1.0.0",
//     "debug_web": "1.0.0",
//     "debug_apk": "1.0.0",
//     "build_production": "1.0.5"

/** @param {("debug_apk" | "debug_web" | "build_version" | "build_production")} param */
function CliBuildDebug(param) {
  var str = config[param];
  var count = str.match(/\d*$/);
  config[param] = str.substr(0, count.index) + ++count[0];

  fs.writeFileSync(
    path.join(__dirname, "./../build.json"),
    JSON.stringify(config, null, 2),
    {
      encoding: "utf-8",
    }
  );

  console.log(param + " set to " + config[param]);
}

module.exports = { CliBuildDebug };
