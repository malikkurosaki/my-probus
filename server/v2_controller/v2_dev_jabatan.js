const PrismaClient = require("@prisma/client").PrismaClient;
const prisma = new PrismaClient();
const expressAsyncHandler = require("express-async-handler");


const V2DevJabatan = {};
V2DevJabatan.getAll = expressAsyncHandler(async (req, res) => {

    const jabatans = await prisma.jabatan.findMany({
        select: {
            id: true,
            name: true
        }
    });
    res.status(200).json(jabatans);
});

module.exports = V2DevJabatan;

