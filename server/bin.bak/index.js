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
const { CliGenerate } = require("./cli_generate");

class Choice extends CliChoose {
  constructor(title) {
    super(title);
  }
}

const local = new Choice("local");
const server = new Choice("server");
const build = new Choice("build");
const mode = new Choice("mode");
const generate = new Choice("generate");

PromptSelect(
  [local.choice, server.choice, build.choice, mode.choice, generate.choice],
  (_, answer) => {
    local.isMe(answer, CliLocal);
    server.isMe(answer, CliServer.select);
    build.isMe(answer, CliBuild);
    mode.isMe(answer, () => {});
    generate.isMe(answer, CliGenerate);
  }
);
