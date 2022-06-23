const fs = require("fs");
const path = require("path");
const _ = require("lodash");
const execSync = require("child_process").execSync;
const config = require(path.join(__dirname, "./../build.json"));

function generateBuildDebug() {
  const listKey = Object.keys(config);

  let item = "";
  for (let lk of listKey) {
    item += `static const String ${_.camelCase(lk)} = "${lk}";\n`;
  }

  const template = `
    class StringBuildDebug {
        ${item}
    }
    `;
  fs.writeFileSync(
    path.join(__dirname, "./../../client/lib/strings/string_build_debug.dart"),
    template,
    { encoding: "utf-8" }
  );

  execSync(
    `dart format ${path.join(
      __dirname,
      "./../../client/lib/strings/string_build_debug.dart"
    )}`
  );
}

function typeNya(data) {
  if (_.isString(data)) return "String";
  else if (_.isNumber(data)) return "int";
  else if (_.isBoolean(data)) return "bool";
  else if (_.isArray(data)) return "List<dynamic>";
  else if (_.isObject(data)) return "Map<String, dynamic>";
  else return "String";
}

function Generate(data, name) {
  try {
    let defines = "";
    let construct = "";
    let fromJsonItem = "";
    let toJsonItem = "";
    let val = Object.values(data);
    let idx = 0;

    for (let itm of Object.keys(data)) {
      defines += `
        ${typeNya(val[idx])}? ${_.camelCase(itm)};`;

      construct += `
        this.${_.camelCase(itm)},`;

      fromJsonItem += `
        ${_.camelCase(itm)} = json['${itm}'];`;

      toJsonItem += `
        data['${itm}'] = ${_.camelCase(itm)};`;

      idx++;
    }

    let template = `
        class ModelBody${_.upperFirst(_.camelCase(name))} {
            ${defines}
            
            ModelBody${_.upperFirst(_.camelCase(name))}({
                ${construct}
            });

            ModelBody${_.upperFirst(
              _.camelCase(name)
            )}.fromJson(Map<String, dynamic> json) {
                ${fromJsonItem}
            }

            Map<String, dynamic> toJson() {
            final Map<String, dynamic> data = <String, dynamic>{};
                ${toJsonItem}
            return data;
          }
        }
    `;

    fs.writeFileSync(
      path.join(__dirname, `./../../client/lib/models/${name}.dart`),
      template.trim(),
      { encoding: "utf-8" }
    );
    console.log(`generate model body ${name} success`);

    // dart format
    execSync(`dart format ${path.join(__dirname, "../../client/lib/models")}`, {
      stdio: "inherit",
    });
  } catch (error) {
    console.log(error);
  }
}

function CliGenerate() {
  generateBuildDebug();
  Generate(config, "model_builder_debug");
  console.log("berasil generate model_builder_debug");
}

module.exports = { CliGenerate };
