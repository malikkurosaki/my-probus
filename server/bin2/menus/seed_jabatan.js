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

const listJabatan = [
    "director",
    "manager representative",
    "manager production",
    "manager trainer",
    "manager backoffice",
    "manager frontoffice",
    "manager it",
    "trainer",
    "sales",
    "marketing",
    "it",
    "programer",
    "programer web",
    "programer android",
    "admin",
    "accouting",
    "hr",
    "finance",
    "legal",
    "office assistant"
]

    ; (async () => {
        let id = 1;
        for (let jabatan of listJabatan) {
          
            await prisma.jabatan.upsert({
                where: {
                    id: `${id}`
                },
                update: {
                    name: jabatan
                },
                create: {
                    id: `${id}`,
                    name: jabatan
                }
            })

            id++;
        }

        cLog.success('Jabatan berhasil di generate');
    })();