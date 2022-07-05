const csvFilePath = "./backup/issues.csv";
const csv = require("csvtojson");
const PrismaClient = require('@prisma/client').PrismaClient
const prisma = new PrismaClient();


let idx = 1;
csv()
  .fromFile(csvFilePath)
  .then(async (json) => {
    await prisma.issues.deleteMany({
        where: {
            id: {
                not: undefined
            }
        }
    })

    for( let d of json){
        await prisma.issues.create({
          data: {
            idx: idx,
            name: d.name,
            des: d.des,
            issueTypesId: d.issueTypesId,
            issueStatusesId: d.issueStatusesId,
            clientsId: d.clientsId,
            productsId: d.productsId,
            usersId: d.usersId,
            departementsId: d.departementsId,
            dateSubmit: new Date(Date.parse("2022-06-27T00:00:00.000Z")),
          },
        });

        idx++;
    }

    console.log("berhasil")
  });
