const {PrismaClient} = require('@prisma/client')
const prisma = new PrismaClient()
const expressAsynchandler = require('express-async-handler');
const routeIssuePriority = require('express').Router();


const IssuePriorityGet = expressAsynchandler(async (req, res) => {
    const issuePriority = await prisma.issuePriorities.findMany();
    res.status(200).json({
        data: issuePriority
    });
})

routeIssuePriority.get('/', IssuePriorityGet);

module.exports = { routeIssuePriority }
