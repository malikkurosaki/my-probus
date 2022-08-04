#!/usr/bin/env node
const prompts = require('prompts');
const fs = require('fs');
const path = require('path');
const execSync = require('child_process').execSync;
const _ = require('lodash');
const beautify = require('js-beautify').js_beautify;
const colors = require('colors');
<<<<<<< HEAD
var figlet = require('figlet');

const menuDir = fs.readdirSync(path.join(__dirname, 'menus'));

figlet('Xprobus2', {
    font: "Swan",
}, function (err, data) {
    if (err) {
        console.log('Something went wrong...');
        console.dir(err);
        return;
    }
    console.log(data.green);
    console.log("======================================".green);
    console.log("@malikkurosaki                 v.0.0.1".green);
    console.log("======================================".green);
=======
const figlet = require('figlet');

const menuDir = fs.readdirSync(path.join(__dirname, 'menus'));


figlet("Xprobus",{font: "Swan"}, (err, data) => {
    console.log(data.cyan);
    console.log("==================================");
    console.log("@malikkurosaki             v.0.0.1".cyan);
    console.log("==================================");
>>>>>>> main

    prompts({
        type: 'select',
        name: 'menu',
        message: 'Select an option',
        choices: [
            {
                title: 'menu create'.yellow,
                value: "menu_create"
            },
            {
                title: 'menu remove'.yellow,
                value: "menu_remove"
            },
            ...menuDir.map(menu => ({
                title: menu.split('.')[0].replace('_', ' '),
                value: menu
            }))
        ]
    }).then(({ menu }) => {
        if (menu == undefined) {
            console.log("No menu selected".red);
            return;
        }
<<<<<<< HEAD

        figlet(menu.split('.')[0].replace("_", " "), {
            font: "Calvin S",
        }, function (err, data) {
            if (err) {
                console.log('Something went wrong...');
                console.dir(err);
                return;
            }
            console.log(data.yellow);

            if (menu == "menu_create") {
                prompts({
                    type: 'text',
                    name: 'menu_name',
                    message: 'Enter menu name'
                }).then(({ menu_name }) => {
                    if (menu_name == undefined || menu_name == "") {
                        console.log("No menu name entered".red);
                        return;
                    }

                    const targetFile = path.join(__dirname, './menus/' + _.snakeCase(menu_name) + '.js');
                    if (fs.existsSync(targetFile)) {
                        console.log("Menu already exists".red);
                        return;
                    }

                    const menu_content = `
=======

        if (menu == "menu_create") {
            prompts({
                type: 'text',
                name: 'menu_name',
                message: 'Enter menu name'
            }).then(({ menu_name }) => {
                if (menu_name == undefined || menu_name == "") {
                    console.log("No menu name entered".red);
                    return;
                }

                const targetFile = path.join(__dirname, './menus/' + _.snakeCase(menu_name) + '.js');
                if (fs.existsSync(targetFile)) {
                    console.log("Menu already exists".red);
                    return;
                }

                const menu_content = `
>>>>>>> main
            #!/usr/bin/env node
            const prompts = require('prompts');
            const fs = require('fs');
            const path = require('path');
            const execSync = require('child_process').execSync;
            const _ = require('lodash');
            const beautify = require('js-beautify').js_beautify;
            const colors = require('colors');
            const PrismaClient = require('@prisma/client').PrismaClient;
            const prisma = new PrismaClient();
            const cLog = require('c-log');
            `

<<<<<<< HEAD
                    fs.writeFileSync(targetFile, beautify(menu_content));
                    console.log("Menu created".green);
                }
                ).catch(err => {
                    console.log(err);
                }
                );
            }

            else if (menu == "menu_remove") {
                const targetDir = fs.readdirSync(path.join(__dirname, './menus'));

                if (_.isEmpty(targetDir)) {
                    console.log("menu is empty".red);
                    return;
                }

                prompts({
                    type: "multiselect",
                    name: 'menus',
                    message: 'Select some menu to remove',
                    choices: targetDir.map(file => {
                        return {
                            title: file.split('/').pop().split('.')[0],
                            value: file.split('/').pop().split('.')[0]
                        }
                    }
                    )
                }).then(({ menus }) => {
                    if (menus == undefined || _.isEmpty(menus)) {
                        console.log("No menu selected".red);
                        return;
                    }

                    menus.forEach(menu => {
                        const targetFile = path.join(__dirname, './menus/' + menu + '.js');
                        fs.unlinkSync(targetFile);
                    }
                    );

                    console.log("Menu removed".green);
                }
                ).catch(err => {
                    console.log(err);
                });
            } else {
                execSync(`node ${menu}`, { stdio: 'inherit', cwd: path.join(__dirname, './menus') });
            }

        });

    })
});

=======
                fs.writeFileSync(targetFile, beautify(menu_content));
                console.log("Menu created".green);
            }
            ).catch(err => {
                console.log(err);
            }
            );
        }

        else if (menu == "menu_remove") {
            const targetDir = fs.readdirSync(path.join(__dirname, './menus'));

            if (_.isEmpty(targetDir)) {
                console.log("menu is empty".red);
                return;
            }

            prompts({
                type: "multiselect",
                name: 'menus',
                message: 'Select some menu to remove',
                choices: targetDir.map(file => {
                    return {
                        title: file.split('/').pop().split('.')[0],
                        value: file.split('/').pop().split('.')[0]
                    }
                }
                )
            }).then(({ menus }) => {
                if (menus == undefined || _.isEmpty(menus)) {
                    console.log("No menu selected".red);
                    return;
                }

                menus.forEach(menu => {
                    const targetFile = path.join(__dirname, './menus/' + menu + '.js');
                    fs.unlinkSync(targetFile);
                }
                );

                console.log("Menu removed".green);
            }
            ).catch(err => {
                console.log(err);
            });
        } else {
            execSync(`node ${menu}`, { stdio: 'inherit', cwd: path.join(__dirname, './menus') });
        }

    })
})
>>>>>>> main
