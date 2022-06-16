const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();
const fs = require("fs");
const path = require("path");

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
    ModelRole.${role.name.replace(' ', '').toLowerCase()}(){
        id = "${role.id}";
        name = "${role.name.replace(' ', '').toLowerCase()}";
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

module.exports = { ModelStatusGenerate, ModelTypeGenerate, ModelRoleGenerate };
