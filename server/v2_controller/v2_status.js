const PrismaClient = require("@prisma/client").PrismaClient;
const prisma = new PrismaClient();
const expressAsyncHandler = require("express-async-handler");


const getAll = expressAsyncHandler(async (req, res) => {
    const status = await prisma.issueStatuses.findMany({
        select: {
            id: true,
            name: true,
        }
    })

    res.status(200).json(status);
})



const V2Status = {getAll}

module.exports = V2Status;