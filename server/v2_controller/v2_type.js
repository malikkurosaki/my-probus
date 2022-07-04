const PrismaClient = require("@prisma/client").PrismaClient;
const prisma = new PrismaClient();
const expressAsyncHandler = require("express-async-handler");

const getAll = expressAsyncHandler(async (req, res) => {
  const products = await prisma.products.findMany();
  res.status(200).json(products);
});

const V2Type = { getAll };

module.exports = V2Type;
