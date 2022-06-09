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
const multer = require('multer');
const fs = require('fs');
const uuid = require('uuid');
const { routeImage } = require('./controllers/image');
const { routeDiscus } = require('./controllers/discus');
const storage = multer.diskStorage({
    destination: function (req, file, cb) {
        if (!fs.existsSync('./uploads/')) {
            fs.mkdirSync('./uploads/');
        }
        cb(null, './uploads/');
    },
    filename: function (req, file, cb) {
        cb(null, uuid.v4() + file.originalname);
    }
});

// upload image with multer
api.post('/upload', multer({ storage: storage }).array('image'), (req, res) => {
    console.log(req.files);
    res.status(200).json({
        message: 'Upload success',
        data: req.files.map(file => {
            return {
                name: file.filename
            }
        })
    });
})

api.use('/client', routClient);
api.use('/product', routProduct);
api.use('/position', routPosition);
api.use('/departement', routDepartement);
api.use('/role', routRole);
api.use('/issue-type', routIssueType);
api.use('/user', routeUser);
api.use('/issue-priority', routeIssuePriority);
api.use('/issue', routeIssue);
api.use('/file', routeImage);
api.use('/discus', routeDiscus);

module.exports = { api };
