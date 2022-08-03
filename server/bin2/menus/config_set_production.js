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

const template = `
  class Config{
    static const String host = "http://103.186.0.176:3001";
  }
`

fs.writeFileSync(path.join(__dirname, './../../../client/lib/config.dart'), beautify(template, { indent_size: 2 }));