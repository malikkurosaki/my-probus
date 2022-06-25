#!/usr/bin/env node
// const {
//     PrismaClient
// } = require("@prisma/client")
// const prisma = new PrismaClient();
const execSync = require("child_process").execSync;
const path = require("path");
const prompts = require("prompts");
const Generator = require("./generator");
const ModelGenerator = require("./model_genertor");
const {
    SetMode
} = require("./set_mode");
const SSH = require("simple-ssh");
const colors = require("colors");
// const { SeedClient } = require("../seeders/seed_client");

ModelGenerator({
    generate: Generator,
    runClientDebug: RunClientDebug,
    runServerDebug: RunServerDebug,
    // serverCommand: ServerCommand,
    // clientCommand: ClientCommand,
    // buildRelease: BuildRelease,
    // clearIssue: clearIssue,
    modeDev: modeDev,
    modePro: modePro,
    modeMobile: modeMobile,
    // nodejsInstallPackage: nodejsInstallPackage,
    // exportUser: exportUser,
    // seedClient: seedClient
})

async function seedClient(){
    // await SeedClient();
    
}

async function exportUser(){
    const json2csv = require('json2csv').parse;
    const fs = require('fs');
    const user = await prisma.users.findMany();
    const csv = json2csv(user);

    fs.writeFileSync(path.join(__dirname, './../exports/user.csv'), csv);
    console.log("export success")
}

function nodejsInstallPackage(){
    /** @type {[]} */
    const nodePkg = require(path.join(__dirname, './pkg.json')).nodeJs;

    execSync(`npm install ${nodePkg.join(' ')}`, {
        stdio: "inherit",
        cwd: path.join(__dirname, "../../server")
    });

    console.log("nodejs install success")
}


function modeDev(){
    SetMode("dev_web")
}

function modePro(){
    SetMode("pro_web")
}

function modeMobile(){
    SetMode("dev_mobile")
}


async function clearIssue() {

    const hapus = await prisma.issues.deleteMany({
        where: {
            idx: {
                gt: 0
            }
        }
    })

    console.log(hapus, "berhasil dihapus")
}

async function BuildRelease() {

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

    // await BashSync('flutter build apk --release --split-per-abi', path.join(__dirname, "../../client"));
    // console.log("Build Release apk Success");

    // await new Promise((resolve, reject) => {
    //     try {
    //         execSync(`mv ${path.join(__dirname, "../../client/build/app/outputs/apk/release/app-arm64-v8a-release.apk")} ${path.join(__dirname, './../../server/assets/apk/my_probus_apk')} `, {
    //             stdio: "inherit"
    //         });
    //         console.log("Client apk berhasil di copy".yellow);
    //         resolve()
    //     } catch (error) {
    //         reject()
    //     }
    // })

    // await BashSync(`cp ${path.join(__dirname, "../../client/build/app/outputs/apk/release/app-arm64-v8a-release.apk")} ${path.join(__dirname, './../../server/assets/apk/my_probus_apk')} `, path.join(__dirname, "../../"));
    // console.log("Copy apk Success");

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

    // await BashSync('git add . && git commit -m "ya" && git push', path.join(__dirname, "./../../"));
    // console.log("Git Push Success");

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

                // resolve();
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

function ServerCommand() {
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

function ClientCommand() {
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

function RunClientDebug() {
    execSync(`cd ${path.join(__dirname, "../../client")} && flutter run -d chrome`, {
        stdio: "inherit"
    });
}

function RunServerDebug() {
    execSync(`cd ${path.join(__dirname, "../../server")} && npx nodemon .`, {
        stdio: "inherit"
    });
}