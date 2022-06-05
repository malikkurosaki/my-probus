const {PrismaClient} = require('@prisma/client');
const prisma = new PrismaClient();
const expressAsyncHandler = require('express-async-handler');
const express = require('express');
const routPosition = express.Router();

const PositionGet = expressAsyncHandler(async (req, res) => {
    const positions = await prisma.positions.findMany();
    res.status(200).json({
        message: 'Get all positions success',
        data: positions
    });
});

routPosition.get('/', PositionGet);

module.exports = { routPosition };
