const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();
const expressAsyncHandler = require("express-async-handler");
const routeIssue = require("express").Router();

const IssueGet = expressAsyncHandler(async (req, res) => {
  const issues = await prisma.issues.findMany({
    select: {
      name: true,
      des: true,
      id: true,
      idx: true,
      issueStatusesId: true,
      clientsId: true,
      departementsId: true,
      issuePrioritiesId: true,
      issueTypesId: true,
      productsId: true,
      usersId: true,
      createdAt: true,
      updatedAt: true,
      IssuesStatus: {
        select: {
          id: true,
          name: true,
        },
      },
      IssuePriority: {
        select: {
          id: true,
          name: true,
          value: true,
        },
      },
      IssueType: {
        select: {
          id: true,
          name: true,
        },
      },
      Product: {
        select: {
          id: true,
          name: true,
        },
      },
      Departement: {
        select: {
          id: true,
          name: true,
        },
      },
      CreatedBy: {
        select: {
          id: true,
          name: true,
        },
      },
      Client: {
        select: {
          id: true,
          name: true,
        },
      },
      Images: {
        select: {
          id: true,
          name: true,
        },
      },
      Discussion: true,
    },
    orderBy: {
      createdAt: "desc",
    },
  });

  res.status(200).json({
    message: "Get all issues success",
    data: issues,
  });
});

const IssuePost = expressAsyncHandler(async (req, res) => {
  const data = JSON.parse(req.body.data);
  const files = JSON.parse(req.body.files);

  console.log(data)

  const issue = await prisma.issues.create({
    data: {
      des: data.des ,
      name: data.name ,
      clientsId: data.clientsId ,
      departementsId: data.departementsId ,
      issueStatusesId: data.issueStatusesId ,
      dateSubmit: new Date(data.dateSubmit) ,
      issueTypesId: data.issueTypesId ,
      issuePrioritiesId: data.issuePrioritiesId ,
      productsId: data.productsId ,
      usersId: data.usersId ,
    },
  });

  if (files.length > 0) {
    for (let file of files) {
      await prisma.images.create({
        data: {
          name: file.name,
          Issue: {
            connect: {
              id: issue.id,
            },
          },
        },
      });
    }
  }

  res.status(201).json({
    message: "Create issue success",
    data: issue,
  });
});

const IssuePut = expressAsyncHandler(async (req, res) => {
  const issue = await prisma.issues.update({
    where: {
      id: req.params.id,
    },
    data: {
      ...req.body,
    },
  });
  res.status(200).json({
    message: "Update issue success",
    data: issue,
  });
});

const IssuePatch = expressAsyncHandler(async (req, res) => {
  const issue = await prisma.issues.update({
    where: {
      id: req.body.issueId,
    },
    data: {
      issueStatusesId: req.body.issueStatusesId,
      issuePrioritiesId: req.body.issuePriorityId,
      IssueHistory: {
        create: {
          IssueStatus: {
            connect: {
              id: req.body.issueStatusesId,
            },
          },
          User: {
            connect: {
              id: req.userId,
            },
          },
          note: req.body.note ,
        },
      },
    },
  });

  res.status(200).json({
    message: "Update issue success",
    data: issue,
  });
});

const IssueAcceptedGet = expressAsyncHandler(async (req, res) => {
  const issues = await prisma.issues.findMany({
    where: {
      issueStatusesId: "2",
    },
    select: {
      name: true,
      des: true,
      id: true,
      createdAt: true,
      updatedAt: true,
      IssuesStatus: {
        select: {
          id: true,
          name: true,
        },
      },
      IssuePriority: {
        select: {
          id: true,
          name: true,
          value: true,
        },
      },
      IssueType: {
        select: {
          id: true,
          name: true,
        },
      },
      Product: {
        select: {
          id: true,
          name: true,
        },
      },
      Departement: {
        select: {
          id: true,
          name: true,
        },
      },
      CreatedBy: {
        select: {
          id: true,
          name: true,
        },
      },
      Client: {
        select: {
          id: true,
          name: true,
        },
      },
      Images: {
        select: {
          id: true,
          name: true,
        },
      },
    },
    orderBy: {
      createdAt: "desc",
    },
  });
  res.status(200).json({
    message: "Get all issues success",
    data: issues,
  });
});

routeIssue.get("/", IssueGet);
routeIssue.post("/", IssuePost);
routeIssue.put("/:id", IssuePut);
routeIssue.patch("/patch-status", IssuePatch);
routeIssue.get("/accepted", IssueAcceptedGet);

module.exports = { routeIssue };
