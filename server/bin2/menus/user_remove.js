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


prisma.users.findMany().then(users => {
    prompts({
        type: "multiselect",
        name: "users",
        message: "Select users yang akan dai hapus",
        choices: users.map(user => {
            return {
                title: user.name,
                value: user.id
            }
        })
    }).then(async ({ users }) => {
        if (users == undefined || _.isEmpty(users)) {
            console.log("No user selected".red);
            return;
        }

        users.forEach(async user => {
            await prisma.users.delete({
                where: {
                    id: user
                }
            });
        })

        const listUser = await prisma.users.findMany();
        cLog.table(listUser.map(e => {
            return {
                name: e.name
            }
        }))

        console.log("User removed".green);

    })
})

