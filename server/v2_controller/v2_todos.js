const PrismaClient = require('@prisma/client').PrismaClient
const prisma = new PrismaClient();
const expressAsyncHandler = require('express-async-handler');
const moment = require('moment');

const create = expressAsyncHandler(async (req, res) => {
    let data = req.body;
    data['createdAt'] = new Date(Date.parse(data['createdAt']) + (24 * 60 * 60 * 1000));

    const crt = await prisma.todos.create({ data });
    res.status(201).json(crt);

});

const findMany = expressAsyncHandler(async (req, res) => {

    const crt = await prisma.todos.findMany({
        where: {
            usersId: req.params.id,
            createdAt: {
                gte: new Date(Date.parse(req.params.date) + (24 * 60 * 60 * 1000)),
                lte: new Date(Date.parse(req.params.date) + (24 * 60 * 60 * 1000))
            }
        }
    });

    // console.log(new Date(Date.parse(req.query.startDate) + 86400000))
    res.status(201).json(crt);
});

const V2Todos = {
    create,
    findMany
}

module.exports = V2Todos;