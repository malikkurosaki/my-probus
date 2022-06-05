const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();
const expressAsyncHandler = require('express-async-handler');
const express = require('express');
const routRole = express.Router();

const RoleGet = expressAsyncHandler(async (req, res) => {
    const roles = await prisma.roles.findMany();
    res.status(200).json({
        message: 'Get all roles success',
        data: roles
    });
})

routRole.get('/', RoleGet);

module.exports = { routRole };
