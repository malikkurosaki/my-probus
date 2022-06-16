const {PrismaClient} = require('@prisma/client');
const prisma = new PrismaClient();
const expressAsyncHandler = require('express-async-handler');
const express = require('express');
const routeAccepted = express.Router();

const AcceptedGet = expressAsyncHandler(async (req, res) => {
    const accepted = await prisma.issues.findMany({
        where: {
            issueStatusesId: "2",
        },
        orderBy: {
            createdAt: "desc",
        },
        select: {
            name: true,
            idx: true,
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
        data: accepted,
    });
}
);

routeAccepted.get("/", AcceptedGet);

module.exports = {routeAccepted};