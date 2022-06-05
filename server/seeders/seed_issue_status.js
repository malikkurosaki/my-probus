const {PrismaClient} = require('@prisma/client');
const prisma = new PrismaClient();

const issueStatus = [
    {
        id: "1",
        name: "pending"
    },
    {
        id: "2",
        name: "rejected"
    },
    {
        id: "3",
        name: ""
    }
]
