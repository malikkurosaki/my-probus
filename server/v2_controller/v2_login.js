const expressAsyncHandler = require('express-async-handler');
const {PrismaClient} = require('@prisma/client');
const prisma = new PrismaClient();

const V2Login = expressAsyncHandler(async (req, res) => {
    const {email, password} = req.body;
    const user = await prisma.users.findFirst({
        where: {
        email,
        password,
        },
    });

    if (!user) {
        throw new Error('Invalid credentials');
    }
    res.json(user);
})

module.exports = V2Login;
