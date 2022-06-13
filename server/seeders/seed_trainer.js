const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();

const listTrainer = ["bayu", "apit"];

const SeedTrainer = async () => {
  let users = await prisma.users.findMany({
    where: {
      name: {
        in: listTrainer,
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

  console.log("seed trainer success");
};

module.exports = { SeedTrainer };
