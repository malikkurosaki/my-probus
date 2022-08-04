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
const { Prisma } = require('@prisma/client');



let dbPreff = process.env.DATABASE_URL.match(/^mysql:\/\/([^:]+):([^@]+)@([^:]+):(\d+)\/(.+)$/).slice(1, 6).join(' ').split(' ');
let db = {
    user: dbPreff[0],
    password: dbPreff[1],
    host: dbPreff[2],
    port: dbPreff[3],
    database: dbPreff[4]
}

// mysql dump to dump.sql
execSync(`mysqldump -u ${db.user} -p${db.password} -h ${db.host} -P ${db.port} ${db.database} > myprobus.sql`, { stdio: 'inherit', cwd: path.resolve(__dirname, '../../') });


