const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();

const listModerator = ["ayu"];

const SeedModerator = async () => {
  let user = await prisma.users.findMany({
    where: {
      name: {
        in: listModerator,
      },
    },
  });

  for (let moderator of user) {
    await prisma.users.update({
      where: {
        id: moderator.id,
      },
      data: {
        Role: {
          connect: {
            id: "3",
          },
        },
      },
    });
  }
  console.log("Seed Moderator Success");
};

module.exports = { SeedModerator };
