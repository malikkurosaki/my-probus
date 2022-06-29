const V2Login = require('./v2_controller/v2_login');
const v2Routers = require('express').Router();


v2Routers.use('/login', V2Login)

module.exports = v2Routers;