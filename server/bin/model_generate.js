const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();
const fs = require("fs");
const path = require("path");
const _ = require("lodash");
const execSync = require("child_process").execSync;


// detect type of data
function typeNya(data) {
  if (typeof data === "string") {
    return "String";
  } else if (typeof data === "number") {
    return "int";
  } else if (typeof data === "boolean") {
    return "bool";
  } else if (Array.isArray(data)) {
    return "List";
  } else if (data instanceof Object) {
    return "Map";
  } else {
    return "var";
  }
}

const ModelStatusGenerate = async () => {
  const file = path.join(
    __dirname,
    "../../client/lib/models/model_status.dart"
  );

  const issueStatus = await prisma.issueStatuses.findMany({
    select: {
      id: true,
      name: true,
    },
  });

  let data = "";
  for (let status of issueStatus) {
    data += `
    ModelStatus.${status.name}(){
        id = "${status.id}";
        name = "${status.name}";
    }`;
  }

  let isi = `
        class ModelStatus {
            late String id;
            late String name;
            
            ${data}
            
        }
    `;

  fs.writeFileSync(file, isi.trim(), { encoding: "utf-8" });
  console.log("generate model status success");
};

const ModelTypeGenerate = async () => {
  const file = path.join(__dirname, "../../client/lib/models/model_type.dart");

  const issueTypes = await prisma.issueTypes.findMany({
    select: {
      id: true,
      name: true,
    },
  });

  let data = "";
  for (let type of issueTypes) {
    data += `
    ModelType.${type.name}(){
        id = "${type.id}";
        name = "${type.name}";
    }`;
  }

  let isi = `
        class ModelType {
            late String id;
            late String name;

            ${data}

        }
    `;

  fs.writeFileSync(file, isi.trim(), { encoding: "utf-8" });

  console.log("generate model type success");
};

const ModelRoleGenerate = async () => {
  const file = path.join(__dirname, "../../client/lib/models/model_role.dart");

  const roles = await prisma.roles.findMany({
    select: {
      id: true,
      name: true,
    },
  });

  let data = "";
  for (let role of roles) {
    data += `
    ModelRole.${role.name.replace(" ", "").toLowerCase()}(){
        id = "${role.id}";
        name = "${role.name.replace(" ", "").toLowerCase()}";
    }`;
  }

  let isi = `
        class ModelRole {
            late String id;
            late String name;

            ${data}

        }
    `;

  fs.writeFileSync(file, isi.trim(), { encoding: "utf-8" });
  console.log("generate model role success");
};

const GenerateBodyStatus = async () => {
  let tables = Object.keys(prisma).filter((x) => !x.includes("_"));

  for (let table of tables) {
    const file = path.join(
      __dirname,
      `../../client/lib/models/model_${_.snakeCase(table)}.dart`
    );

    const issueStatus = await prisma[table].findFirst();

    if (issueStatus) {
      let defines = "";
      let construct = "";
      let fromJsonItem = "";
      let toJsonItem = "";
      for (let status of Object.keys(issueStatus)) {
        defines += `
        ${typeNya(status)}? ${status};`;

        construct += `
        this.${status},`;

        fromJsonItem += `
        ${status} = json['${status}'];`;

        toJsonItem += `
        data['${status}'] = ${status};`;
      }

      let isi = `
        class ModelBody${_.upperFirst(_.camelCase(table))} {
            ${defines}
            
            ModelBody${_.upperFirst(_.camelCase(table))}({
                ${construct}
            });

            ModelBody${_.upperFirst(
              _.camelCase(table)
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

      fs.writeFileSync(file, isi.trim(), { encoding: "utf-8" });
      console.log(`generate model body ${table} success`);
    }
  }

  // dart format
  execSync(`dart format ${path.join(__dirname, '../../client/lib/models')}`, { stdio: 'inherit' });
};

module.exports = {
  ModelStatusGenerate,
  ModelTypeGenerate,
  ModelRoleGenerate,
  GenerateBodyStatus,
};
