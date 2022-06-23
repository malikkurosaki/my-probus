#!/usr/bin/env node

const execSync = require("child_process").execSync;
const path = require("path");
const prompts = require("prompts");
const Generator = require("./generator");
const ModelGenerator = require("./model_genertor");
const {
    SetMode
} = require("./set_mode");
const SSH = require("simple-ssh");

// function BashSync(cmd, cwd) {
//     return new Promise((resolve, reject) => {
//         try {
//             execSync(`flutter build web --release`, {
//                 stdio: "inherit",
//                 cwd: path.join(__dirname, "../../client"),
//             }, );
//             resolve();
//         } catch (error) {
//             reject(error);
//         }
//     })
// }


// Generator()

ModelGenerator({
    generate: Generator,
    runClientDebug: RunClientDebug,
    runServerDebug: RunServerDebug,
    serverCommand: ServerCommand,
    clientCommand: ClientCommand,
    buildRelease: BuildRelease
})

async function BuildRelease() {

    await new Promise((resolve, reject) => {
        try {
            SetMode("pro_web")
            console.log("Mode berhasil diubah");
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
            console.log("Client web berhasil dibuild");
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
            console.log("Client apk berhasil dibuild");
            resolve()
        } catch (error) {
            reject()
        }
    })

    // await BashSync('flutter build apk --release --split-per-abi', path.join(__dirname, "../../client"));
    // console.log("Build Release apk Success");

    await new Promise((resolve, reject) => {
        try {
            execSync(`cp ${path.join(__dirname, "../../client/build/app/outputs/apk/release/app-arm64-v8a-release.apk")} ${path.join(__dirname, './../../server/assets/apk/my_probus_apk')} `, {
                stdio: "inherit"
            });
            console.log("Client apk berhasil di copy");
            resolve()
        } catch (error) {
            reject()
        }
    })

    // await BashSync(`cp ${path.join(__dirname, "../../client/build/app/outputs/apk/release/app-arm64-v8a-release.apk")} ${path.join(__dirname, './../../server/assets/apk/my_probus_apk')} `, path.join(__dirname, "../../"));
    // console.log("Copy apk Success");

    await new Promise((resolve, reject) => {
        try {
            execSync(`git add . && git commit -m "ya" && git push`, {
                stdio: "inherit"
            });
            console.log("Git push Success");
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
                message: "masukkan passwordnya"
            }).then(({
                pass
            }) => {
                new SSH({
                    host: "makurostudio.my.id",
                    user: "makuro",
                    pass: pass
                }).exec(`source ~/.nvm/nvm.sh && cd my-probus && git pull && pm2 restart all && pm2 save`, {
                    out: (data) => console.log(data)
                }).start();

                console.log("Restart Server Success");
            })
            console.log("Restart Server Success");
            resolve();
        } catch (error) {
            reject(error);
        }
    })


    // SetMode("dev_web")

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