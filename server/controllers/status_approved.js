const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();
const expressAsyncHandler = require("express-async-handler");
const express = require("express");
const routeApproved = express.Router();

const ApprovedGet = expressAsyncHandler(async (req, res) => {
  const approved = await prisma.issues.findMany({
    where: {
      issueStatusesId: "4",
    },
    orderBy: {
      createdAt: "desc",
    },
    select: {
      name: true,
      id: true,
      idx: true,
      IssueType: {
        select: {
          name: true,
          id: true,
        },
      },
    },
  });

  res.status(200).json({
    data: approved,
  });
});

routeApproved.get("/", ApprovedGet);

module.exports = { routeApproved };
