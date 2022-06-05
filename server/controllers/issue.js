const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();
const expressAsyncHandler = require('express-async-handler');
const routeIssue = require('express').Router();


const IssueGet = expressAsyncHandler(async (req, res) => {
    const issues = await prisma.issues.findMany({
        select: {
            name: true,
            id: true,
            createdAt: true,
            IssuePriority: {
                select: {
                    id: true,
                    name: true,
                    value: true
                }
            },
            IssueType: {
                select: {
                    name: true,
                }
            },
            Departement: {
                select: {
                    name: true,
                }
            },
            CreatedBy: {
                select: {
                    name: true,
                }
            },
            Client: {
                select: {
                    name: true,
                }
            }

        },
    });
    res.status(200).json({
        message: 'Get all issues success',
        data: issues
    });
});

const IssuePost = expressAsyncHandler(async (req, res) => {
    const issue = await prisma.issues.create({
        data: {
            ...req.body
        }
    });
    res.status(201).json({
        message: 'Create issue success',
        data: issue
    });
});

const IssuePut = expressAsyncHandler(async (req, res) => {
    const issue = await prisma.issues.update({
        where: {
            id: req.params.id
        },
        data: {
            ...req.body
        }
    });
    res.status(200).json({
        message: 'Update issue success',
        data: issue
    });
});

routeIssue.get('/', IssueGet);
routeIssue.post('/', IssuePost);

module.exports = { routeIssue };
