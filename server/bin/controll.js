// const Generator = require('./generator');
const execSync = require('child_process').execSync;
const path = require('path');
const _server = path.join(__dirname, '../../server');
const _client = path.join(__dirname, '../../client');
const prompts = require('prompts');
const { SeedClient } = require('../seeders/seed_client');
const { SetMode } = require('./set_mode');
const fs = require('fs');
const SSH = require('simple-ssh');

class Controll {
    async seeders() {
        execSync(`node seed.js`, {
            stdio: "inherit",
            cwd: path.join(__dirname, "../../server/seeders/")
        })
    }

    async gitPush() {
        execSync(`git add . && git commit -m "ya" && git push`, {
            stdio: "inherit",
            cwd: path.join(__dirname, "../../")
        });
    }

    async generate() {
        const Generator = require('./generator');
        Generator();
    }

    async prismaMigrate() {
        execSync(`prisma migrate dev --name "apa"`, {
            stdio: "inherit",
            cwd: _server
        })
    }

    async seedClient() {
        await SeedClient();

    }

    async exportUser() {
        const json2csv = require('json2csv').parse;
        const fs = require('fs');
        const user = await prisma.users.findMany();
        const csv = json2csv(user);

        fs.writeFileSync(path.join(__dirname, './../exports/user.csv'), csv);
        console.log("export success")
    }

    async nodejsInstallPackage() {
        /** @type {[]} */
        const nodePkg = require(path.join(__dirname, './pkg.json')).nodeJs;

        execSync(`npm install ${nodePkg.join(' ')}`, {
            stdio: "inherit",
            cwd: path.join(__dirname, "../../server")
        });

        console.log("nodejs install success")
    }


    async modeDev() {
        SetMode("dev_web")
    }

    async modePro() {
        SetMode("pro_web")
    }

    async modeMobile() {
        SetMode("dev_mobile")
    }


    async clearIssue() {

        const hapus = await prisma.issues.deleteMany({
            where: {
                idx: {
                    gt: 0
                }
            }
        })

        console.log(hapus, "berhasil dihapus")
    }

    async buildRelease() {

        await new Promise((resolve, reject) => {
            try {
                SetMode("pro_web")
                console.log("Mode berhasil diubah web production".yellow);
                resolve();
            } catch (error) {
                reject(error);
            }
        })

        await new Promise((resolve, reject) => {
            try {
                execSync(`flutter build web --release`, {
                    stdio: "inherit",
                    cwd: path.join(__dirname, "../../client"),
                }, );
                console.log("Client web berhasil dibuild".yellow);
                resolve();
            } catch (error) {
                reject(error);
            }
        })

        await new Promise((resolve, reject) => {
            try {
                execSync(`cd ${path.join(__dirname, "../../client")} && flutter build apk --release --split-per-abi`, {
                    stdio: "inherit"
                });
                console.log("Client apk berhasil dibuild".yellow);
                resolve()
            } catch (error) {
                reject()
            }
        })

        await new Promise((resolve, reject) => {
            try {
                execSync(`git add . && git commit -m "ya" && git push`, {
                    stdio: "inherit",
                    cwd: path.join(__dirname, "../../")
                });
                console.log("Git push Success".yellow);
                resolve()
            } catch (error) {
                reject()
            }
        })

        await new Promise((resolve, reject) => {
            try {
                prompts({
                    type: "password",
                    name: "pass",
                    message: "masukkan passwordnya".blue
                }).then(async ({
                    pass
                }) => {

                    await new Promise((resolve, reject) => {
                        try {
                            new SSH({
                                host: "makurostudio.my.id",
                                user: "makuro",
                                pass: pass
                            }).exec(`source ~/.nvm/nvm.sh && cd my-probus && git pull && cd server && npm install && pm2 restart all && pm2 save`, {
                                out: (data) => console.log(`${data}`)
                            }).start();
                            console.log("Server berhasil di restart".yellow);
                            resolve()
                        } catch (error) {
                            reject(error);
                        }
                    })

                })

            } catch (error) {
                reject(error);
            }
        })

        await new Promise((resolve, reject) => {
            try {
                SetMode("dev_web")
                console.log("Mode berhasil diubah web development".yellow);
                resolve();
            } catch (error) {
                reject(error);
            }
        })

        console.log("build release success")
    }

    async serverCommand() {
        prompts({
            type: "text",
            name: "command",
            message: "Server Command"
        }).then(({
            command
        }) => {
            execSync(`cd ${path.join(__dirname, "../../server")} && ${command}`, {
                stdio: "inherit"
            });
        })
    }

    async clientCommand() {
        prompts({
            type: "text",
            name: "command",
            message: "Client Command"
        }).then(({
            command
        }) => {
            execSync(`cd ${path.join(__dirname, "../../client")} && ${command}`, {
                stdio: "inherit"
            });
        })
    }

    async runClientDebug() {
        execSync(`cd ${path.join(__dirname, "../../client")} && flutter run -d chrome`, {
            stdio: "inherit"
        });
    }

    async runServerDebug() {
        execSync(`cd ${path.join(__dirname, "../../server")} && npx nodemon .`, {
            stdio: "inherit"
        });
    }

}

module.exports = Controll