const fs = require("fs");
const path = require("path");
const _ = require("lodash");
const beautify = require("js-beautify");
const colors = require("colors");

function generateApiExtend() {
  let target = fs
    .readFileSync(
      path.join(__dirname, "../../../client/lib/v2/v2_api.dart"),
      "utf8"
    )
    .toString();
  const source = fs
    .readFileSync(path.join(__dirname, "./../../v2_routers.js"), "utf8")
    .toString();

  const matchSource = source
    .match(/\("\/.*",/g)
    .map((item) => item.replace(/\("/g, "").replace(/",/g, ""));

  let a1 = [];
  matchSource.forEach((item) => {
    if (item.includes(":")) {
      item = item.replace(/:.*/g, "");
    }

    if (!target.includes(`${_.camelCase(item)}()`)) {
      a1.push(`V2Api.${_.camelCase(item)}() : path = '${item}';`);
    }
  });

  if (_.isEmpty(a1)) {
    console.log("everithing is up to date".green);
    return;
  }

  let [id1] = target.match(/\/\/.a1.*/g);

  target = target.replace(id1, `${id1}\n${a1.join("\n")}`);

  fs.writeFileSync(
    path.join(__dirname, "../../../client/lib/v2/v2_api.dart"),
    beautify(target, { indent_size: 2 })
  );

  console.log("client/lib/v2/v2_api.dart is updated".yellow);
}

module.exports = generateApiExtend;
