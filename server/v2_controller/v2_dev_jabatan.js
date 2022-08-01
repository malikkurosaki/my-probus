const PrismaClient = require("@prisma/client").PrismaClient;
const prisma = new PrismaClient();
const expressAsyncHandler = require("express-async-handler");



const getAll = expressAsyncHandler(async (req, res) => {

    const jabatans = await prisma.jabatan.findMany({
        orderBy: {
            createdAt: "desc"
        },
        select: {
            id: true,
            name: true
        }
    });
    res.status(200).json(jabatans);
});

const create = expressAsyncHandler(async (req, res) => {
    const body = req.body;
    const data = await prisma.jabatan.create({
        data: {
            name: body.name,
        }
    });

    res.status(201).json(data);
});

const update = expressAsyncHandler(async (req, res) => {
    const body = req.body;
    const data = await prisma.jabatan.update({
        where: {
            id: req.params.id
        },
        data: {
            name: body.name,
        }
    });

    res.status(201).json(data);

})


const hapus = expressAsyncHandler(async (req, res) => {
    const data = await prisma.jabatan.delete({
        where: {
            id: req.params.id
        }
    });

    res.status(201).json(data);
})

const V2DevJabatan = { getAll, create, update, hapus };

module.exports = V2DevJabatan;

