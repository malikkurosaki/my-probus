const PrismaClient = require("@prisma/client").PrismaClient;
const prisma = new PrismaClient();
const expressAsyncHandler = require("express-async-handler");
const v2ClientRoute = require("express").Router();

const clientGetAll = expressAsyncHandler(async (req, res) => {
  const clients = await prisma.clients.findMany({
    orderBy: {
      name: "desc"
    }
  });
  res.status(200).json(clients);
});

const getIdByName = expressAsyncHandler(async (req, res) => {
  const client = await prisma.clients.findFirst({
    where: {
      name: req.params.name,
    },
  })
  res.status(200).json(client);
})




const V2Client = { clientGetAll, getIdByName };

module.exports = V2Client;
