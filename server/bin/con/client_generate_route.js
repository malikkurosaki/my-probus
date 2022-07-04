const { execSync } = require("child_process");
const fs = require("fs");
const path = require("path");
const client = path.join(__dirname, "./../../../client");
const server = path.join(__dirname, "./../../../server");
const source = require("./client_routes.json");
const _ = require("lodash");
const jsBeautify = require("js-beautify");

async function clientGenerateRouteExtend() {
  let tar = fs
    .readFileSync(
      path.join(__dirname, "./../../../client/lib/v2/v2_routes.dart"),
      "utf8"
    )
    .toString();

  let a1 = [];
  let a2 = [];
  source.forEach((item) => {
    if (!tar.includes(`${_.camelCase(item.name)}()`)) {
      a1.push(
        `V2Routes.${_.camelCase(item.name)}() : key = '/${_.kebabCase(
          item.name
        )}';`
      );

      a2.push(`V2Routes.${_.camelCase(item.name)}().getPage()`);
    }
  });

  let A1 = tar.match(/\/\/.*a1.*/g);
  let A2 = tar.match(/\/\/.a2[\s\S]+.*\[/g);

  tar = tar.replace(A1[0], `${A1}\n${a1.join("\n")}`);
  tar = tar.replace(A2[0], `${A2}\n ${a2.join(",\n")}\n,`);

  if (_.isEmpty(a1)) {
    console.log("everithing is up to date");
    return;
  }

  fs.writeFileSync(
    path.join(__dirname, "./../../../client/lib/v2/v2_routes.dart"),
    jsBeautify(tar)
  );
  console.log("client/lib/v2/v2_routes.dart is updated");
}

module.exports = clientGenerateRouteExtend;
