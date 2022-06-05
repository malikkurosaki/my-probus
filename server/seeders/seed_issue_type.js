const {PrismaClient} = require('@prisma/client');
const prisma = new PrismaClient()

const issueTypes = [
    {
        id: "1",
        name: "request"
    },
    {
        id: "2",
        name: "bugs"
    }
]

const SeedIssueType = async () => {
    for(let issueType of issueTypes){
        await prisma.issueTypes.upsert({
            where: {
                id: issueType.id
            },
            update: {
                name: issueType.name
            },
            create: {
                id: issueType.id,
                name: issueType.name
            }
        })
    }

    console.log('seed issue type success')
}

module.exports = {SeedIssueType}