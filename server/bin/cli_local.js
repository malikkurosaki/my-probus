const path = require("path");
const prompts = require("prompts");
const { CliChoose } = require("./cli_choose");
const { PromptSelect } = require("./model_prompt");
const execSync = require("child_process").execSync;
const _client = path.join(__dirname, "../../client");
const _server = path.join(__dirname, "../../server");

class choose extends CliChoose {
  /** @param {"run web local" | "run android local" | "run server local" | "git push local" | "git clear local"} title */
  constructor(title) {
    super(title);
  }
}

const runWebLocal = new choose("run web local");
const runServerLocal = new choose("run server local");
const runAndroidLocal = new choose("run android local");
const gitPushLocal = new choose("git push local");
const gitClearLocal = new choose("git clear local");

function select() {
  prompts(
    {
      type: "select",
      name: "pilihan",
      message: "pilih menunya",
      choices: [
        runWebLocal.choice,
        runServerLocal.choice,
        runAndroidLocal.choice,
        gitPushLocal.choice,
        gitClearLocal.choices,
      ],
    },
    {
      onSubmit: (_, answer) => {
        runWebLocal.isMe(answer, runWeb);
        runServerLocal.isMe(answer, runServer);
        runAndroidLocal.isMe(answer, runAndroid);
        gitPushLocal.isMe(answer, gitPush);
        gitClearLocal.isMe(answer, gitClearl);
      },
    }
  );
  //   prompts(
  //     {
  //       type: "select",
  //       name: "name",
  //       message: "select menu",
  //       choices: [
  //         { title: "run client web", value: "run_client_web" },
  //         { title: "run client android", value: "run_client_android" },
  //         { title: "run server", value: "run_server" },
  //         { title: "git push", value: "git_push" },
  //         { title: "git clear", value: "git_clear" },
  //       ],
  //     },
  //     {
  //       onSubmit: (_, answer) => {
  //         switch (answer) {
  //           case "run_client_web":
  //             execSync(`cd ${_client} && flutter run -d chrome`, {
  //               stdio: "inherit",
  //             });
  //             break;
  //           case "run_client_android":
  //             execSync(`cd ${_client} && flutter run `, {
  //               stdio: "inherit",
  //             });
  //             break;
  //           case "run_server":
  //             execSync(`cd ${_server} && nodemon .`, { stdio: "inherit" });
  //             break;
  //           case "git_push":
  //             execSync(`git add . && git commit -m ya && git push origin main`, {
  //               stdio: "inherit",
  //             });
  //             break;
  //           case "git_clear":
  //             execSync(`git rm -r --cached .`, { stdio: "inherit" });
  //             break;
  //           default:
  //             console.log("tidak ada pilihan");
  //         }
  //       },
  //     }
  //   );
}

function runWeb() {
  execSync(`cd ${_client} && flutter run -d chrome`, { stdio: "inherit" });
}
function runServer() {
  execSync(`cd ${_server} && nodemon .`, { stdio: "inherit" });
}
function runAndroid() {
  execSync(`cd ${_client} && flutter run `, { stdio: "inherit" });
}
function gitPush() {
  execSync(`git add . && git commit -m ya && git push origin main`, {
    stdio: "inherit",
  });
}
function gitClearl() {
  execSync(`git rm -r --cached .`, { stdio: "inherit" });
}

const CliLocal = {
  //   choice: choice,
  select: select,
};

module.exports = { CliLocal };
