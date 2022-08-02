const PrismaClient = require("@prisma/client").PrismaClient;
const prisma = new PrismaClient();
const expressAsyncHandler = require("express-async-handler");
const _ = require("lodash");


const getAll = expressAsyncHandler(async (req, res) => {
    const user = await prisma.users.findUnique({
        where: {
            id: req.params.id
        },
        select: {
            UserJabatan: {
                select: {
                    Jabatan: {
                        select: {
                            JabatanDepartement: {
                                select: {
                                    Departement: {
                                        select: {
                                            id: true,
                                            name: true,
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    })

    res.status(200).json(user);

});

const V2Users = { getAll };
module.exports = V2Users;