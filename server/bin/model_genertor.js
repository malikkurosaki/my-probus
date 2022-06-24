const prompts = require('prompts');

function ModelGenerator({
    generate,
    runClientDebug,
    runServerDebug,
    serverCommand,
    clientCommand,
    buildRelease,
    gitPush,
    clearIssue,
    modeDev,
    modePro,
    modeMobile,
    nodejsInstallPackage,
    exportUser,
    seedClient
}) {
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
        }]

    }).then(({
        pilih
    }) => {
        switch (pilih) {

            case 'generate':
                generate();
                break;

            case 'runClientDebug':
                runClientDebug();
                break;

            case 'runServerDebug':
                runServerDebug();
                break;

            case 'serverCommand':
                serverCommand();
                break;

            case 'clientCommand':
                clientCommand();
                break;

            case 'buildRelease':
                buildRelease();
                break;

            case 'gitPush':
                gitPush();
                break;

            case 'clearIssue':
                clearIssue();
                break;

            case 'modeDev':
                modeDev();
                break;

            case 'modePro':
                modePro();
                break;

            case 'modeMobile':
                modeMobile();
                break;

            case 'nodejsInstallPackage':
                nodejsInstallPackage();
                break;

            case 'exportUser':
                exportUser();
                break;

            case 'seedClient':
                seedClient();
                break;

            default:
                break;
        }
    })
}

module.exports = ModelGenerator;