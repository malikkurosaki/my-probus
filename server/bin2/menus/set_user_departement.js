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


function tabelnya(){
    prisma.departements.findMany({
        select: {
            name: true,
            UserDepartement: {
                select: {
                    User: {
                        select: {
                            name: true,
                        }
                    }
                }
            }
        }
    }).then(departements => {

        const showDepartement = departements.map(e => {
            return {
                name: e.name,
                users: e.UserDepartement.map(u => u.User.map(uu => uu.name).join(', ')).join(' ,')
            }
        })
        cLog.table(showDepartement);

    })
}

function pilih(){
    prisma.users.findMany().then(async users => {
        const dep = await prisma.departements.findMany();

        prompts([
            {
                type: 'select',
                name: 'user',
                message: 'Select user',
                choices: users.map(user => ({
                    title: user.name,
                    value: user,
                }))
            },
            {
                type: 'multiselect',
                name: "departement",
                message: "Select departement",
                choices: dep.map(departement => ({
                    title: departement.name,
                    value: departement,
                }))
            }
        ]).then(({ user, departement }) => {
            if (user == undefined || departement == undefined) {
                console.log('tidak terpilih'.red)
                return
            }


            departement.forEach(departement => {
                prisma.userDepartement.create({
                    data: {
                        User: {
                            connect: {
                                id: user.id
                            }
                        },
                        Departement: {
                            connect: {
                                id: departement.id
                            }
                        }
                    }
                }).then(tabelnya)
            })

        })
    })
}

pilih();