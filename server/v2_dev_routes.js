const V2DevJabatan = require("./v2_controller/v2_dev_jabatan");
const V2DevUser = require("./v2_controller/v2_dev_user");

const V2DevRoutes = require("express").Router();

// user get all
V2DevRoutes.get('/dev-user', V2DevUser.getAll )

// jabatan get all
V2DevRoutes.get('/dev-jabatan', V2DevJabatan.getAll )

module.exports = V2DevRoutes;