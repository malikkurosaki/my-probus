const PrismaClient = require("@prisma/client").PrismaClient;
const prisma = new PrismaClient();
const expressAsyncHandler = require("express-async-handler");


let V2DevUser = {};
V2DevUser.getAll = expressAsyncHandler(async (req, res) => {
    const users = await prisma.users.findMany({
        select: {
            id: true,
            name: true,
            email: true
        }
    });
    res.status(200).json(users);
});

module.exports = V2DevUser;