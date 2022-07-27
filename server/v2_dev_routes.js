const V2DevDepartement = require("./v2_controller/v2_dev_departement");
const V2DevIssueStatus = require("./v2_controller/v2_dev_issue_status");
const V2DevIssueType = require("./v2_controller/v2_dev_issue_type");
const V2DevJabatan = require("./v2_controller/v2_dev_jabatan");
const V2DevRole = require("./v2_controller/v2_dev_role");
const V2DevUser = require("./v2_controller/v2_dev_user");

const V2DevRoutes = require("express").Router();

// user get all
V2DevRoutes.get('/dev-user', V2DevUser.getAll )

// jabatan get all
V2DevRoutes.get('/dev-jabatan', V2DevJabatan.getAll )

// issue type
V2DevRoutes.get('/dev-issue-type', V2DevIssueType.getAll )

// issue status get all
V2DevRoutes.get('/dev-issue-status', V2DevIssueStatus.getAll)

// departement
V2DevRoutes.get('/dev-departement', V2DevDepartement.getAll)

// role
V2DevRoutes.get('/dev-role', V2DevRole.getAll)

module.exports = V2DevRoutes;