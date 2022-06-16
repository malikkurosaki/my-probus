const fs = require('fs');
const path = require('path');
const {PrismaClient} = require('@prisma/client');
const prisma = new PrismaClient();

let cls = `
class UserRole{
  late String name;
  late String id;

  UserRole.admin(){
    name = "Admin";
    id = "1";
  }
}
`;

let ClientComponent = async () => {
    const roles = await prisma.roles.findMany({
        select: {
            id: true,
            name: true
        }
    });

    let con = ''
    for(let item of roles){
        con += `
        UserRole.${item.name}(){
            name = "${item.name}";
            id = "${item.id}";
        }
        `
    }

    fs.writeFileSync(path.join(__dirname, "./../../client/lib/components/status.dart"), con);
}

module.exports = {ClientComponent}