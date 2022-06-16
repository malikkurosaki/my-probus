const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();

const users = [
  "ayu",
  "guntur",
  "adi",
  "apit",
  "ariska",
  "bayu",
  "dewi",
  "ahmad",
  "gede",
  "david",
  "widia",
  "ayu ari",
  "yuni",
  "malik",
  "mukijan"
];

const SeedUser = async () => {
  let id = 1;
  for (let user of users) {
    await prisma.users.upsert({
      where: {
        id: id.toString(),
      },
      update: {
        name: user,
        email: user.replace(" ", "_") + "@gmail.com",
        password: "123456",
        Role: {
          connect: {
            id: "1",
          },
        },
      },
      create: {
        id: id.toString(),
        email: user.replace(" ", "_") + "@gmail.com",
        password: "123456",
        name: user,
        Role: {
          connect: {
            id: "1",
          },
        },
      },
    });
    id++;
  }

  console.log("seed user success");
};

module.exports = { SeedUser };
