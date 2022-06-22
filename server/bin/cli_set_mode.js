const fs = require("fs");
const path = require("path");

/** @param {("dev_web" | "pro_web" | "dev_mobile" )} modenya */
const CliSetMode = async (modenya) => {
  let devWeb = "http://localhost:3000";
  let proWeb = "https://probus.makurostudio.my.id";
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

  fs.writeFileSync(connFile, target, { encoding: "utf-8" });

  console.log("mode set to " + modenya);
};

module.exports = { CliSetMode };
