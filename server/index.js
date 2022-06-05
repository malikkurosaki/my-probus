const express = require('express');
const app = express();
const port = 3000;
const cors = require('cors');
const { api } = require('./routers');
const { routeLogin } = require('./controllers/login');
const apiRoot = '/api/v1';
require('dotenv').config();
const jwt = require('jsonwebtoken');
const { routeImage } = require('./controllers/image');
const fs = require('fs');

app.use(cors());
app.use(express.urlencoded({ extended: true }))
app.use(express.json());
app.use(express.static('assets'));
app.get('/', (req, res) => res.send('Hello World!'));
app.use('/login', routeLogin);
app.get('/images/:name', (req, res) => {
    if (fs.existsSync(__dirname + './assets/images/' + req.params.name + '.png')) {
        res.sendFile(__dirname + './assets/images/' + req.params.name + '.png', { root: __dirname });
    } else {
        res.type('image/png').sendFile('./assets/images/no-image.png', { root: __dirname });
    }
});

app.use(apiRoot, (req, res, next) => {
    const authHeader = req.headers['authorization']
    const token = authHeader && authHeader.split(' ')[1]
    if (token == null) {
        console.log("token null", authHeader)
        return res.sendStatus(401)
    }

    jwt.verify(token, process.env.TOKEN_API, (err, user) => {
       
        if (err) {
            console.log("error 403", err)
            return res.sendStatus(403)
        } else {
            req.userId = user.userId
            next()
        }

    })
});

app.use(apiRoot, api);

app.listen(port, () => console.log(`Example app listening on port ${port}!`));