const PrismaClient = require("@prisma/client").PrismaClient;
const prisma = new PrismaClient();
const expressAsyncHandler = require("express-async-handler");

const getIssueHistoryByStatus = expressAsyncHandler(async (req, res) => {

    console.log(req.params.statusId);
    const data = await prisma.issueHistories.findMany({
        where: {
            issueStatusesId: req.params.statusId
        },
        orderBy: {
            createdAt: "desc"
        },
        select: {
            id: true,
            note: true,
            IssueStatus: {
                select: {
                    id: true,
                    name: true
                }
            },
            Issue: {
                select: {
                    id: true,
                    name: true,
                }
            },
            User: {
                select: {
                    id: true,
                    name: true,
                }
            },
            createdAt: true,
        }
        
    })

    res.status(201).json(data);
});

const V2IssueHistory = {
    getIssueHistoryByStatus,
}

module.exports = V2IssueHistory;