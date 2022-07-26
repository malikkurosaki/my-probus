const express = require("express");
const app = express();
const fs = require("fs");
const createServer = require("http").createServer;
const httpServer = createServer(app);

module.exports = {
    httpServer,
    app
}