const prompts = require('prompts');
const Generator = require('./generator.js');
const Controll = require('./controll');
const cntrl = new Controll();

function ModelGenerator() {
    prompts({
        type: 'select',
        name: 'pilih',
        message: 'Pilih Menu',
        choices: [{
            title: 'generate',
            value: 'generate',
        }, {
            title: 'run client debug',
            value: 'runClientDebug',
        }, {
            title: 'run server debug',
            value: 'runServerDebug',
        }, {
            title: 'server command',
            value: 'serverCommand',
        }, {
            title: 'client command',
            value: 'clientCommand',
        }, {
            title: 'build release',
            value: 'buildRelease',
        }, {
            title: 'git push',
            value: 'gitPush',
        }, {
            title: 'clear issue',
            value: 'clearIssue',
        }, {
            title: 'mode dev',
            value: 'modeDev',
        }, {
            title: 'mode pro',
            value: 'modePro',
        }, {
            title: 'mode mobile',
            value: 'modeMobile',
        }, {
            title: 'nodejs install package',
            value: 'nodejsInstallPackage',
        }, {
            title: 'export user',
            value: 'exportUser',
        }, {
            title: 'seed client',
            value: 'seedClient',
        }, {
            title: 'prisma migrate',
            value: 'prismaMigrate',
        }, {
            title: 'seeders',
            value: 'seeders',
        }]

    }).then(({
        pilih
    }) => {
        switch (pilih) {

            case 'generate':
                new Controll().generate();
                break;

            case 'runClientDebug':
                new Controll().runClientDebug();
                break;

            case 'runServerDebug':
                new Controll().runServerDebug();
                break;

            case 'serverCommand':
                new Controll().serverCommand();
                break;

            case 'clientCommand':
                new Controll().clientCommand();
                break;

            case 'buildRelease':
                new Controll().buildRelease();
                break;

            case 'gitPush':
                new Controll().gitPush();
                break;

            case 'clearIssue':
                new Controll().clearIssue();
                break;

            case 'modeDev':
                new Controll().modeDev();
                break;

            case 'modePro':
                new Controll().modePro();
                break;

            case 'modeMobile':
                new Controll().modeMobile();
                break;

            case 'nodejsInstallPackage':
                new Controll().nodejsInstallPackage();
                break;

            case 'exportUser':
                new Controll().exportUser();
                break;

            case 'seedClient':
                new Controll().seedClient();
                break;

            case 'prismaMigrate':
                new Controll().prismaMigrate();
                break;

            case 'seeders':
                new Controll().seeders();
                break;

            default:
                break;
        }
    })
}

module.exports = ModelGenerator;