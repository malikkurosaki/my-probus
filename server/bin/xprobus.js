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



// Generator()

ModelGenerator({
    generate: Generator,
    runClientDebug: RunClientDebug,
    runServerDebug: RunServerDebug,
    serverCommand: ServerCommand,
    clientCommand: ClientCommand,
    buildRelease: BuildRelease
})

function BuildRelease() {

    SetMode("pro_web")
    execSync(`cd ${path.join(__dirname, "../../client")} && flutter build web --release`, {
        stdio: "inherit"
    });
    execSync(`cd ${path.join(__dirname, "../../client")} && flutter build apk --release --split-per-abi`, {
        stdio: "inherit"
    });
    execSync(`cp ${path.join(__dirname, "../../client/build/app/outputs/apk/release/app-arm64-v8a-release.apk")} ${path.join(__dirname, './../../server/assets/apk/my_probus_apk')} `, {
        stdio: "inherit"
    });
    execSync(`git add . && git commit -m "ya" && git push`, {
        stdio: "inherit"
    });
    prompts({
        type: "text",
        name: "pass",
        message: "ssh to server"
    }).then(({
        pass
    }) => {
        new SSH({
            host: "makurostudio.my.id",
            user: "makuro",
            pass: pass
        }).exec(`source ~/.nvm/nvm.sh && cd my-probus && git pull && pm2 restart all`, {out: process.stdout}).start();
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