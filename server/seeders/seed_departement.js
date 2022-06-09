const {PrismaClient} = require('@prisma/client');
const prisma = new PrismaClient();

const departements = ["IT", "HR", "Finance", "Marketing", "Sales", "Production", "Admin", "Accounting", "Customer Service", "Sales", "Front Office"]
//     {
//         id: "1",
//         name: "fo"
//     },
//     {
//         id: "2",
//         name: "acc"
//     },
//     {
//         id: "3",
//         name: "it"
//     },
//     {
//         id: "4",
//         name: "umum"
//     },
//     {
//         id: "5",
//         name: "office"
//     },
//     {
//         id: "6",
//         name: "production"
//     }
// ]

const SeedDepartement = async () => {
    let id = 1;
    for(let departement of departements){
        await prisma.departements.upsert({
            where: {
                id: id.toString()
            },
            update: {
                name: departement,
            },
            create: {
                id: id.toString(),
                name: departement,
            }
        })
    }

    console.log("seed sdepartement success")
}

module.exports = {SeedDepartement}

