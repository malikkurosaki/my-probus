const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();

const issueTypes = [
  "bug",
  "feature",
  "improvement",
  "task",
  "request",
  "other",
];
//     {
//         id: "1",
//         name: "request"
//     },
//     {
//         id: "2",
//         name: "bugs"
//     }
// ]

const SeedIssueType = async () => {
  let id = 1;
  for (let issueType of issueTypes) {
    await prisma.issueTypes.upsert({
      where: {
        id: id.toString(),
      },
      update: {
        name: issueType,
      },
      create: {
        id: id.toString(),
        name: issueType,
      },
    });
    id++;
  }

  console.log("seed issue type success");
};

module.exports = { SeedIssueType };
