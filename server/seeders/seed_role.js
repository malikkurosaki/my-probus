const {PrismaClient} = require('@prisma/client');
const prisma = new PrismaClient();

const roles = [
    {
        id: "1",
        name: "admin",
        description: "Administrator"
    },
    {
        id: "2",
        name: "user",
        description: "User"
    },
    {
        id: "3",
        name: "guest",
        description: "Guest"
    },
    {
        id: "4",
        name: "superadmin",
        description: "Super Administrator"

    },
    {
        id: "5",
        name: "superuser",
        description: "Super User"

    }
]

const SeedRole = async () => {
    for(let rol of roles){
        await prisma.roles.upsert({
            where: {
                id: rol.id
            },
            update: {
                name: rol.name,
                description: rol.description
            },
            create: {
                id: rol.id,
                name: rol.name,
                description: rol.description
            }
        })
    }

    console.log("Seed Role Success");
}

module.exports = {SeedRole}

