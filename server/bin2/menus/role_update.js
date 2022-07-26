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


prisma.roles.findMany().then(roles => {
    prompts({
        type: "select",
        name: "role",
        message: "pilih role yang akan diedit",
        choices: roles.map(x => {
            return {
                title: x.name,
                value: x
            }
        })
    }).then(({ role }) => {
        console.log(role)
    })
})