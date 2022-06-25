#!/usr/bin/env node

const ModelGenerator = require("./model_genertor")

ModelGenerator()

// const {
//     PrismaClient
// } = require("@prisma/client")
// const prisma = new PrismaClient();
// const execSync = require("child_process").execSync;
// const path = require("path");
// const prompts = require("prompts");
// const Generator = require("./generator");
// const ModelGenerator = require("./model_genertor");
// const {
//     SetMode
// } = require("./set_mode");
// const SSH = require("simple-ssh");
// const colors = require("colors");
// const { SeedClient } = require("../seeders/seed_client");

// ModelGenerator({
//     generate: Generator,
//     runClientDebug: RunClientDebug,
//     runServerDebug: RunServerDebug,
//     serverCommand: ServerCommand,
//     clientCommand: ClientCommand,
//     buildRelease: BuildRelease,
//     clearIssue: clearIssue,
//     modeDev: modeDev,
//     modePro: modePro,
//     modeMobile: modeMobile,
//     nodejsInstallPackage: nodejsInstallPackage,
//     exportUser: exportUser,
//     seedClient: seedClient,
//     prismaMigrate: prismaMigrate
// })

