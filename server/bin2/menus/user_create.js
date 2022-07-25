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


prompts([
    {
        type: 'text',
        name: "name",
        message: "Enter name"
    },
    {
        type: 'text',
        name: "email",
        message: "Enter email"

    },
    {
        type: 'text',
        name: "password",
        message: "Enter password"
    }
]).then(async ({ name, email, password }) => {
    if (email == undefined || email == "" || password == undefined || password == "") {
        console.log("No email or password entered".red);
        return;
    }

    const user = await prisma.users.create({
        data: {
            name: name,
            email: email,
            password: password
        }
    });

    cLog.table([user]);
    console.log("User created".green);
});
