const prompts = require('prompts');

function ModelGenerator({
    generate,
    runClientDebug,
    runServerDebug,
    serverCommand,
    clientCommand,
    buildRelease,
    gitPush
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

            default:
                break;
        }
    })
}

module.exports = ModelGenerator;