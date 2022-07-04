const PrismaClient = require("@prisma/client").PrismaClient;
const prisma = new PrismaClient();
const expressAsyncHandler = require("express-async-handler");
const v2ClientRoute = require("express").Router();
const _ = require("lodash");

const getDiscutionByIssueId = expressAsyncHandler(async (req, res) => {
  const discution = await prisma.discussion.findMany({
    orderBy: {
      createdAt: "asc",
    },
    where: {
      issuesId: req.params.id,
    },
    select: {
      id: true,
      content: true,
      Image: {
        select: {
          name: true,
          id: true,
        },
      },
      usersId: true,
      createdAt: true,
      imagesId: true,
      User: {
        select: {
          id: true,
          name: true,
        },
      },
    },
  });
  res.status(200).json(discution);
});

const createDiscution = expressAsyncHandler(async (req, res) => {
  const { type } = req.body;
  if (type === "text") {
    const data = JSON.parse(req.body.dataText);
    const discution = await prisma.discussion.create({
      data,
      select: {
        id: true,
        content: true,
        Image: {
          select: {
            name: true,
            id: true,
          },
        },
        usersId: true,
        createdAt: true,
        imagesId: true,
        User: {
          select: {
            id: true,
            name: true,
          },
        },
      },
    });
    res.status(200).json(discution);
  } else if (type === "image") {
    const data = JSON.parse(req.body.dataImage);
    const discution = await prisma.discussion.create({
      data,
      select: {
        id: true,
        content: true,
        Image: {
          select: {
            name: true,
            id: true,
          },
        },
        usersId: true,
        createdAt: true,
        imagesId: true,
        User: {
          select: {
            id: true,
            name: true,
          },
        },
      },
    });
    res.status(200).json(discution);
  }
});

const V2Discution = { getDiscutionByIssueId, createDiscution };

module.exports = V2Discution;
