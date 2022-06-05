const {PrismaClient} = require('@prisma/client');
const prisma = new PrismaClient();
const expressAsyncHandler = require('express-async-handler');
const express = require('express');
const routDepartement = express.Router();

const DepartementGet = expressAsyncHandler(async (req, res) => {
    const departements = await prisma.departements.findMany();
    res.status(200).json({
        message: 'Get all departements success',
        data: departements
    });
})

routDepartement.get('/', DepartementGet);

module.exports = { routDepartement };
