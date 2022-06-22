#!/usr/bin/env node
const prompts = require("prompts");
const path = require("path");
const _server = path.join(__dirname, "../../server");
const _client = path.join(__dirname, "../../client");
const execSync = require("child_process").execSync;
const fs = require("fs");
const { CliServer } = require("./cli_server");
const { PromptSelect } = require("./model_prompt");
const { CliLocal } = require("./cli_local");
const { CliChoose } = require("./cli_choose");
const { CliBuild } = require("./cli_build");

class Choice extends CliChoose {
  constructor(title) {
    super(title);
  }
}

const local = new Choice("local");
const server = new Choice("server");
const build = new Choice("build");
const mode = new Choice("mode");

PromptSelect(
  [local.choice, server.choice, build.choice, mode.choice],
  (_, answer) => {
    local.isMe(answer, CliLocal);
    server.isMe(answer, CliServer.select);
    build.isMe(answer, CliBuild);
    mode.isMe(answer, () => console.log("ini ada dimasna"));
  }
);

// prompts(
//   {
//     type: "select",
//     name: "pilihan",
//     message: "pilih menunya",
//     choices: [
//       choices1("local").choices,
//       choices1("server").choices,
//       choices1("build").choices,
//       choices1("mode").choices,
//     ],
//   },
//   {
//     onSubmit: (_, answer) => {
//       choices1("local").isMe(answer, local);
//       choices1("server").isMe(answer, CliServer.select);
//       choices1("build").isMe(answer, build);
//       choices1("mode").isMe(answer, mode);
//     },
//   }
// );
