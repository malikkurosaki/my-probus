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

let tablesName = Object.keys(prisma).map(e => {
    return {
        name: e
    }
}).filter(e => !e.name.includes('_'));

prompts({
    type: "select",
    name: "table",
    message: "pilih table",
    choices: tablesName.map(e => {
        return {
            title: e.name,
            value: e.name
        }
    })
}).then(({ table }) => {
    if (table == undefined) {
        console.log('tidak terpilih'.red)
        return
    }

    prisma[table].findMany().then(e => cLog.table(e))
})