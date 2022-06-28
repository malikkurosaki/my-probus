const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();
const expressAsyncHandler = require("express-async-handler");
const routeMaster = require("express").Router();
const underscore = require("underscore");
const papaparse = require("papaparse");
const fs = require("fs");
const path = require("path");

const tablesMaster = [
  "users",
  "positions",
  "departements",
  "roles",
  "issues",
  "issueTypes",
  "issueStatuses",
  "clients",
  "contactPersons",
  "products",
  "issuePriorities",
];

const listTable = Object.keys(prisma).filter(key => !key.startsWith("_"));

const Master = expressAsyncHandler(async (req, res) => {
  for (let table of tablesMaster) {
    let data = await prisma[table].findMany();
    if (!underscore.isEmpty(data)) {
      const p = papaparse.unparse(data);
      fs.writeFileSync(path.join(__dirname, `./../exports/${table}.csv`), p);
    }
  }

  res.status(200).json({
    message: "Get all masters success",
    data: tablesMaster,
  });
});

const BackupDatabase = expressAsyncHandler(async (req, res) => {

  let tbl = {};
  for(let table of listTable){
    tbl[table] = await prisma[table].findMany();
    // fs.writeFileSync(path.join(__dirname, `./../backup/${table}.json`), JSON.stringify(tbl[table]));
  }

  res.status(200).json({
    message: "Get all masters success",
    data: tbl,
  });
});

// /master
routeMaster.get("/", Master);
routeMaster.get("/backup", BackupDatabase);
module.exports = { routeMaster };
