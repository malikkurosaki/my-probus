const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();
const expressAsyncHandler = require("express-async-handler");
const routeIssueStatus = require("express").Router();

const IssuesStatusGet = expressAsyncHandler(async (req, res) => {
  const issuesStatus = await prisma.issueStatuses.findMany({
    select: {
      name: true,
      id: true,
    },
  });

  res.status(200).json({
    status: "success",
    data: issuesStatus,
    message: "Get all issues status success",
  });
});

routeIssueStatus.get("/", IssuesStatusGet);

module.exports = { routeIssueStatus };
