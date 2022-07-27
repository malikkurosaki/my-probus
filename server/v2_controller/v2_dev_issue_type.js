const PrismaClient = require("@prisma/client").PrismaClient;
const prisma = new PrismaClient();
const expressAsyncHandler = require("express-async-handler");

const V2DevIssueType = {};
V2DevIssueType.getAll = expressAsyncHandler(async (req, res) => {
    const issueTypes = await prisma.issueTypes.findMany({
        select: {
            id: true,
            name: true
        }
    });
    res.status(200).json(issueTypes);
})

module.exports = V2DevIssueType;