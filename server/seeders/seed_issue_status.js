const {PrismaClient} = require('@prisma/client');
const prisma = new PrismaClient();

const issueStatuses = ["open", "in progress", "resolved", "closed"];
//     {
//         id: "1",
//         name: "pending"
//     },
//     {
//         id: "2",
//         name: "rejected"
//     },
//     {
//         id: "3",
//         name: "ongoing"
//     }
// ]

const SeedIssueStatus = async () => {
    let id = 1;
    for (let issueStatus of issueStatuses) {
        await prisma.issueStatuses.upsert({
            where: {
                id: id.toString()
            },
            update: {
                name: issueStatus,
            },
            create: {
                id: id.toString(),
                name: issueStatus,
            }
        })
        id++;
    }

    console.log("seed issue status success")
}

module.exports = { SeedIssueStatus }
