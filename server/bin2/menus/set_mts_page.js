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

const reff = require('./../reff.json');


const templateTrue = 
`
class Mts{
  static const bool isMts = true;
}
`

const templateFalse = 
`
class Mts{
  static const bool isMts = false;
}
`

const targetPath = path.join(__dirname, './../../../client/lib/mts.dart')

prompts({
    type: "toggle",
    name: "mts",
    message: "pilih setting mts",
    initial: reff.mts,
}).then(({ mts }) => {
    if(mts == undefined) return console.log("ok".red)

    reff.mts = mts;
    fs.writeFileSync(path.join(__dirname, './../reff.json'), JSON.stringify(reff), {encoding: "utf-8"})

    if(mts){
        fs.writeFileSync(targetPath, templateTrue, {encoding: "utf-8"});
        console.log("set "+ mts)
    }else{
        fs.writeFileSync(targetPath, templateFalse, {encoding: "utf-8"});
        console.log("set "+ mts)
    }
    console.log("berhasil ".green)
})