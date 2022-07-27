const PrismaClient = require("@prisma/client").PrismaClient;
const prisma = new PrismaClient();
const expressAsyncHandler = require("express-async-handler");

const V2DevIssueStatus = {}
V2DevIssueStatus.getAll = expressAsyncHandler(async (req, res) => {
    const data = await prisma.issueStatuses.findMany({
        select:{
            id: true,
            name: true
        }
    })

    res.status(200).json(data)
})

module.exports = V2DevIssueStatus