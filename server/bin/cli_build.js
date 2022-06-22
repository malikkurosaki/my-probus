const { CliChoose } = require("./cli_choose");
const { PromptSelect } = require("./model_prompt");
const execSync = require("child_process").execSync;
const path = require("path");
const fs = require("fs");
const { CliSetMode } = require("./cli_set_mode");
const { CliSsh } = require("./cli_ssh");
const client = path.join(__dirname, "../../client");
const server = path.join(__dirname, "../../server");

class Choice extends CliChoose {
  constructor(title) {
    super(title);
  }
}

const buildWebProduction = new Choice("build web production mode");
const buildDebug = new Choice("build debug mode");

function CliBuild() {
  PromptSelect([buildWebProduction.choice, buildDebug.choice], (_, answer) => {
    buildWebProduction.isMe(answer, () => {
      CliSetMode("pro_web");
      execSync(`cd ${client} && flutter build web --base-href '/' --release`, {
        stdio: "inherit",
      });
      execSync(`cd ${client} && flutter build apk --release --split-per-abi`, {
        stdio: "inherit",
      });
      execSync(
        `cp ${path.join(
          __dirname,
          "./../../client/build/app/outputs/apk/release/app-arm64-v8a-release.apk"
        )} ${path.join(__dirname, "./../../server/assets/apk/")}`,
        { stdio: "inherit" }
      );
      execSync(`git add . && git commit -m "ya" && git push`, {
        stdio: "inherit",
      });
      CliSsh("cd my-probus && git pull && pm2 restart 0").start();
      CliSetMode("dev_web");
    });
    

    buildDebug.isMe(answer, () => {
      console.log("ini namanaa debug")
    })

  });
}

module.exports = { CliBuild };
