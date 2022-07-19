const PrismaClient = require('@prisma/client').PrismaClient
const prisma = new PrismaClient();
const expressAsyncHandler = require('express-async-handler');
const moment = require('moment');
const clog = require('c-log');

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

    // console.log(firstDate, ini);

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

    // console.log(`delete todo ${req.params.id}`);
    res.status(201).json(crt);
});

const listTodo = expressAsyncHandler(async (req, res) => {
    const tanggal = new Date(Date.parse(req.params.date) + (24 * 60 * 60 * 1000));

    console.log(tanggal);

    const crt = await prisma.todos.findMany({
        orderBy: {
            User: {
                name: 'asc'
            }
        },
        where: {
            createdAt: {
                gte: tanggal,
                lte: tanggal
            }
        },
        select: {
            id: true,
            content: true,
            createdAt: true,
            status: true,
            title: true,
            User: {
                select: {
                    id: true,
                    name: true
                }
            }
        }
    });

    
    console.log(crt);

    res.status(201).json(crt);
});


const updateTodo = expressAsyncHandler(async (req, res) => {

    const data = await prisma.todos.update({
        where: {
            id: req.body.id
        },
        data: {
            content: req.body.content,
            title: req.body.title,
            createdAt: new Date(Date.parse(req.body.createdAt) + (24 * 60 * 60 * 1000)),
        },

    })

    res.status(201).json(data);
})

const V2Todos = {
    create,
    findMany,
    changeStatus,
    deleteTodo,
    listTodo,
    updateTodo
}

module.exports = V2Todos;