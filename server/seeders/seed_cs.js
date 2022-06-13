const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();

const listCs = ["widia", "ariska"];

const SeedCs = async () => {
  let users = await prisma.users.findMany({
    where: {
      name: {
        in: listCs,
      },
    },
  });

  for (let user of users) {
    await prisma.users.update({
      where: {
        id: user.id,
      },
      data: {
        Role: {
          connect: {
            id: "1",
          },
        },
      },
    });
  }

  console.log("seed cs success");
};

module.exports = { SeedCs };
