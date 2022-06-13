const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();
const expressAsyncHandler = require("express-async-handler");
const express = require("express");
const routeDashboard = express.Router();

const dashboardGet = expressAsyncHandler(async (req, res) => {
  const dashboardGetStatus = await prisma.issues.groupBy({
    by: ["issueStatusesId"],
    _count: {
      _all: true,
    },
  });

  const dashboardGetUser = await prisma.issues.groupBy({
    by: ["usersId"],
    _count: {
      _all: true,
    },
  });

  const dashboardClientGet = await prisma.issues.groupBy({
    by: ["clientsId"],
    _count: {
      _all: true,
    },
  });

  const statusGet = await prisma.issueStatuses.findMany({
    where: {
      id: {
        in: dashboardGetStatus.map((item) => item.issueStatusesId),
      },
    },
  });

  const dashboardStatus = statusGet.map((item) => {
    return {
      id: item.id,
      name: item.name,
      count: dashboardGetStatus.find(
        (item2) => item2.issueStatusesId === item.id
      )._count._all,
    };
  });

  const userGet = await prisma.users.findMany({
    where: {
      id: {
        in: dashboardGetUser.map((item) => item.usersId),
      },
    },
  });

  const dashboardUser = userGet.map((item) => {
    return {
      id: item.id,
      name: item.name,
      count: dashboardGetUser.find((item2) => item2.usersId === item.id)._count
        ._all,
    };
  });

  const clientGet = await prisma.clients.findMany({
    where: {
      id: {
        in: dashboardClientGet.map((item) => item.clientsId),
      },
    },
  });

  const dashboardClient = clientGet.map((item) => {
    return {
      id: item.id,
      name: item.name,
      count: dashboardClientGet.find((item2) => item2.clientsId === item.id)
        ._count._all,
    };
  });

  res.status(200).json({
    message: "Get all dashboard success",
    success: true,
    data: {
      status: dashboardStatus.sort((a, b) => b.count - a.count),
      user: dashboardUser.sort((a, b) => b.count - a.count),
      client: dashboardClient.sort((a, b) => b.count - a.count),
    },
  });
});

routeDashboard.get("/", dashboardGet);

module.exports = { routeDashboard };
