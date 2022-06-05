const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();
const expressAsyncHandler = require('express-async-handler');
const express = require('express');
const routClient = express.Router();


const ClientGet = expressAsyncHandler(async (req, res) => {
    const clients = await prisma.clients.findMany();
    res.status(200).json({
        message: 'Get all clients success',
        data: clients
    });
});

routClient.get('/', ClientGet);

module.exports = { routClient };


