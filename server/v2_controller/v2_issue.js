const PrismaClient = require("@prisma/client").PrismaClient;
const prisma = new PrismaClient();
const expressAsyncHandler = require("express-async-handler");
const _ = require("lodash");

const getAll = expressAsyncHandler(async (req, res) => {
  const dataIssue = await prisma.issues.findMany({
    orderBy: {
      // dateSubmit: "desc",
      idx: "desc",
    },
    select: {
      id: true,
      name: true,
      dateSubmit: true,
      Client: {
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
      Departement: {
        select: {
          id: true,
          name: true,
        },
      },
      des: true,
      idx: true,
      IssueType: {
        select: {
          id: true,
          name: true,
        },
      },
      IssuesStatus: {
        select: {
          id: true,
          name: true,
        },
      },
      Images: {
        select: {
          id: true,
          name: true,
        }
      },
      Product: {
        select: {
          id: true,
          name: true,
        },
      },
    },
  });
  res.status(200).json(dataIssue);
});

const create = expressAsyncHandler(async (req, res) => {
  const data = JSON.parse(req.body.data);
  const images = JSON.parse(req.body.images);

  data["dateSubmit"] = new Date(Date.parse(data["dateSubmit"]));

  const issue = await prisma.issues.create({ data });

  if (!_.isEmpty(images)) {
    for (let img of images) {
      await prisma.images.create({
        data: {
          name: img.name,
          issuesId: issue.id,
          usersId: issue.usersId,
        },
      });
    }
  }

  res.status(200).json(issue);
});

const issueByRole = expressAsyncHandler(async (req, res) => {
  const roles = await prisma.roles.findMany({
    select: {
      id: true,
      name: true,
      Users: {
        select: {
          id: true,
          name: true,
        },
      },
    },
  });

  let result = [];
  for (let role of roles) {
    let data = {
      id: role.id,
      name: role.name,
      issues: await prisma.issues.findMany({
        where: {
          usersId: {
            in: role.Users.map((e) => e.id),
          },
        },
      }),
    };

    result.push(data);
  }

  res.status(200).json(result);
});

const issueByStatus = expressAsyncHandler(async (req, res) => {
  const status = await prisma.issueStatuses.findMany({
    select: {
      id: true,
      name: true,
    },
  });

  let result = [];
  for (let st of status) {
    let data = {
      id: st.id,
      name: st.name,
      issues: await prisma.issues.findMany({
        where: {
          issueStatusId: st.id,
        },
      }),
    };

    result.push(data);
  }

  res.status(200).json(result);
});

const issueByOpen = expressAsyncHandler(async (req, res) => {
  const status = await prisma.issues.findMany({
    where: {
      issueStatusesId: "1",
    },
  });

  res.status(200).json(status);
});

const issueByStatusId = expressAsyncHandler(async (req, res) => {
  const status = await prisma.issues.findMany({
    orderBy: {
      // dateSubmit: "desc",
      idx: "desc",
    },
    where: {
      issueStatusesId: req.params.id,
    },
    select: {
      id: true,
      name: true,
      dateSubmit: true,
      Client: {
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
      Departement: {
        select: {
          id: true,
          name: true,
        },
      },
      Images: {
        select: {
          id: true,
          name: true,
        }
      },
      des: true,
      idx: true,
      IssueType: {
        select: {
          id: true,
          name: true,
        },
      },
      IssuesStatus: {
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
    },
  });

  res.status(200).json(status);
});

const rubahStatus = expressAsyncHandler(async (req, res) => {
  const data = JSON.parse(req.body.data);
  const issue = await prisma.issues.update({
    where: {
      id: req.params.id,
    },
    data: {
      issueStatusesId: data.issueStatusesId,
    },
  });

  // update history
  await prisma.issueHistories.create({
    data: {
      issuesId: req.params.id,
      usersId: data.usersId,
      issueStatusesId: data.issueStatusesId,
    },
  });

  res.status(200).json(issue);
});

const getIssueById = expressAsyncHandler(async (req, res) => {
  const isssue = await prisma.issues.findUnique({
    where: {
      id: req.params.id,
    },
    select: {
      idx: true,
      id: true,
      name: true,
      des: true,
      dateSubmit: true,
      IssueType: {
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
      Product: {
        select: {
          id: true,
          name: true,
        },
      },
      IssuesStatus: {
        select: {
          id: true,
          name: true,
        },
      },
      Images: {
        select: {
          id: true,
          name: true,
        }
      },
      Client: {
        select: {
          id: true,
          name: true,
        },
      },
    },
  });

  res.status(200).json(isssue);
});

const updateIssueStatus = expressAsyncHandler(async (req, res) => {
  const data = req.body;

  const issue = await prisma.issues.update({
    where: {
      id: req.params.id,
    },
    data: {
      issueStatusesId: data.issueStatusesId,
      IssueHistory: {
        create: {
          usersId: data.usersId,
        },
      },
    },
  });

  res.status(200).json(issue);
});

const issueList = expressAsyncHandler(async (req, res) => {
  const data = await prisma.issues.findMany({
    orderBy: {
      idx: "asc",
    },
  });

  res.json(data);
});

const V2Issue = {
  create,
  getAll,
  issueByRole,
  issueByStatus,
  issueByOpen,
  issueByStatusId,
  rubahStatus,
  getIssueById,
  updateIssueStatus,
  issueList,
};

module.exports = V2Issue;
