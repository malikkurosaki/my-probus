const prompts = require('prompts');

function ModelGenerator({
    generate,
    runClientDebug,
    runServerDebug,
    modeDev,
    modePro,
    modeMobile,
    prismaMigrate
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
            title: 'mode dev',
            value: 'modeDev',
        }, {
            title: 'mode pro',
            value: 'modePro',
        }, {
            title: 'mode mobile',
            value: 'modeMobile',
        }, {
            title: 'prisma migrate',
            value: 'prismaMigrate',
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

            case 'modeDev':
                modeDev();
                break;

            case 'modePro':
                modePro();
                break;

            case 'modeMobile':
                modeMobile();
                break;

            case 'prismaMigrate':
                prismaMigrate();
                break;

            default:
                break;
        }
    })
}

module.exports = ModelGenerator;