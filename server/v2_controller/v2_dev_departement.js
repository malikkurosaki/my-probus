const PrismaClient = require("@prisma/client").PrismaClient;
const prisma = new PrismaClient();
const expressAsyncHandler = require("express-async-handler");


const getAll = expressAsyncHandler(async (req, res) => {
    const datanya = await prisma.departements.findMany({
        select: {
            id: true,
            name: true
        }
    })

    res.status(200).json(datanya)
})

const update = expressAsyncHandler(async (req, res) => {
    const data = await prisma.departements.update({
        where: {
            id: req.params.id
        },
        data: {
            name: req.body.name,
        }
    });

    res.status(201).json(data);

})

const create = expressAsyncHandler(async (req, res) => {
    const data = await prisma.departements.create({
        data: {
            name: req.body.name,
        }
    });

    res.status(201).json(data);
})

const V2DevDepartement = { getAll, update, create }

module.exports = V2DevDepartement