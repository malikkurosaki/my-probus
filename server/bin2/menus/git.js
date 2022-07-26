#!/usr/bin/env node

const prompts = require('prompts');
const fs = require('fs');
const path = require('path');
const execSync = require('child_process').execSync;
const _ = require('lodash');
const beautify = require('js-beautify').js_beautify;
const colors = require('colors');
const PrismaClient = require('@prisma/client').PrismaClient;
const prisma = new PrismaClient();
const cLog = require('c-log');
const { exec } = require('child_process');



async function push() {
    // let nama = execSync(`git add . && git commit -m "ya" && git push origin main `, { stdio: 'inherit', cwd: path.join(__dirname, './../../../') })


    let branch = await new Promise((resolve, reject) => {

        let ini = exec('git branch');
        ini.stdout.on('data', (data) => {
            let b= `${data}`.match(/\*\s(.*)/)[1]
            resolve(b)
        });
    })

    execSync(`git add . && git commit -m "ya" && git push origin ${branch}`, { stdio: 'inherit', cwd: path.join(__dirname, './../../../') })

}

const lsMenu = [{
    name: "push",
    action: push
}]

prompts({
    type: "select",
    name: "menu",
    message: "pilih menu git",
    choices: lsMenu.map(e => {
        return {
            title: e.name,
            value: e
        }
    })
}).then(({ menu }) => {

    if (menu == undefined) {
        console.log('tidak terpilih'.red)
        return
    }

    menu.action()

})