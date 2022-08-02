const PrismaClient = require("@prisma/client").PrismaClient;
const prisma = new PrismaClient();
const expressAsyncHandler = require("express-async-handler");
const _ = require('lodash');


const getAll = expressAsyncHandler(async (req, res) => {
    const users = await prisma.users.findMany({
        orderBy: {
            createdAt: "desc"
        },
        include: {
            UserJabatan: {
                include: {
                    Jabatan: true
                }
            }
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

const setUserJabatan = expressAsyncHandler(async (req, res) => {
    const body = req.body;
    const user = await prisma.userJabatan.findFirst({
        where: {
            usersId: body.usersId,
            jabatansId: body.jabatansId
        },
    })

    console.log(user)

    if(user){
        let delUser = await prisma.userJabatan.delete({
            where: {
                id: user.id
            }
        })

        res.status(201).send(delUser);
    }else{
        let setuser = await prisma.userJabatan.create({
            data: {
                jabatansId: body.jabatansId,
                usersId: body.usersId
            }
        })

        res.status(201).send(setuser);
    }

})

const V2DevUser = {
    getAll,
    updateUser,
    create,
    setUserJabatan
};


module.exports = V2DevUser;