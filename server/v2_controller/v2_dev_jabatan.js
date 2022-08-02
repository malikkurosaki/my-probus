const PrismaClient = require("@prisma/client").PrismaClient;
const prisma = new PrismaClient();
const expressAsyncHandler = require("express-async-handler");
const _ = require("lodash");


const getAll = expressAsyncHandler(async (req, res) => {

    const jabatans = await prisma.jabatan.findMany({
        orderBy: {
            createdAt: "desc"
        },
        include: {
            JabatanDepartement: {
                include: {
                    Departement: true
                }
            }
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

const setJabatanDepartement = expressAsyncHandler(async (req, res) => {
    const body = req.body;
    let hasil = [];
    const jaDep = await prisma.jabatanDepartement.findFirst({
        where: {
            jabatansId: body.jabatansId,
            departementsId: body.departementsId
        }
    })

    console.log(jaDep);

    if (jaDep) {
        let upd = await prisma.jabatanDepartement.delete({
            where: {
                id: jaDep.id
            }
        })
        hasil = upd;
        res.status(201).json(upd);
    } else {
        const data = await prisma.jabatanDepartement.create({
            data: {
                jabatansId: body.jabatansId,
                departementsId: body.departementsId
            }
        })

        hasil = data;
        res.status(201).json(data);
    }



})

const V2DevJabatan = { getAll, create, update, hapus, setJabatanDepartement };

module.exports = V2DevJabatan;

