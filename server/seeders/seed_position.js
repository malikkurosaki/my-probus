const {PrismaClient} = require('@prisma/client')
const prisma = new PrismaClient();

const positions = ["helper", "trainer", "customer service", "admin", "programer", "leader", "manager", "director"]
//     {
//         id: "1",
//         name: "helper"
//     },
//     {
//         id: "2",
//         name: "trainer"
//     },
//     {
//         id: "2",
//         name: "customer service"
//     },
//     {
//         id: "3",
//         name: "admin"
//     },
//     {
//         id: "4",
//         name: "it"
//     },
//     {
//         id: "5",
//         name: "programer"
//     },
//     {
//         id: "6",
//         name: "leader trainer"
//     },
//     {
//         id: "7",
//         name: "leader customer service"
//     },
//     {
//         id: "8",
//         name: "leader it"
//     },
//     {
//         id: "9",
//         name: "leader programer"
//     },
//     {
//         id: "10",
//         name: "manager production"
//     },
//     {
//         id: "11",
//         name: "manager"
//     },
//     {
//         id: "13",
//         name: "director"
//     }
// ]

const SeedPosition = async () => {
    let id = 1;
    for(let position of positions){
        await prisma.positions.upsert({
            where: {
                id: id.toString()
            },
            update: {
                name: position,
            },
            create: {
                id: id.toString(),
                name: position,
            }
        })

        id++;
    }

    console.log("seed position success")
}

module.exports = {SeedPosition}