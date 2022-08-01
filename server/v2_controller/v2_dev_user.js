const PrismaClient = require("@prisma/client").PrismaClient;
const prisma = new PrismaClient();
const expressAsyncHandler = require("express-async-handler");
const _ = require('lodash');


const getAll = expressAsyncHandler(async (req, res) => {
    const users = await prisma.users.findMany({
        orderBy: {
            createdAt: "desc"
        },
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

const create = expressAsyncHandler(async (req, res) => {
    const body = req.body;
    const data = await prisma.users.create({
        data: {
            name: body.name,
            email: _.snakeCase(body.name)+"@gmail.com",
            password: "123456"
        }
    })

    res.status(201).json(data);
})

const V2DevUser = {
    getAll,
    updateUser,
    create
};


module.exports = V2DevUser;