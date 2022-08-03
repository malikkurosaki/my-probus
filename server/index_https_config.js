const express = require("express");
const app = express();
const fs = require("fs");
const path = require("path");
const createServer = require("https").createServer;
// const httpServer = createServer({
//         key: fs.readFileSync(path.join(__dirname, "./key.pem")),
//         cert: fs.readFileSync(path.join(__dirname, "./cert.pem")),
//     },
//     app);


const httpServer = createServer({
    key: fs.readFileSync(path.join(__dirname, " /root/myAwesomeServer.pvk")),
    cert: fs.readFileSync(path.join(__dirname, "/root/myAwesomeServer.cer")),
    },
    app);

module.exports = {
    httpServer,
    app
}