const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();

const listAdmin = ["ahmad"];

const SeedAdmin = async () => {
  let users = await prisma.users.findMany({
    where: {
      name: {
        in: listAdmin,
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
            id: "4",
          },
        },
      },
    });
  }

  console.log("seed admin success");
};

module.exports = { SeedAdmin };
