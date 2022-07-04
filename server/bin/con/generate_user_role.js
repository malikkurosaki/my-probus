const path = require("path");
const fs = require("fs");

const PrismaClient = require("@prisma/client").PrismaClient;
const prisma = new PrismaClient();
const _ = require("lodash");
const jsBeautify = require("js-beautify");
const colors = require("colors");

const generateUserRoleExtend = async () => {
    let target = fs
      .readFileSync(
        path.join(__dirname, "./../../../client/lib/v2/v2_user_role.dart"),
        "utf8"
      )
      .toString();
    let roles = await prisma.roles.findMany({
        select: {
            id: true,
            name: true
        }
    })

    let a1 = [];
    roles.forEach((item) => {
        if (!target.includes(`${_.camelCase(item.name)}()`)) {
            a1.push(`V2UserRole.${_.camelCase(item.name)}(){
                id = '${item.id}';
                name = '${item.name}';
            }`);
        }
    })

    let [A1] = target.match(/\/\/.*a1.*/g);

    target = target.replace(A1, `${A1}\n${a1.join("\n")}`);

    if (_.isEmpty(a1)) {
        console.log("everithing is up to date");
        return;
    }

    fs.writeFileSync(path.join(__dirname, "./../../../client/lib/v2/v2_user_role.dart"), jsBeautify(target));
    console.log("client/lib/v2/v2_user_role.dart is updated".yellow);
}

module.exports = generateUserRoleExtend;