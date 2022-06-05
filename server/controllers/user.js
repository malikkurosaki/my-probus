const {PrismaClient} = require('@prisma/client')
const prisma = new PrismaClient();
const expressAsyncHandler = require('express-async-handler');
const express = require('express');
const routeUser = express.Router();


const UserGet = expressAsyncHandler(async (req, res) => {
    let user = await prisma.users.findUnique({
        where:{
            id: req.userId,
        },
        include: {
            Profiles: true,
        }
    })

    console.log(user);
    res.status(200).json({
        data: user??{}
    })
})

routeUser.get('/', UserGet);

module.exports = {routeUser}