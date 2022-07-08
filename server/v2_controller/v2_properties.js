const PrismaClient = require("@prisma/client").PrismaClient;
const prisma = new PrismaClient();
const expressAsyncHandler = require("express-async-handler");
const _ = require("lodash");


const all = expressAsyncHandler(async (req, res) => {
    const typenya = await prisma.issueTypes.findMany({});
    const statusnya = await prisma.issueStatuses.findMany({});
    const assignernya = await prisma.users.findMany({});
    const departementnya = await prisma.departements.findMany({});
    const rolesnya = await prisma.roles.findMany({});
    const productsnya = await prisma.products.findMany({});
    const clientsnya = await prisma.clients.findMany({});

    res.status(200).json({
        issueTypes: typenya,
        issueStatuses: statusnya,
        users: assignernya,
        departements: departementnya,
        roles: rolesnya,
        products: productsnya,
        clients: clientsnya,
    });
});

const V2Properties = {
    all,
}

module.exports = V2Properties;