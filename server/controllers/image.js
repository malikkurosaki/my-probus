const { PrismaClient } = require('@prisma/client')
const prisma = new PrismaClient()
const expressAsyncHandler = require('express-async-handler');
const routeImage = require('express').Router();
const fs = require('fs');

const ImageGet = expressAsyncHandler(async (req, res) => {
    // ceck file exist assets/images/ 
    if (fs.existsSync(__dirname + './../assets/images/' + req.params.name + '.png')) {
        res.sendFile(__dirname + './../assets/images/' + req.params.name + '.png');
    } else {
        res.type('image/png').sendFile('../assets/images/no-image.png', { root: __dirname });
    }
})

routeImage.get('/:name', ImageGet);

module.exports = { routeImage }

