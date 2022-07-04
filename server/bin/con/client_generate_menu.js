const fs = require("fs");
const path = require("path");
const target = path.join(__dirname, "../../../client/lib/v2/v2_list_menu.dart");
const source = require("./client_menu.json");
const _ = require("lodash");
const jsBeautify = require("js-beautify");
// a1 do not remove this line

(async () => {
  let tar = fs.readFileSync(target, "utf8").toString();

  let a1 = [];
  let a2 = [];
  source.forEach((item) => {
    if (!tar.includes(`${_.camelCase(item.name)}()`)) {
      a1.push(`V2Menu.${_.camelCase(item.name)}() : key = '${item.name}';`);

      a2.push(`V2Menu.${_.camelCase(item.name)}().menuItem()`);
    }
  });

  let A1 = tar.match(/\/\/.*a1.*/g);
  let A2 = tar.match(/\/\/.a2[\s\S]+.*\[/g);

  tar = tar.replace(A1[0], `${A1}\n${a1.join("\n")}`);
  tar = tar.replace(A2[0], ` ${A2}\n${a2.join(",\n")} \n`);
  if (_.isEmpty(a1)) {
    console.log("everithing is up to date");
    return;
  }

  fs.writeFileSync(target, jsBeautify(tar));
})();
