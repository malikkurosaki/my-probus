#!/usr/bin/env node

const prompts = require('prompts');
const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');
// 103.171.85.55

// backup
// 139.99.114.113

function devMode(){
    let patDir = path.join(__dirname, '../../');
    let connFile = path.join(patDir, 'client/lib/conn.dart');
    let fl = fs.readFileSync(connFile, 'utf8');
    fl = fl.replace('103.171.85.55', 'localhost');
    fs.writeFileSync(connFile, fl);

}

function proMode(){
    let patDir = path.join(__dirname, '../../');
    let connFile = path.join(patDir, 'client/lib/conn.dart');
    let fl = fs.readFileSync(connFile, 'utf8');
    fl = fl.replace('localhost:3000', 'makurostudio.my.id');
    fs.writeFileSync(connFile, fl);
}


; (async () => {
    const menu = await prompts([
        {
            type: 'select',
            name: 'action',
            message: 'What do you want to do?',
            choices: [
                { title: 'flutter build web', value: 'build_web' },
                { title: 'cmd server', value: 'cmd_server' },
                { title: 'client mode development', value: 'cdev_mode' },
                { title: 'client mode production', value: 'cpro_mode' },
                { title: 'cmd client', value: 'cmd_client' },
                { title: 'run server development', value: 'run_server' },
                { title: 'run client debug chrome', value: 'rcd' },
                { title: 'git push', value: 'push' },
                { title: 'migrate', value: 'migrate' },
                { title: 'generate', value: 'gen' },
                { title: 'seed', value: 'seed' },
                { title: 'run server pm2', value: 'pm2_run' },
                { title: 'pm2 restart', value: 'pm2_restart' },
                { title: 'install init', value: 'install_init' },
                
            ],
        },
    ]);

    switch (menu.action) {
        case 'build_web':
            execSync(`cd client && flutter build web --base-href '/my-probus/client/build/web/'`, { stdio: 'inherit' });
            break;
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
        case 'cdev_mode':
            execSync(`node -e ${devMode()}`, { stdio: 'inherit' });
            break;
        case 'cpro_mode':
            execSync(`node -e ${proMode()}`, { stdio: 'inherit' });
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
        case 'pm2_restart':
            execSync(`pm2 restart all`, { stdio: 'inherit' });
            break;
        case 'install_init':
            execSync(`cd server && npm install'`, { stdio: 'inherit' });
            break;
        default:
            console.log('Invalid action');
            break;
    }

})();
