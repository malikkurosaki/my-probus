// const Generator = require('./generator');
const execSync = require("child_process").execSync;
const _ = require("lodash");
const path = require("path");
const _server = path.join(__dirname, "../../server");
const _client = path.join(__dirname, "../../client");
const prompts = require("prompts");
const { SeedClient } = require("../seeders/seed_client");
const { SetMode } = require("./set_mode");
const fs = require("fs");
const SSH = require("simple-ssh");
const papaparse = require("papaparse");
const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();
const exios = require("axios").default;
const csvtojson = require("csvtojson");
const jsBeautify = require("js-beautify");

function ssh(pass, command) {
    return new SSH({
        host: "makurostudio.my.id",
        user: "makuro",
        pass: pass,
    }).exec(`source ~/.nvm/nvm.sh && cd my-probus && ${command}`, {
        out: (data) => console.log(`${data}`.green),
    }).start()
}

function bashServer(command){
    return execSync(command, {
        stdio: "inherit",
        cwd: _server,
    });
}

function bashClient(command){
    return execSync(command, {
        stdio: "inherit",
        cwd: _client,
    });
}

function bashRoot(command){
    return execSync(command, {
        stdio: "inherit",
        cwd: path.join(__dirname, "../../"),
    });
}

class Controll {
  async v2UserRoleGenerate() {
    let role = await prisma.roles.findMany();
    console.log(role);
  }
  async generateImage() {
    // image dir server
    const targetPath = path.join(__dirname, "../../server/assets/images");
    const resultPath = path.join(
      __dirname,
      "../../client/lib/v2/v2_image_widget.dart"
    );
    const listImage = fs.readdirSync(targetPath);

    let items = listImage.map((itm) => {
      let url = '"${V2Config.host}/images/' + itm + '"';
      return `
            static Widget ${_.camelCase(
              itm.split(".")[0]
            )}({double? height}) => CachedNetworkImage(
                    height: height,
                    imageUrl: ${url},
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                    filterQuality: FilterQuality.low,
                    memCacheHeight: 100,
                    memCacheWidth: 100,
                );
            `;
    });

    let template = `
        import 'package:cached_network_image/cached_network_image.dart';
        import 'package:flutter/material.dart';
        import 'package:my_probus/v2/v2_config.dart';

        class V2ImageWidget {
            ${items.join("\n")}
        }
        `;

    fs.writeFileSync(resultPath, template);
    execSync(`dart format ${resultPath}`, {
      stdio: "inherit",
    });
    console.log("generate image widget success");
  }

  async updateLocal() {
    const {pass} = await prompts({
        type: "password",
        name: "pass",
        message: "Enter your password",
    })

    ssh(pass, `ls`);
    

  }

  async updateLocal_bak() {
    const dir = fs.readdirSync(path.join(__dirname, "../backup"));
    let fileConfig = fs
      .readFileSync(path.join(__dirname, "./backup_config.js"))
      .toString();
    const namas = [];

    if (!fileConfig.includes("@prisma/client")) {
      fileConfig =
        `
        const {
        PrismaClient
        } = require("@prisma/client");
        const prisma = new PrismaClient();
        const fs = require("fs");
        const csvtojson = require("csvtojson");
        const path = require("path");
        const _ = require("lodash");
      ` + fileConfig;
    }

    for (let itm of dir) {
      await prisma[itm.replace(".csv", "")].deleteMany({
        where: {
          id: {
            not: undefined,
          },
        },
      });

      if (!fileConfig.includes("Update" + itm.replace(".csv", ""))) {
        namas.push("await Update" + itm.replace(".csv", "") + "()");
        
        fileConfig = fileConfig + `
        async function Update${itm.replace(".csv", "")}() {
            let dataTarget = fs.readFileSync(path.join(__dirname, "../backup/${itm}")).toString();
            const data = await csvtojson().fromString(dataTarget);

            for (let itm of data) {
                let ky = Object.keys(itm);
                    for (let i of ky) {
                    if (_.isEmpty(itm[i])) {
                        itm[i] = undefined;
                    }

                    if(_.isNumber(itm[i])){
                        itm[i] = Number(itm[i]);
                    }
                }
                await prisma.${itm.replace(".csv", "")}.create({
                    data: itm
                });
            }

            console.log("${itm.replace(".csv", "")} success");
        }
        `;

        
      }
    }

    console.log("delete success");

    fileConfig = fileConfig + "\n ;(async() => { " + namas.join("\n") + " })();";

    // let template = ``;
    // if (fileConfig.includes("module.exports")) {
    //   template = `module.exports = { ${namas.join(", ")} `;
    //   fileConfig = fileConfig.replace("module.exports = {", template);
    // } else {
    //   template = `module.exports = { ${namas.join(", ")} };`;
    //   fileConfig += template;
    // }

    fs.writeFileSync(
      path.join(__dirname, "./backup_config.js"),
      jsBeautify(fileConfig, { indent_size: 2 })
    );
        let ini = "1";
        console.log(_.isNumber(ini));
    execSync(`node ./backup_config.js`, { stdio: "inherit", cwd: __dirname });
  }

  async backupCsv() {
    let bak = await exios.get("http://103.171.85.55:3001/master/backup");

    for (let itm of Object.keys(bak.data.data)) {
      fs.writeFileSync(
        path.join(__dirname, `./../backup/${itm}.csv`),
        papaparse.unparse(bak.data.data[itm])
      );
    }
    console.log("backup success");
  }
  async gitClearCached() {
    execSync(`git rm -r --cached .`, {
      stdio: "inherit",
      cwd: path.join(__dirname, "../../"),
    });
  }

  async prismaGenerate() {
    execSync(`npx prisma generate`, {
      stdio: "inherit",
      cwd: _server,
    });
  }
  async seeders() {
    execSync(`node seed.js`, {
      stdio: "inherit",
      cwd: path.join(__dirname, "../../server/seeders/"),
    });
  }

  async gitPush(){
    const {branch} = await prompts({
        type: "text",
        name: "branch",
        message: "select branch",
    })

    console.log(branch);
    bashRoot(`git add . && git commit -m "ya" && git push`);
    
  }

  async gitPushServer() {
    execSync(`git add . && git commit -m "ya" && git push`, {
      stdio: "inherit",
      cwd: path.join(__dirname, "../../"),
    });
    console.log("Git push Success".yellow);

    prompts({
      type: "password",
      name: "pass",
      message: "masukkan passwordnya".blue,
    }).then(async ({ pass }) => {
      new SSH({
        host: "makurostudio.my.id",
        user: "makuro",
        pass: pass,
      })
        .exec(
          `source ~/.nvm/nvm.sh && cd my-probus && git pull && cd server && npm install && pm2 restart all && pm2 save`,
          {
            out: (data) => console.log(`${data}`.green),
          }
        )
        .start();

      console.log("Git push Success".yellow);
    });
  }

  async generate() {
    const Generator = require("./generator");
    Generator();
  }

  async prismaMigrate() {
    execSync(`npx prisma migrate dev --name "apa"`, {
      stdio: "inherit",
      cwd: _server,
    });
  }

  async seedClient() {
    await SeedClient();
  }

  async exportUser() {
    const json2csv = require("json2csv").parse;
    const fs = require("fs");
    const user = await prisma.users.findMany();
    const csv = json2csv(user);

    fs.writeFileSync(path.join(__dirname, "./../exports/user.csv"), csv);
    console.log("export success");
  }

  async nodejsInstallPackage() {
    /** @type {[]} */
    const nodePkg = require(path.join(__dirname, "./pkg.json")).nodeJs;

    execSync(`npm install ${nodePkg.join(" ")}`, {
      stdio: "inherit",
      cwd: path.join(__dirname, "../../server"),
    });

    console.log("nodejs install success");
  }

  async modeDev() {
    SetMode("dev_web");
  }

  async modePro() {
    SetMode("pro_web");
  }

  async modeMobile() {
    SetMode("dev_mobile");
  }

  async clearIssue() {
    const hapus = await prisma.issues.deleteMany({
      where: {
        idx: {
          gt: 0,
        },
      },
    });

    console.log(hapus, "berhasil dihapus");
  }

  async buildRelease() {
    await new Promise((resolve, reject) => {
      try {
        SetMode("pro_web");
        console.log("Mode berhasil diubah web production".yellow);
        resolve();
      } catch (error) {
        reject(error);
      }
    });

    await new Promise((resolve, reject) => {
      try {
        execSync(`flutter build web --release`, {
          stdio: "inherit",
          cwd: path.join(__dirname, "../../client"),
        });
        console.log("Client web berhasil dibuild".yellow);
        resolve();
      } catch (error) {
        reject(error);
      }
    });

    await new Promise((resolve, reject) => {
      try {
        execSync(
          `cd ${path.join(
            __dirname,
            "../../client"
          )} && flutter build apk --release --split-per-abi`,
          {
            stdio: "inherit",
          }
        );
        console.log("Client apk berhasil dibuild".yellow);
        resolve();
      } catch (error) {
        reject();
      }
    });

    await new Promise((resolve, reject) => {
      try {
        execSync(`git add . && git commit -m "ya" && git push`, {
          stdio: "inherit",
          cwd: path.join(__dirname, "../../"),
        });
        console.log("Git push Success".yellow);
        resolve();
      } catch (error) {
        reject();
      }
    });

    await new Promise((resolve, reject) => {
      try {
        prompts({
          type: "password",
          name: "pass",
          message: "masukkan passwordnya".blue,
        }).then(async ({ pass }) => {
          await new Promise((resolve, reject) => {
            try {
              new SSH({
                host: "makurostudio.my.id",
                user: "makuro",
                pass: pass,
              })
                .exec(
                  `source ~/.nvm/nvm.sh && cd my-probus && git pull && cd server && npm install && pm2 restart all && pm2 save`,
                  {
                    out: (data) => console.log(`${data}`),
                  }
                )
                .start();
              console.log("Server berhasil di restart".yellow);
              resolve();
            } catch (error) {
              reject(error);
            }
          });
        });
      } catch (error) {
        reject(error);
      }
    });

    await new Promise((resolve, reject) => {
      try {
        SetMode("dev_web");
        resolve();
      } catch (error) {
        reject(error);
      }
    });

    console.log("build release success");
  }

  async serverCommand() {
    prompts({
      type: "text",
      name: "command",
      message: "Server Command",
    }).then(({ command }) => {
      execSync(`cd ${path.join(__dirname, "../../server")} && ${command}`, {
        stdio: "inherit",
      });
    });
  }

  async clientCommand() {
    prompts({
      type: "text",
      name: "command",
      message: "Client Command",
    }).then(({ command }) => {
      execSync(`cd ${path.join(__dirname, "../../client")} && ${command}`, {
        stdio: "inherit",
      });
    });
  }

  async runClientDebug() {
    execSync(
      `cd ${path.join(__dirname, "../../client")} && flutter run -d chrome`,
      {
        stdio: "inherit",
      }
    );
  }

  async runServerDebug() {
    execSync(`cd ${path.join(__dirname, "../../server")} && npx nodemon .`, {
      stdio: "inherit",
    });
  }
}

module.exports = Controll;
