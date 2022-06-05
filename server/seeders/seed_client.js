const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

const clients = [
    {

        "name": "7seas cottages"
    },
    {

        "name": "abia villa"
    },
    {

        "name": "arma"
    },
    {

        "name": "balitaman lovina 1"
    },
    {

        "name": "bebek bts"
    },
    {

        "name": "belair"
    },
    {

        "name": "kampoeng villa"
    },
    {

        "name": "ko ko mo gili"
    },
    {

        "name": "kurakura resort"
    },
    {

        "name": "mahagiri sanur"
    },
    {

        "name": "mantadive air"
    },
    {

        "name": "natya hotel"
    },
    {

        "name": "nau villa"
    },
    {

        "name": "pesona resort"
    },
    {

        "name": "pink coco logo bali"
    },
    {

        "name": "restu bali hotel"
    },
    {

        "name": "the beach house resort"
    },
    {

        "name": "the visala hotel"
    },
    {

        "name": "ubud hotel malang"
    },
    {

        "name": "ubud padi villas"
    },
    {

        "name": "villa unggul gili"
    },
    {

        "name": "alchemist"
    },
    {

        "name": "black canyon coffee"
    },
    {

        "name": "lajoya"
    },
    {

        "name": "coco"
    },
    {

        "name": "tropical group"
    },
    {

        "name": "gotix cake"
    },
    {

        "name": "black penny"
    },
    {

        "name": "cp lounge logo"
    },
    {

        "name": "malias"
    },
    {

        "name": "logo purimas"
    },
    {

        "name": "mina pelasa putih"
    },
    {

        "name": "mina tanjung hotel fix 1024x663"
    },
    {

        "name": "white key"
    },
    {

        "name": "suka presto"
    },
    {

        "name": "yakama"
    },
    {

        "name": "relax"
    },
    {

        "name": "alam sari"
    },
    {

        "name": "medewi"
    },
    {

        "name": "aleva"
    },
    {

        "name": "danoya"
    },
    {

        "name": "gili eco villas"
    },
    {

        "name": "prada group"
    },
    {

        "name": "sendok"
    }
]

const SeedClient = async () => {
    var id = 1;
    for (let client of clients) {
        await prisma.clients.upsert({
            where: {
                id: id.toString()
            },
            update: {
                name: client.name
            },
            create: {
                id: id.toString(),
                name: client.name
            }
        })
        id++;
    }

    console.log("seed client success")
}

module.exports = { SeedClient }
