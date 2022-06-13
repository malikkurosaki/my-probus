const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();

const products = ["phis", "presto", "ppos", "ppe"];
//     {
//         id: "1",
//         name: "phis",
//     },
//     {
//         id: "2",
//         name: "presto",
//     },
//     {
//         id: "3",
//         name: "ppe",
//     },
//     {
//         id: "4",
//         name: "ppos"
//     },
// ]

const SeedProduct = async () => {
  let id = 1;
  for (let product of products) {
    await prisma.products.upsert({
      where: {
        id: id.toString(),
      },
      update: {
        name: product,
      },
      create: {
        id: id.toString(),
        name: product,
      },
    });
    id++;
  }

  console.log("seed product success");
};

module.exports = { SeedProduct };
