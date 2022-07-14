const express = require("express");
const app = express();
const fs = require("fs");
const createServer = require("https").createServer;
const httpServer = createServer({
        key: fs.readFileSync("key.pem"),
        cert: fs.readFileSync("cert.pem"),
    },
    app);

module.exports = {
    httpServer,
    app
}