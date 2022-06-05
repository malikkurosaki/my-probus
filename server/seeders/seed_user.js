const {PrismaClient} = require('@prisma/client');
const prisma = new PrismaClient();

const users = [
    {
        id: "1",
        name: "ayu",
        email: "ayu@gmail.com",
        password: "123456"
    },
    {
        id: "2",
        name: "ahmad",
        email: "ahmad@gmail.com",
        password: "123456"
    },
    {
        id: "3",
        name: "guntur",
        email: "guntur@gmail.com",
        password: "123456"
    },
    {
        id: "4",
        name: "dewi",
        email: "dewi@gmail.com",
        password: "123456"
    }
]

const SeedUser = async () => {
    for (let user of users){
        await prisma.users.upsert({
            where: {
                id: user.id
            },
            update: {
                name: user.name,
                email: user.email,
                password: user.password
            },
            create: {
                id: user.id,
                email: user.email,
                password: user.password,
                name: user.name
            }
            
        })
    }

    console.log("seed user success")
}


module.exports = {SeedUser}