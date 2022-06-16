const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();
const expressAsyncHandler = require("express-async-handler");
const express = require("express");
const routeIssueHistory = express.Router();

const IssueHistoryGet = expressAsyncHandler(async (req, res) => {
    const issueHistories = await prisma.issues.findMany({
        where: {
            IssueHistory: {
                some: {
                    usersId: {
                        not: null
                    }
                }
            },

        },
        orderBy: {
            createdAt: "desc",
        },
        select: {
            name: true,
            id: true,
            IssueHistory: {
                select: {
                    id: true,
                    note: true,
                    IssueStatus: {
                        select: {
                            id: true,
                            name: true,
                        },
                    },
                    User: {
                        select: {
                            id: true,
                            name: true,
                        },

                    },
                    createdAt: true,
                },
            },
        },
    });

    console.log(issueHistories);

//   let issuesIdGet = await prisma.issueHistories.findMany({
//     select: {
//       id: true,
//     },
//   });

//   let issueHistories = await prisma.issueHistories.findMany({
//     where: {
//       Issue: {
//         id: {
//           in: issuesIdGet.map((issue) => issue.id),
//         },
//       },
//     },
//     orderBy: {
//       createdAt: "desc",
//     },
//     select: {
//       note: true,
//       createdAt: true,
//       Issue: {
//         select: {
//           id: true,
//           name: true,
//         },
//       },
//       IssueStatus: {
//         select: {
//           id: true,
//           name: true,
//         },
//       },
//       User: {
//         select: {
//           id: true,
//           name: true,
//         },
//       },
//     },
//   });

  res.status(200).json({
    data: issueHistories,
  });
});

routeIssueHistory.get("/", IssueHistoryGet);

module.exports = { routeIssueHistory };
