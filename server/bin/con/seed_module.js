const PrismaClient = require('@prisma/client').PrismaClient;
const prisma = new PrismaClient();


const mdl = ["fo/pos"," bo", "web" , "it", "ecomers"]

const deleteInser = async () => {
    await prisma.departements.deleteMany({
        where: {
            id: {
                not: "0"
            }
        }
    });

    const data = mdl.map(e => {
        return {
          id: `${mdl.indexOf(e) + 1}`,
          name: e,
        };
    })

    await prisma.departements.createMany({data});

    console.log("seed module done")
};


const SeedModule = {
    deleteInser,
}

module.exports = SeedModule;