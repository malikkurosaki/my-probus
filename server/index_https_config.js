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

// /etc/letsencrypt/live/my.probussystem.com/fullchain.pem;
// /etc/letsencrypt/live/my.probussystem.com/privkey.pem;

const httpServer = createServer({
    key: fs.readFileSync("/etc/letsencrypt/live/my.probussystem.com/privkey.pem"),
    cert: fs.readFileSync("/etc/letsencrypt/live/my.probussystem.com/fullchain.pem"),
},
    app);

module.exports = {
    httpServer,
    app
}