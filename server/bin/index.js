#!/usr/bin/env node
const prompts = require("prompts");
const path = require("path");
const _server = path.join(__dirname, "../../server");
const _client = path.join(__dirname, "../../client");
const execSync = require("child_process").execSync;

prompts(
  {
    type: "select",
    name: "pilihan",
    message: "pilih menunya",
    choices: [
      { title: "local", value: "local" },
      { title: "server", value: "server" },
    ],
  },
  {
    onSubmit: (_, answer) => {
      switch (answer) {
        case "local":
          local();
          break;
        case "server":
          break;
        default:
          console.log("tidak ada pilihan");
      }
    },
  }
);

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
            execSync(`git add . && git commit -m ya && git push origin main`, { stdio: "inherit" });
            break;
          default:
            console.log("tidak ada pilihan");
        }
      },
    }
  );
}
