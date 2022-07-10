const PrismaClient = require("@prisma/client").PrismaClient;
const prisma = new PrismaClient();
const expressAsyncHandler = require("express-async-handler");

const byUserIdAndCreatedAt = expressAsyncHandler(async (req, res) => {
    
});
