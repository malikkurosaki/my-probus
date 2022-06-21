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

        chooiceBuild("web production").isMe(answer, buildWebProduction);
        chooiceBuild("android").isMe(answer, buildApk);
      },
    }
  );
}

function buildWebProduction() {
  setMode("pro_web");
  buildApk();

  execSync(`cd ${_client} && flutter build web --base-href '/' --release`);
  console.log("build web production done");

  execSync(`git add . && git commit -m "ya" && git push`, { stdio: "inherit" });
  console.log("git push done");

  ssh.exec(`cd my-probus && git pull `).start();
  console.log("git pull from server  done");

  ssh.exec(`pm2 restart all`).start();
  console.log("pm2 restart all done");

  ssh.exec(`pm2 status`).start();

  setMode("dev_web");
  console.log("set mode to dev_web");

  console.log("build dan update server selesai");
}

function buildApk() {
  execSync(`cd ${_client} && flutter build apk --release --split-per-abi`, {
    stdio: "inherit",
  });

  execSync(
    `cp ${path.join(
      __dirname,
      "./../../client/build/app/outputs/apk/release/app-arm64-v8a-release.apk"
    )} ${path.join(__dirname, "./../../server/assets/apk/")}`,
    { stdio: "inherit" }
  );
  console.log("build android done");
}
