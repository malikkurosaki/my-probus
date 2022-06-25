const prompts = require('prompts');
const path = require('path');
const _clientPath = path.join(__dirname, '../../client');
const _serverPath = path.join(__dirname, '../../server');
const execSync = require('child_process').execSync;
const fs = require('fs');
const beautify = require('js-beautify').js;
const _ = require('lodash');
const controll = fs.readFileSync(path.join(__dirname, './controll.js'), 'utf8');
const colors = require('colors');

function Generator() {
    /** @type {[]} */
    const model = require(path.join(__dirname, './pkg.json')).project

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
            new Controll().${_.camelCase(item)}() ;
            break;
            `
    }).join('');

    /** @type {[]} */
    const func = [];
    for (let f of model) {
        if (!controll.includes(`async ${_.camelCase(f)}()`)) {
            func.push(`async ${_.camelCase(f)}(){}`)
        }
    }

    const template = `
  
    const prompts = require('prompts');
    const Generator = require('./generator.js');
    const Controll = require('./controll');
    const cntrl = new Controll();

    function ModelGenerator() {
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


    const pengganti = `
    class Controll {
        ${func.join(' ')}
    `.trim()
    fs.writeFileSync(path.join(__dirname, './controll.js'), beautify(controll.replace('class Controll {', pengganti), {
        indent_size: 4
    }));

    console.log('ModelGenerator.js berhasil dibuat'.yellow);

}

module.exports = Generator;