const PrismaClient = require("@prisma/client").PrismaClient;
const prisma = new PrismaClient();
const expressAsyncHandler = require("express-async-handler");

const getAll = expressAsyncHandler(async (req,res) => {
    const datanya = await prisma.roles.findMany({
        select: {
            id: true,
            name: true
        }
    })

    res.status(200).json(datanya)
})

const V2DevRole = {getAll}

module.exports = V2DevRole