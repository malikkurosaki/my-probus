const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();
const expressAsyncHandler = require('express-async-handler');
const routeDiscus = require('express').Router();

const DiscusGet = expressAsyncHandler(async (req, res) => {
    const disus = await prisma.discussion.findMany({
        where: {
            issuesId: req.params.id

        },
        include: {
            User: {
                select: {
                    id: true,
                    name: true,
                }
            },
            Image: {
                select: {
                    id: true,
                    name: true,
                }
            }
        }
    })

    res.status(200).json({
        message: 'Get discus success',
        success: true,
        data: disus
    })


})

const DiscusPost = expressAsyncHandler(async (req, res) => {
    const discus = await prisma.discussion.create({
        data: {
            content: req.body.content??undefined,
            issuesId: req.body.issuesId,
            usersId: req.body.usersId,
            imagesId: req.body.imagesId??undefined,
        },
        include: {
            User: {
                select: {
                    id: true,
                    name: true,
                }
            },
            Image: {
                select: {
                    id: true,
                    name: true,
                }
            }
        }
        
    })

    res.status(201).json({
        message: 'Create discus success',
        success: true,
        data: discus
    })
})

routeDiscus.get('/:id', DiscusGet);
routeDiscus.post('/', DiscusPost);

module.exports = { routeDiscus }



