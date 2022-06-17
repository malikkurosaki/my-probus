const {PrismaClient} = require('@prisma/client');
const prisma = new PrismaClient();
const _ = require('lodash');

const { ModelRoleGenerate, ModelStatusGenerate, ModelTypeGenerate, GenerateBodyStatus } = require("./model_generate");

const ModelGetnerate = async () => {
    // ModelRoleGenerate();
    // ModelStatusGenerate();
    // ModelTypeGenerate();
    GenerateBodyStatus();

    
}

module.exports = { ModelGetnerate };