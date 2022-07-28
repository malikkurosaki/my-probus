const PrismaClient = require("@prisma/client").PrismaClient;
const prisma = new PrismaClient();
const expressAsyncHandler = require("express-async-handler");

const getAll = expressAsyncHandler(async (req, res) => {
    const data = await prisma.clients.findMany();
    res.status(200).json(data);
})

const createClient = expressAsyncHandler(async (req, res) => {
    const data = await prisma.clients.create({
        data: {
            name: req.body.name,
        }
    });

    res.status(201).json(data);
})

const editClient = expressAsyncHandler(async (req, res) => {
    const data = await prisma.clients.update({
        where: {
            id: req.params.id
        },
        data: {
            name: req.body.name,
        }
    });

    res.status(201).json(data);
})


const V2DevClient = { getAll, createClient, editClient }
module.exports = V2DevClient;