const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

const products = [
    {
        id: "1",
        name: "phis",
    },
    {
        id: "2",
        name: "presto",
    },
    {
        id: "3",
        name: "ppe",
    },
    {
        id: "4",
        name: "ppos"
    },
]

const SeedProduct = async () => {
    for (let product of products) {
        await prisma.products.upsert({
            where: {
                id: product.id
            },
            update: {
                name: product.name
            },
            create: {
                id: product.id,
                name: product.name
            }
        })
    }

    console.log("seed product success")
}


module.exports = { SeedProduct }