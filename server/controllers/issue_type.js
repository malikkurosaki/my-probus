const {PrismaClient} = require('@prisma/client');
const prisma = new PrismaClient();
const expressAsyncHandler = require('express-async-handler');
const express = require('express');
const routIssueType = express.Router();

const IssueTypeGet = expressAsyncHandler(async (req, res) => {
    const issueTypes = await prisma.issueTypes.findMany();
    res.status(200).json({
        message: 'Get all issueTypes success',
        data: issueTypes
    });
})

routIssueType.get('/', IssueTypeGet);

module.exports = { routIssueType };
