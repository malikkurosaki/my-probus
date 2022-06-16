const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();

const roles = ["User", "Leader", "Moderator", "Admin", "Super Admin"];

const SeedRole = async () => {
  let id = 1;
  for (let rol of roles) {
    await prisma.roles.upsert({
      where: {
        id: id.toString(),
      },
      update: {
        name: rol,
        description: rol,
      },
      create: {
        id: id.toString(),
        name: rol,
        description: rol,
      },
    });
    id++;
  }

  console.log("Seed Role Success");
};

module.exports = { SeedRole };
