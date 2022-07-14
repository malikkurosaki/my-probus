const fs = require("fs");
const path = require("path");
const colors = require("colors");
const execSync = require("child_process").execSync;
const jsBeautify = require('js-beautify').js

/** @param {("dev_web" | "pro_web" | "dev_mobile" )} modenya */
const SetMode = async (modenya) => {
    let devWeb = "http://localhost:3001";
    let proWeb = "https://103.171.85.55:3001";
    let devMobile = "http://192.168.43.112:3001";
    let con = "";
    let templateServer = "";

    let connFile = path.join(__dirname, "./../../client/lib/config.dart");

    let templateHttps =
        `
        const express = require("express");
        const app = express();
        const fs = require("fs");
        const createServer = require("https").createServer;
        const httpServer = createServer(
            {
                key: fs.readFileSync("key.pem"),
                cert: fs.readFileSync("cert.pem"),
            },
            app);

        module.exports = {httpServer, app}
    `

    let templateHttp =
        `
    const express = require("express");
    const app = express();
    const fs = require("fs");
    const createServer = require("http").createServer;
    const httpServer = createServer(app);

    module.exports = {httpServer, app}
    `

    switch (modenya) {
        case "dev_web":
            con = devWeb;
            templateServer = templateHttp;
            break;
        case "pro_web":
            con = proWeb;
            templateServer = templateHttps;
            break;
        case "dev_mobile":
            con = devMobile;
            break;
        default:
            con = devWeb;
            break;
    }

    let target = `
  class Config{
    static const String host = "${con}";
  }`;

    fs.writeFileSync(connFile, target, {
        encoding: "utf-8"
    });

    fs.writeFileSync(path.join(__dirname, './../index_https_config.js'), jsBeautify(templateServer), { encoding: "utf-8" })

    // execSync(`dart format config.dart`, {
    //     stdio: "inherit",
    //     cwd: path.join(__dirname, "../../client/lib"),
    // });

    console.log(`mode set to  ${modenya}`.yellow);
};


module.exports = {
    SetMode
};