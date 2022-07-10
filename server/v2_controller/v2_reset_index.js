const PrismaClient = require("@prisma/client").PrismaClient;
const prisma = new PrismaClient();
const expressAsyncHandler = require("express-async-handler");

const idx = expressAsyncHandler(async (req, res) => {
    const query =
      await prisma.$queryRaw`ALTER TABLE issues DROP INDEX idx`;

      
});

const V2Reset = { idx };

module.exports = V2Reset;
