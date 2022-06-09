const { PrismaClient } = require('@prisma/client')
const prisma = new PrismaClient()
const expressAsyncHandler = require('express-async-handler');
const routeImage = require('express').Router();
const fs = require('fs');
const path = require('path');

const ImageGet = expressAsyncHandler(async (req, res) => {
    // ceck file exist assets/images/ 
    if (fs.existsSync(__dirname + './../assets/images/' + req.params.name + '.png')) {
        res.sendFile(__dirname + './../assets/images/' + req.params.name + '.png');
    } else {
        res.type('image/png').sendFile('../assets/images/no-image.png', { root: __dirname });
    }
})

const ImageDelete = expressAsyncHandler(async (req, res) => {

    console.log(__dirname + './../uploads/' + req.params.name)
    // delete file
    if (fs.existsSync(path.join(__dirname + './../uploads/' + req.params.name))){
        fs.unlinkSync(path.join(__dirname + './../uploads/' + req.params.name));

        res.status(201).json({
            message: 'Delete image success',
            success: true
        });
    }else{
        res.status(200).json({
            message: 'Delete image failed',
            success: false
        });
    }

    
})

const ImageDeleteFromDatabase = expressAsyncHandler(async (req, res) => {
    // delete image from database
    let img = await prisma.images.delete({
        where: {
            id: req.params.id
        }
    })

    res.status(200).json({
        message: 'Delete image success',
        success: true
    });

})


routeImage.get('/:name', ImageGet);
routeImage.delete('/delete-file/:name', ImageDelete);
routeImage.delete('/delete-db/:id', ImageDeleteFromDatabase);

module.exports = { routeImage }

