#!/usr/bin/env node

const prompts = require('prompts');
const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');


; (async () => {
    const menu = await prompts([
        {
            type: 'select',
            name: 'action',
            message: 'What do you want to do?',
            choices: [
                { title: 'cmd server', value: 'cmd_server' },
                { title: 'cmd client', value: 'cmd_client' },
                { title: 'run server', value: 'run_server' },
                { title: 'run client debug chrome', value: 'rcd' },
                { title: 'git push', value: 'push' },
                { title: 'migrate', value: 'migrate' },
                { title: 'generate', value: 'gen' },
                { title: 'seed', value: 'seed' },
                { title: 'run server pm2', value: 'pm2_run' },
                { title: 'install init', value: 'install_init' },
            ],
        },
    ]);

    switch (menu.action) {
        case 'cmd_server':
            const cmd = await prompts([
                {
                    type: 'text',
                    name: 'cmd',
                    message: 'Enter command',
                },
            ]);
            execSync(`cd server && ${cmd.cmd}`, { stdio: 'inherit' });

            break;
        case 'cmd_client':
            const cmd_client = await prompts([
                {
                    type: 'text',
                    name: 'cmd',
                    message: 'Enter command',
                },
            ]);
            execSync(`cd client && ${cmd_client.cmd}`, { stdio: 'inherit' });
            break;
        case 'run_server':
            execSync(`cd server && nodemon .`, { stdio: 'inherit' });
            break;
        case 'rcd':
            execSync(`cd client && flutter run -d chrome`, { stdio: 'inherit' });
            break;
        case 'push':
            execSync(`git add . && git commit -m "yo" && git push origin main`, { stdio: 'inherit' });
            break;
        case 'migrate':
            execSync(`cd server && npx prisma migrate dev --name apa_aja`, { stdio: 'inherit' });
            break;
        case 'gen':
            execSync(`cd server && npx prisma generate`, { stdio: 'inherit' });
            break;
        case 'seed':
            execSync(`cd server/seeders && node seed.js`, { stdio: 'inherit' });
            break;
        case 'pm2_run':
            execSync(`cd server && pm2 start index.js --name 'my-probus'`, { stdio: 'inherit' });
            break;
        case 'install_init':
            execSync(`cd server && npm install'`, { stdio: 'inherit' });
            break;
        default:
            console.log('Invalid action');
            break;
    }

})();
