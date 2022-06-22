const path = require("path");

const BuildDebug = {
    config: require(path.join(__dirname, "./../build.json")),
};

module.exports = { BuildDebug };
