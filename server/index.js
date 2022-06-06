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
// const fs = require('fs');
const https = require('https');
// var selfsigned = require('selfsigned');
// var attrs = [{ name: 'makuro', value: 'google.com' }];
// var pems = selfsigned.generate(attrs, { days: 365 });

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

// app.listen(port, () => console.log(`Example app listening on port ${port}!`));

https.createServer({}, app).listen(port, () => console.log(`Example app listening on port ${port}!`));



// selfsigned.generate([{ name: "makuro", value: "makurostudio.my.id",  }], { days: 365 }, function (err, pems) {
//     https.createServer({
//         key: pems.public,
//         cert: pems.cert
//     }, app).listen(port, () => console.log(`Example app listening on port ${port}!`));
// });


// var pems = selfsigned.generate([{name: 'makuro', value: 'kurosakiblackangel@gmail.com'}], { clientCertificate: true }, function (err, pems) {
//     // console.log(pems)
//     // console.log(err)

// });

// https.createServer({
//     key: pems.public,
//     cert: pems.cert
//     //  key: fs.readFileSync('server.key'),
//     //  cert: fs.readFileSync('server.cert')
// }, app).listen(port, () => console.log(`Example app listening on port ${port}!`));


// https.createServer({
//     key: fs.readFileSync('key.pem'),
//     cert: fs.readFileSync('cert.pem')
// }, app).listen(port, () => console.log(`Example app listening on port ${port}!`),);
// openssl genrsa - out key.pem && openssl req - new - key key.pem - out csr.pem && openssl x509 - req - days 9999 -in csr.pem - signkey key.pem - out cert.pem && rm csr.pem