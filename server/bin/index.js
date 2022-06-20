#!/usr/bin/env node
const prompts = require("prompts");
const path = require("path");
const _server = path.join(__dirname, "../../server");
const _client = path.join(__dirname, "../../client");
const execSync = require("child_process").execSync;
const fs = require("fs");
const Ssh = require("simple-ssh");
const ssh = new Ssh({
  host: "makurostudio.my.id",
  user: "makuro",
  pass: "Makuro_123",
});

choices1("");

/** @typedef {"local" | "server" | "mode" | "build"} Chooice1 */
/** @typedef {"dev_web" | "pro_web" | "dev_mobile"} Chooice2 */
/** @typedef {"run_client_web" | "run_client_android" | "run_server" | "git_push" | "git_clear"} Chooice3 */

/** @param {Chooice1} title */
function choices1(title) {
  return {
    choices: {
      title: title,
      value: title,
    },
    /** @param {void} onSubmit */
    isMe(answer, onSubmit) {
      if (answer === title) onSubmit();
    },
  };
}

prompts(
  {
    type: "select",
    name: "pilihan",
    message: "pilih menunya",
    choices: [
      choices1("local").choices,
      choices1("server").choices,
      choices1("build").choices,
      choices1("mode").choices,
    ],
  },
  {
    onSubmit: (_, answer) => {
      choices1("local").isMe(answer, local);
      choices1("server").isMe(answer, server);
      choices1("build").isMe(answer, build);
      choices1("mode").isMe(answer, mode);
    },
  }
);

function server() {
  console.log("server");
}

function mode() {
  prompts(
    {
      type: "select",
      name: "name",
      message: "select menu",
      choices: [
        { title: "mode development web", value: "dev_web" },
        { title: "mode production", value: "pro_web" },
        { title: "mode developmen mobile", value: "dev_mobile" },
      ],
    },
    {
      onSubmit: (_, answer) => {
        setMode(answer);
      },
    }
  );
}

/**
 *
 * @param {Chooice2} modenya
 */
function setMode(modenya) {
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

  try {
    fs.writeFileSync(connFile, target, { encoding: "utf-8" });

    console.log("mode set to " + modenya);
  } catch (error) {
    console.log(error);
  }
}

function local() {
  prompts(
    {
      type: "select",
      name: "name",
      message: "select menu",
      choices: [
        { title: "run client web", value: "run_client_web" },
        { title: "run client android", value: "run_client_android" },
        { title: "run server", value: "run_server" },
        { title: "git push", value: "git_push" },
        { title: "git clear", value: "git_clear" },
      ],
    },
    {
      onSubmit: (_, answer) => {
        switch (answer) {
          case "run_client_web":
            execSync(`cd ${_client} && flutter run`, { stdio: "inherit" });
            break;
          case "run_client_android":
            execSync(`cd ${_client} && flutter run `, {
              stdio: "inherit",
            });
            break;
          case "run_server":
            execSync(`cd ${_server} && nodemon .`, { stdio: "inherit" });
            break;
          case "git_push":
            execSync(`git add . && git commit -m ya && git push origin main`, {
              stdio: "inherit",
            });
            break;
          case "git_clear":
            execSync(`git rm -r --cached .`, { stdio: "inherit" });
            break;
          default:
            console.log("tidak ada pilihan");
        }
      },
    }
  );
}

/**
 *
 * @param {"web github version" | "web production" | "android" } value
 */
function chooiceBuild(value) {
  return {
    choices: {
      title: value,
      value: value,
    },
    /** @param {void} onSubmit */
    isMe(answer, onSubmit) {
      if (answer === value) onSubmit();
    },
  };
}

function build() {
  prompts(
    {
      type: "select",
      name: "name",
      message: "select menu",
      choices: [
        chooiceBuild("web github version").choices,
        chooiceBuild("web production").choices,
        chooiceBuild("android").choices,
      ],
    },
    {
      onSubmit: (_, answer) => {
        chooiceBuild("web github version").isMe(answer, () => {
          execSync(
            `cd ${_client} && flutter build web --base-href '/my-probus/client/build/web/' --release`,
            {
              stdio: "inherit",
            }
          );

          console.log("build web github version");
        });

        chooiceBuild("web production").isMe(answer, () => {
          execSync(
            `cd ${_client} && flutter build web --base-href '/' --release`,
            {
              stdio: "inherit",
            }
          );
          console.log("build web production done");
          execSync(`git add . && git commit -m "ya" && git push`, {
            stdio: "inherit",
          });
          console.log("git push done");
          ssh.exec(`cd my-probus && git pull && pm2 restart all`, {
            out: (data) => console.log(data),
          }).start();
        });

        chooiceBuild("android").isMe(answer, () => {
          ssh
            .exec(`cd my-probus && git pull`, {
              out: (data) => {
                console.log(data);
              },
            })
            .start();

          // execSync(`cd ${_client} && flutter build apk --release --split-per-abi`, {
          //   stdio: "inherit",
          // });

          // console.log("build android");
        });
      },
    }
  );
}
