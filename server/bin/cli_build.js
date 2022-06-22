const { CliChoose } = require("./cli_choose");
const { PromptSelect } = require("./model_prompt");
const execSync = require("child_process").execSync;
const path = require("path");
const fs = require("fs");
const { CliSetMode } = require("./cli_set_mode");
const { CliSsh } = require("./cli_ssh");
const { CliBuildDebug } = require("./cli_build_debug");
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
      CliBuildDebug("build_production")
      CliSetMode("pro_web");
      execSync(`cd ${client} && flutter build web --base-href '/' --release`, {
        stdio: "inherit",
      });
      console.log('build web production success');
      execSync(`cd ${client} && flutter build apk --release --split-per-abi`, {
        stdio: "inherit",
      });
      console.log('build android production success');
      execSync(
        `cp ${path.join(
          __dirname,
          "./../../client/build/app/outputs/apk/release/app-arm64-v8a-release.apk"
        )} ${path.join(__dirname, "./../../server/assets/apk/")}`,
        { stdio: "inherit" }
      );
      console.log('copy apk success');
      execSync(`git add . && git commit -m "ya" && git push`, {
        stdio: "inherit",
      });
      console.log('git push success');
      CliSsh("cd my-probus && git pull && pm2 restart 0");
      console.log('pm2 restart success');
      CliSetMode("dev_web");

    });
    

    buildDebug.isMe(answer, CliBuildDebug.log);

  });
}

module.exports = { CliBuild };
