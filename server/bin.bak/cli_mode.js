


function select() {
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