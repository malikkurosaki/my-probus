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

prisma.users.findMany({
    select: {
        id: true,
        name: true,
        email: true
    }
}).then(users => {

    prompts({
        type: 'select',
        name: 'user',
        message: 'Select user',
        choices: users.map(user => ({
            title: user.name,
            value: user,
        }))
    }).then(({ user }) => {
        if (user == null || user == undefined) {
            cLog.error('pilih usernya yang mau diupdate');
            return;
        }

        prompts([{
            type: "text",
            name: "name",
            initial: user.name,
            message: "ketik name"
        }, {
            type: "text",
            name: "email",
            initial: user.email,
            message: "ketik email"
        }]).then((data) => {
            prisma.users.update({
                where: {
                    id: user.id
                },
                data: {
                    name: data.name ?? undefined,
                    email: data.email ?? undefined
                }
            }).then(e => {
                cLog.table([e])
            })
        })
    })

});