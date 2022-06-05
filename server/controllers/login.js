const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();
const expressAsyncHandler = require('express-async-handler');
const express = require('express');
const routeLogin = express.Router();
require('dotenv').config();
const jwt = require('jsonwebtoken');


const LoginPost = expressAsyncHandler(async (req, res) => {
    const { email, password } = req.body;

    const user = await prisma.users.findFirst({
        where: {
            AND: {
                email: {
                    equals: email
                },
                password: {
                    equals: password
                }
            }
        }
    })

    if (user) {
        let token = jwt.sign({ userId: user.id }, process.env.TOKEN_API);
        res.status(200).json({
            success: true,
            message: "berhasil login",
            token: token
        })
    } else {
        res.status(401).json({
            success: false,
            message: "wrong email or password"
        })
    }
})

routeLogin.post('/', LoginPost);


module.exports = { routeLogin }