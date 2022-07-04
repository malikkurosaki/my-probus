const path = require("path");
const fs = require("fs");
const jsBeautify = require("js-beautify");
const PrismaClient = require("@prisma/client").PrismaClient;
const prisma = new PrismaClient();
const _ = require("lodash");

const generateIssueTypeStatusExtend = async () => {
  let targetType = fs
    .readFileSync(
      path.join(__dirname, "./../../../client/lib/v2/v2_issue_type.dart"),
      "utf8"
    )
    .toString();
  let targetStatus = fs
    .readFileSync(
      path.join(__dirname, "./../../../client/lib/v2/v2_issue_status.dart"),
      "utf8"
    )
    .toString();

  const typeNya = await prisma.issueTypes.findMany({
    select: {
      id: true,
      name: true,
    },
  });

  const statusnya = await prisma.issueStatuses.findMany({
    select: {
      id: true,
      name: true,
    },
  });

  let a1 = [];
  typeNya.forEach((item) => {
    if (!targetType.includes(`${_.camelCase(item.name)}()`)) {
      a1.push(
        ` V2IssueType.${_.camelCase(item.name)}() {
            id = '${item.id}';
            name = '${item.name}';
        }`
      );
    }
  });

  let a2 = [];
  statusnya.forEach((item) => {
    if (!targetStatus.includes(`${_.camelCase(item.name)}()`)) {
      a2.push(
        ` V2IssueStatus.${_.camelCase(item.name)}() {
            id = '${item.id}';
            name = '${item.name}';
        }`
      );
    }
  });

  let [A1] = targetType.match(/\/\/.*a1.*/g);
  let [A2] = targetStatus.match(/\/\/.*a1.*/g);

  targetType = targetType.replace(A1, `${A1}\n${a1.join("\n")}`);
  targetStatus = targetStatus.replace(A2, `${A2}\n${a2.join("\n")}`);

  if (_.isEmpty(a1) && _.isEmpty(a2)) {
    console.log("everithing is up to date");
    return;
  }

  fs.writeFileSync(
    path.join(__dirname, "./../../../client/lib/v2/v2_issue_type.dart"),
    jsBeautify(targetType)
  );
  fs.writeFileSync(
    path.join(__dirname, "./../../../client/lib/v2/v2_issue_status.dart"),
    jsBeautify(targetStatus)
  );

  console.log("client/lib/v2/v2_issue_type.dart is updated".yellow);
    console.log("client/lib/v2/v2_issue_status.dart is updated".yellow);
};

module.exports = generateIssueTypeStatusExtend;
