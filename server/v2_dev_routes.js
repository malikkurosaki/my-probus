const V2DevClient = require("./v2_controller/v2_dev_client");
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

// departement update
V2DevRoutes.put('/dev-departement/:id', V2DevDepartement.update)

// departement create
V2DevRoutes.post('/dev-departement', V2DevDepartement.create)

// role
V2DevRoutes.get('/dev-role', V2DevRole.getAll)

// role update
V2DevRoutes.put('/dev-role/:id', V2DevRole.update)

// role create
V2DevRoutes.post('/dev-role', V2DevRole.create)

// client
V2DevRoutes.get('/dev-client', V2DevClient.getAll)

// client create
V2DevRoutes.post('/dev-client', V2DevClient.createClient)

// client edit
V2DevRoutes.put('/dev-client/:id', V2DevClient.editClient)

// update user
V2DevRoutes.put('/dev-user/:id', V2DevUser.updateUser)



module.exports = V2DevRoutes;