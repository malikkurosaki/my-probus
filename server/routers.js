const express = require('express');
const { routClient } = require('./controllers/client');
const { routDepartement } = require('./controllers/departement');
const { routeIssue } = require('./controllers/issue');
const { routeIssuePriority } = require('./controllers/issue_priority');
const { routIssueType } = require('./controllers/issue_type');
const { routPosition } = require('./controllers/position');
const { routProduct } = require('./controllers/product');
const { routRole } = require('./controllers/role');
const { routeUser } = require('./controllers/user');
const api = express.Router();


api.use('/client', routClient);
api.use('/product', routProduct);
api.use('/position', routPosition);
api.use('/departement', routDepartement);
api.use('/role', routRole);
api.use('/issue-type', routIssueType);
api.use('/user', routeUser);
api.use('/issue-priority', routeIssuePriority);
api.use('/issue', routeIssue);

module.exports = { api };