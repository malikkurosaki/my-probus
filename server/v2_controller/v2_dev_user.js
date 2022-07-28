const PrismaClient = require("@prisma/client").PrismaClient;
const prisma = new PrismaClient();
const expressAsyncHandler = require("express-async-handler");



const getAll = expressAsyncHandler(async (req, res) => {
    const users = await prisma.users.findMany({
        select: {
            id: true,
            name: true,
            email: true,
            password: true
        }
    });
    res.status(200).json(users);
});

const updateUser = expressAsyncHandler(async (req, res) => {
    console.log(req.body);
    console.log(req.params);
    
    const data = await prisma.users.update({
        where: {
            id: req.params.id
        },
        data: {
            name: req.body.name,
            email: req.body.email,
        }
    });

    res.status(201).json(data);
})

const V2DevUser = {
    getAll,
    updateUser
};


module.exports = V2DevUser;