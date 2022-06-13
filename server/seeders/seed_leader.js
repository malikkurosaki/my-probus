const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();

const listLeader = ["ayu", "guntur", "dewi", "ahmad", "adi"];

const SeedLeader = async () => {
  let users = await prisma.users.findMany({
    where: {
      name: {
        in: listLeader,
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
            id: "2",
          },
        },
      },
    });
  }

  console.log("seed leader success");
};

module.exports = { SeedLeader };
