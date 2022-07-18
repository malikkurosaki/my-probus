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

    const firstDate = new Date(Date.parse(req.params.date));
    const lastDate = new Date(Date.parse(req.params.date));

    let ini = new Date(lastDate.setDate(lastDate.getDate() + 1));

    console.log(firstDate, ini);

    const crt = await prisma.todos.findMany({
        where: {
            usersId: req.params.id,
            createdAt: {
                gte: lastDate,
                lte: lastDate
            }
        }
    });

    // console.log(new Date(Date.parse(req.query.startDate) + 86400000))
    res.status(201).json(crt);
});

const changeStatus = expressAsyncHandler(async (req, res) => {
    const body = req.body;
    const crt = await prisma.todos.update({
        where: {
            id: body.id
        },
        data: {
            status: body.status
        }
    });
    res.status(201).json(crt);
});


const deleteTodo = expressAsyncHandler(async (req, res) => {
    const crt = await prisma.todos.delete({
        where: {
            id: req.params.id
        }
    });

    console.log(`delete todo ${req.params.id}`);
    res.status(201).json(crt);
});

const listTodo = expressAsyncHandler(async (req, res) => {
    const firstDate = new Date(Date.parse(req.params.date));
    const lastDate = new Date(Date.parse(req.params.date));
    const crt = await prisma.todos.findMany({
        orderBy: {
            User: {
                name: 'asc'
            }
        },
        where: {
            createdAt: {
                gte: lastDate,
                lte: lastDate
            }
        },
        select: {
            id: true,
            content: true,
            createdAt: true,
            User: {
                select: {
                    id: true,
                    name: true
                }
            }
        }
    });

    res.status(201).json(crt);
});

const V2Todos = {
    create,
    findMany,
    changeStatus,
    deleteTodo,
    listTodo
}

module.exports = V2Todos;