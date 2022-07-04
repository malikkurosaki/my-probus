const PrismaClient = require("@prisma/client").PrismaClient;
const prisma = new PrismaClient();
const json2Dart = require("json2dart");
const fs = require("fs");
const path = require("path");
const beautify = require("js-beautify");


const generateModelExtend = async () => {
    const user = await prisma.users.findFirst({
        select: {
            id: true,
            name: true,
            Role: {
                select: {
                    id: true,
                    name: true
                }
            }
        }
    })

    let result = json2Dart(user, "User");
    fs.writeFileSync(path.join(__dirname, "./../../../client/lib/v2/v2_models/v2_user_model.dart"), beautify(result, { indent_size: 2 }));

    console.log("client/lib/v2/v2_models/ is updated".yellow);

    
}

module.exports = generateModelExtend;