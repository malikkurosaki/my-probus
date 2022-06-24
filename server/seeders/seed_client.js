const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();
const path = require('path')

const clients = require(path.join(__dirname, './master_client.json'))

const SeedClient = async () => {
  var id = 1;
  for (let client of clients) {
    await prisma.clients.upsert({
      where: {
        id: id.toString(),
      },
      update: {
        name: client,
      },
      create: {
        id: id.toString(),
        name: client,
      },
    });
    id++;
  }

  console.log("seed client success");
};

const SeedCClienClear = async () => {
  await prisma.clients.deleteMany({});
  console.log("seed client clean success");
}


module.exports = {
  SeedClient,
  SeedCClienClear,
};
