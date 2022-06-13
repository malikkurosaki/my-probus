const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();

const clients = [
  "7seas cottages",
  "abia villa",
  "arma",
  "balitaman lovina 1",
  "bebek bts",
  "belair",
  "kampoeng villa",
  "ko ko mo gili",
  "kurakura resort",
  "mahagiri sanur",
  "mantadive air",
  "natya hotel",
  "nau villa",
  "pesona resort",
  "pink coco logo bali",
  "restu bali hotel",
  "the beach house resort",
  "the visala hotel",
  "ubud hotel malang",
  "ubud padi villas",
  "villa unggul gili",
  "alchemist",
  "black canyon coffee",
  "lajoya",
  "coco",
  "tropical group",
  "gotix cake",
  "black penny",
  "cp lounge logo",
  "malias",
  "logo purimas",
  "mina pelasa putih",
  "mina tanjung hotel fix 1024x663",
  "white key",
  "suka presto",
  "yakama",
  "relax",
  "alam sari",
  "medewi",
  "aleva",
  "danoya",
  "gili eco villas",
  "prada group",
  "sendok",
];

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
