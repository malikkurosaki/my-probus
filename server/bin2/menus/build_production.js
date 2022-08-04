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

let branch = execSync('git rev-parse --abbrev-ref HEAD').toString().trim();
execSync(`flutter build web --release && flutter build apk --release --split-per-abi`, { stdio: 'inherit' , cwd: path.join(__dirname, './../../../client')});
execSync(`git add . && git commit -m "$(date)" && git push origin ${branch}`, { stdio: 'inherit' , cwd: path.join(__dirname, './../../../')});