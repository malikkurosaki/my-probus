const PrismaClient = require("@prisma/client").PrismaClient;
const prisma = new PrismaClient();
const fs = require("fs");
const path = require("path");
const _ = require("lodash");
const beautify = require("js-beautify");
const colors = require("colors");
const prompts = require("prompts");


const setDepartement = async () => {
    const users = await prisma.users.findMany({
        select: {
            id: true,
            name: true,
        }
    })

    const {selectUsers} = await prompts({
        type: 'multiselect',
        name: 'selectUsers',
        message: 'Select users',
        choices: users.map(user => ({
            title: user.name,
            value: user.id,
        }))
    })

    const departements = await prisma.departements.findMany({
        select: {
            id: true,
            name: true
        }
    })



    const {selectDepartement} = await prompts({
        type: 'select',
        name: 'selectDepartement',
        message: 'Select departement',
        choices: departements.map(departement => ({
            title: departement.name,
            value: departement.id,
        }))
    })

    console.log(selectUsers, selectDepartement)
}


const setUserDepartementExtend = {
    setDepartement
}

module.exports = setUserDepartementExtend;