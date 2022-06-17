#!/usr/bin/env node
const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();
const prompts = require("prompts");
const fs = require("fs");
const path = require("path");
const { execSync } = require("child_process");
const { Preference } = require("./config_preference");
const { ClientComponent } = require("./client_component");
const { ModelStatusGenerate, ModelTypeGenerate } = require("./model_generate");
const { ModelGetnerate } = require("./generate");


// 103.171.85.55

// backup
// 139.99.114.113

function devMode() {
  let patDir = path.join(__dirname, "../../");
  let connFile = path.join(patDir, "client/lib/conn.dart");
  let fl = fs.readFileSync(connFile, "utf8");
  fl = fl.replace("https://makurostudio.my.id", "http://localhost:3000");
  fs.writeFileSync(connFile, fl);
}

function proMode() {
  let patDir = path.join(__dirname, "../../");
  let connFile = path.join(patDir, "client/lib/conn.dart");
  let fl = fs.readFileSync(connFile, "utf8");
  fl = fl.replace("http://localhost:3000", "https://makurostudio.my.id");
  fs.writeFileSync(connFile, fl);
}

const setMode = async (modenya) => {
  let devWeb = "http://localhost:3000";
  let proWeb = "https://makurostudio.my.id";
  let devMobile = "http://192.168.43.112:3000";
  let con = "";

  let connFile = path.join(__dirname, "./../../client/lib/config.dart");
 
  switch (modenya) {
    case "dev_web":
      con = devWeb;
      break;
    case "pro_web":
      con = proWeb;
      break;
    case "dev_mobile":
      con = devMobile;
      break;
    default:
      con = devWeb;
      break;
  }

  let target = `
  class Config{
    static const String host = "${con}";
  }`;

  fs.writeFileSync(connFile, target, { encoding: "utf-8" });

  console.log("mode set to " + modenya);

}

/**
 * @type {{
 * id: string,
 * name: string
 * }[]}
 */
let listUser = [];

(async () => {
  let users = await prisma.users.findMany({
    select: {
      id: true,
      name: true,
    },
  });

  listUser = users;

  const menu = await prompts([
    {
      type: "select",
      name: "action",
      message: "What do you want to do?",
      choices: [
        { title: "model generate", value: "model_generate" },
        { title: "config preference", value: "config_preference" },
        { title: "setting preferencr", value: "sp" },
        { title: "flutter build web github", value: "build_web_github" },
        { title: "flutter build web server", value: "build_web_server" },
        { title: "cmd server", value: "cmd_server" },
        { title: "client mode development", value: "cdev_mode" },
        { title: "client mode production", value: "cpro_mode" },
        { title: "cmd client", value: "cmd_client" },
        { title: "run server development", value: "run_server" },
        { title: "run client debug chrome", value: "rcd" },
        { title: "run client debug mobile", value: "run_mobile" },
        { title: "git push", value: "push" },
        { title: "migrate", value: "migrate" },
        { title: "generate", value: "gen" },
        { title: "seed", value: "seed" },
        { title: "run server pm2", value: "pm2_run" },
        { title: "pm2 restart", value: "pm2_restart" },
        { title: "install init", value: "install_init" },
        { title: "client mode", value: "client_mode" },
      ],
    },
  ]);

  

  switch (menu.action) {
    case "model_generate":
      ModelGetnerate();
      break;
    case "config_preference":
      Preference();
      break;
    case "build_web_github":
      execSync(
        `cd client && flutter build web --release --base-href '/my-probus/client/build/web/'`,
        { stdio: "inherit" }
      );
      break;
    case "build_web_server":
      execSync(
        `cd client && flutter build web --release`,
        { stdio: "inherit" }
      );
      break;
    case "cmd_server":
      const cmd = await prompts([
        {
          type: "text",
          name: "cmd",
          message: "Enter command",
        },
      ]);
      execSync(`cd server && ${cmd.cmd}`, { stdio: "inherit" });

      break;
    case "cmd_client":
      const cmd_client = await prompts([
        {
          type: "text",
          name: "cmd",
          message: "Enter command",
        },
      ]);
      execSync(`cd client && ${cmd_client.cmd}`, { stdio: "inherit" });
      break;
    case "run_server":
      execSync(`cd server && nodemon .`, { stdio: "inherit" });
      break;
    case "rcd":
      execSync(`cd client && flutter run -d chrome`, { stdio: "inherit" });
      break;
    case "run_mobile":
      execSync(`cd client && flutter run`, { stdio: "inherit" });
      break;
    case "cdev_mode":
      execSync(`node -e ${devMode()}`, { stdio: "inherit" });
      break;
    case "cpro_mode":
      execSync(`node -e ${proMode()}`, { stdio: "inherit" });
      break;
    case "push":
      execSync(`git add . && git commit -m "yo" && git push origin main`, {
        stdio: "inherit",
      });
      break;
    case "migrate":
      execSync(`cd server && npx prisma migrate dev --name apa_aja`, {
        stdio: "inherit",
      });
      break;
    case "gen":
      execSync(`cd server && npx prisma generate`, { stdio: "inherit" });
      break;
    case "seed":
      execSync(`cd server/seeders && node seed.js`, { stdio: "inherit" });
      break;
    case "pm2_run":
      execSync(`cd server && pm2 start index.js --name 'my-probus'`, {
        stdio: "inherit",
      });
      break;
    case "pm2_restart":
      execSync(`pm2 restart all`, { stdio: "inherit" });
      break;
    case "install_init":
      execSync(`cd server && npm install'`, { stdio: "inherit" });
      break;
    case "sp":
      settingPreference();
      break;
    case "client_mode":
      const pilihan = await prompts({
        type: "select",
        name: "mode",
        message: "What do you want to do?",
        choices: [
          { title: "dev web", value: "dev_web" },
          { title: "pro web", value: "pro_web" },
          { title: "dev mobile", value: "dev_mobile" },
        ],
      });
      setMode(pilihan.mode);
 
      break;
    default:
      console.log("Invalid action");
      break;
  }
})();

async function settingPreference() {
  const user = await prisma.users.findMany({
    select: {
      id: true,
      name: true,
    },
  });

  const pref = await prompts({
    type: "multiselect",
    name: "pref",
    message: "set admin",
    choices: user.map((u) => ({
      title: u.name,
      value: u.id,
    })),
  });

  const config = require(__dirname + "/../pref/pref.json");
  config.leader = pref.pref;

  fs.writeFileSync(
    __dirname + "/../pref/pref.json",
    JSON.stringify(config, null, 4),
    { encoding: "utf-8" }
  );
}
