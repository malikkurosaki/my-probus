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
            title: 'build github',
            value: 'buildGithub',
        }, {
            title: 'build push github',
            value: 'buildPushGithub',
        }, {
            title: 'git push',
            value: 'gitPush',
        }, {
            title: 'git clear cached',
            value: 'gitClearCached',
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
            title: 'prisma generate',
            value: 'prismaGenerate',
        }, {
            title: 'seeders',
            value: 'seeders',
        }, {
            title: 'backup csv',
            value: 'backupCsv',
        }, {
            title: 'update local',
            value: 'updateLocal',
        }, {
            title: 'generate image',
            value: 'generateImage',
        }, {
            title: 'v2 user role generate',
            value: 'v2UserRoleGenerate',
        }, {
            title: 'client generate route',
            value: 'clientGenerateRoute',
        }, {
            title: 'client generate menu',
            value: 'clientGenerateMenu',
        }, {
            title: 'generate user role',
            value: 'generateUserRole',
        }, {
            title: 'generate model',
            value: 'generateModel',
        }, {
            title: 'generte issue type and status',
            value: 'generteIssueTypeAndStatus',
        }, {
            title: 'generate api',
            value: 'generateApi',
        }, {
            title: 'set user department',
            value: 'setUserDepartment',
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

            case 'buildGithub':
                new Controll().buildGithub();
                break;

            case 'buildPushGithub':
                new Controll().buildPushGithub();
                break;

            case 'gitPush':
                new Controll().gitPush();
                break;

            case 'gitClearCached':
                new Controll().gitClearCached();
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

            case 'prismaGenerate':
                new Controll().prismaGenerate();
                break;

            case 'seeders':
                new Controll().seeders();
                break;

            case 'backupCsv':
                new Controll().backupCsv();
                break;

            case 'updateLocal':
                new Controll().updateLocal();
                break;

            case 'generateImage':
                new Controll().generateImage();
                break;

            case 'v2UserRoleGenerate':
                new Controll().v2UserRoleGenerate();
                break;

            case 'clientGenerateRoute':
                new Controll().clientGenerateRoute();
                break;

            case 'clientGenerateMenu':
                new Controll().clientGenerateMenu();
                break;

            case 'generateUserRole':
                new Controll().generateUserRole();
                break;

            case 'generateModel':
                new Controll().generateModel();
                break;

            case 'generteIssueTypeAndStatus':
                new Controll().generteIssueTypeAndStatus();
                break;

            case 'generateApi':
                new Controll().generateApi();
                break;

            case 'setUserDepartment':
                new Controll().setUserDepartment();
                break;

            default:
                break;
        }
    })
}

module.exports = ModelGenerator;