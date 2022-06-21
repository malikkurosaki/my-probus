const Ssh = require("simple-ssh");

const CliSsh = new Ssh({
  host: "makurostudio.my.id",
  user: "makuro",
  pass: "Makuro_123",
});

function Myssh(command) {
  CliSsh.exec(`source .nvm/nvm.sh && ${command}`, {
    out: (data) => console.log(data),
    err: (err) => console.log(err),
  }).start();
}

module.exports = { Myssh };
