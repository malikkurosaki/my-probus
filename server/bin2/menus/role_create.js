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

prompts({
    type: "text",
    name: "role",
    message: "nama role baru".cyan
}).then(({ role }) => {
    if(role == undefined) {
        console.log('kosong dipilihnya'.red)
        return
    }

    console.log('akan dibuatkan nanti'.cyan)
})