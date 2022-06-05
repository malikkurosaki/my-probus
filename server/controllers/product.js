const {PrismaClient} = require('@prisma/client');
const prisma = new PrismaClient();
const expressAsyncHandler = require('express-async-handler');
const express = require('express');
const routProduct = express.Router();

const ProductGet = expressAsyncHandler(async (req, res) => {
    const products = await prisma.products.findMany();
    res.status(200).json({
        message: 'Get all products success',
        data: products
    });
});

routProduct.get('/', ProductGet);

module.exports = { routProduct };
