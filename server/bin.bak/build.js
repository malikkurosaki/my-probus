const prompts = require("prompts");
const path = require("path");

class BuildWebGithub {
  choice = {
    title: "flutter build web github",
    value: "build_web_github",
  };

  action = async (answer) => {
    if (answer === this.choice.value) {
      const { execSync } = require("child_process");
      execSync(
        `cd ${path.join(
          __dirname,
          "./../../client"
        )} && flutter build web --release --base-href '/my-probus/client/build/web/'`,
        { stdio: "inherit" }
      );

      "flutter build web github success".log();

    }
  };
}

class BuildWebServer {
  choice = {
    title: "flutter build web server",
    value: "build_web_server",
  };

  action = async (answer) => {
    if (answer === this.choice.value) {
      const { execSync } = require("child_process");
      execSync(
        `cd ${path.join(
          __dirname,
          "./../../client"
        )} && flutter build web --release`,
        { stdio: "inherit" }
      );

      "build web server success".log();
      
    }
  };
}

class BuildAndroid {
  choice = {
    title: "flutter build android",
    value: "build_android",
  };

  action = async (answer) => {
    if (answer === this.choice.value) {
      const { execSync } = require("child_process");
      execSync(
        `cd ${path.join(
          __dirname,
          "./../../client"
        )} && flutter build apk --release `,
        { stdio: "inherit" }
      );

      "build android success".log();
    }
  };
}

const buildWebGithub = new BuildWebGithub();
const buildWebServer = new BuildWebServer();
const buildAndroid = new BuildAndroid();

class Build {
  choice = {
    title: "build",
    value: "build",
  };

  action = async (answer) => {
    if (answer === this.choice.title) {
      const q = await prompts([
        {
          type: "select",
          name: "build",
          message: "What do you want to do?",
          choices: [
            buildWebGithub.choice,
            buildWebServer.choice,
            buildAndroid.choice,
          ],
        },
      ]);

      buildWebGithub.action(q.build);
      buildWebServer.action(q.build);
      buildAndroid.action(q.build);
    }
  };
}

module.exports = { Build };
