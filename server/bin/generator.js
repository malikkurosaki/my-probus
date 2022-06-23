const prompts = require('prompts');
const path = require('path');
const _clientPath = path.join(__dirname, '../../client');
const _serverPath = path.join(__dirname, '../../server');
const execSync = require('child_process').execSync;
const fs = require('fs');
const beautify = require('js-beautify').js;
const _ = require('lodash');


function Generator() {
    /** @type {[]} */
    const model = require(path.join(__dirname, './model.json'))

    const items = model.map(item => {
        return `{
            title: '${item}',
            value: '${_.camelCase(item)}',
        }`
    }).join(',');

    /** @type {[]} */
    const caseItem = model.map(item => {
        return `
        case '${_.camelCase(item)}':
            ${_.camelCase(item)}();
            break;
            `
    }).join('');

    const template = `
    const prompts = require('prompts');
    function ModelGenerator({${model.map((e) => {return _.camelCase(e)}).join(', ')}}) {
        prompts({
                type: 'select',
                name: 'pilih',
                message: 'Pilih Menu',
                choices: [${items}]

            }).then(({
                    pilih
                }) => {
                switch (pilih) {
                    ${caseItem}
                    default:
                        break;
            }
        })
    }

    module.exports = ModelGenerator;
    `

    fs.writeFileSync(path.join(__dirname, './model_genertor.js'), beautify(template, {
        indent_size: 4
    }));
    
    console.log('ModelGenerator.js berhasil dibuat');

}

module.exports = Generator;