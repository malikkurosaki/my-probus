const {PrismaClient} = require('@prisma/client');
const prisma = new PrismaClient();
const expressAsyncHandler = require('express-async-handler');
const express = require('express');
const routeOpen = express.Router();

const OpenGet = expressAsyncHandler(async (req, res) => {
    const open = await prisma.issues.findMany({
        where: {
            issueStatusesId: "1",
        },
        orderBy: {
            createdAt: "desc",
        },
        select: {
            idx: true,
            name: true,
            id: true,
            IssueType: {
                select: {
                    name: true,
                    id: true,
                },
            },
        },
    });

    res.status(200).json({
        data: open,
    });
}
);

routeOpen.get("/", OpenGet);
module.exports = {routeOpen};