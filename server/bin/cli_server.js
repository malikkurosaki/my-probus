const prompts = require("prompts");
const { CliChoose } = require("./cli_choose");
const { PromptSelect } = require("./model_prompt");
const { execSync } = require("child_process");
const {CliSsh } = require("./cli_ssh");

// /** @param {("pull from server")} title */
// function choose(title) {
//   return {
//     choices: {
//       title: title,
//       value: title,
//     },
//     /** @param {void} onSubmit */
//     isMe(answer, onSubmit) {
//       if (answer === title) onSubmit();
//     },
//   };
// }

// function select() {
//   try {
//     prompts(
//       {
//         type: "select",
//         name: "name",
//         message: "select menu",
//         choices: [choose("pull from server").choices],
//       },
//       {
//         onSubmit: (_, answer) => {
//           choose("pull from server").isMe(answer, () => {
//             console.log("pull from server");
//           });
//         },
//       }
//     );
//   } catch (error) {
//     console.log(error);
//   }
// }

class Choice extends CliChoose {
  /** @param {("logs")} title */
  constructor(title) {
    super(title);
  }
}

const logs = new Choice("logs");

function select() {
  PromptSelect([logs.choice], (_, answer) => {
    logs.isMe(answer, Logs);
  });
}

function Logs() {
   CliSsh("pm2 status");
//   CliSsh.exec(
//     `curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh && source ~/.bashrc && nvm list-remote && nvm install v18.4.0`,
//     {
//       out: (data) => console.log(data),
//       err: (err) => console.log(err),
//     }
//   ).start();

CliSsh.exec(
  "curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh && cd .nvm && source nvm.sh && nvm install v18.4.0",
  { out: (data) => console.log(data), err: (data) => console.log(data) }
).start();
}

const CliServer = {
  select,
};

module.exports = { CliServer };
