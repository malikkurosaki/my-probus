const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();

const listSuperAdmin = ["mukijan"];

const SeedSuperAdmin = async () => {
  let users = await prisma.users.findMany({
    where: {
      name: {
        in: listSuperAdmin,
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
            id: "5",
          },
        },
      },
    });
  }

  console.log("seed super admin success");
};

module.exports = { SeedSuperAdmin };
