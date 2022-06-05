const {PrismaClient} = require('@prisma/client');
const prisma = new PrismaClient();

const departements = [
    {
        id: "1",
        name: "operational"
    },
    {
        id: "2",
        name: "trainer"
    },
    {
        id: "3",
        name: "customer service"
    },
    {
        id: "4",
        name: "umum"
    },
    {
        id: "5",
        name: "office"
    },
    {
        id: "6",
        name: "production"
    }
]

const SeedDepartement = async () => {
    for(let departement of departements){
        await prisma.departements.upsert({
            where: {
                id: departement.id
            },
            update: {
                name: departement.name
            },
            create: {
                id: departement.id,
                name: departement.id
            }
        })
    }

    console.log("seed sdepartement success")
}

module.exports = {SeedDepartement}

module.exports = {SeedDepartement}
