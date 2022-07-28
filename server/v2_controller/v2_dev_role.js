const PrismaClient = require("@prisma/client").PrismaClient;
const prisma = new PrismaClient();
const expressAsyncHandler = require("express-async-handler");

const getAll = expressAsyncHandler(async (req, res) => {
    const datanya = await prisma.roles.findMany({
        select: {
            id: true,
            name: true
        }
    })

    res.status(200).json(datanya)
})

const create = expressAsyncHandler(async (req, res) => {
    const data = await prisma.roles.create({
        data: {
            name: req.body.name,
        }
    });

    res.status(201).json(data);
})

const update = expressAsyncHandler(async (req, res) => {
    const data = await prisma.roles.update({
        where: {
            id: req.params.id
        },
        data: {
            name: req.body.name,
        }
    });

    res.status(201).json(data);
})

const V2DevRole = { getAll, create, update }

module.exports = V2DevRole