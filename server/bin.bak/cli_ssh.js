const Ssh = require("simple-ssh");

const conn = new Ssh({
  host: "makurostudio.my.id",
  user: "makuro",
  pass: "Makuro_123",
});

function CliSsh(command) {
  try {
    conn.exec(`source .nvm/nvm.sh && ${command}`, {
      out: (data) => console.log(data),
      err: (err) => console.log(err),
    }).start();
  } catch (error) {
    throw error;
  }
}

module.exports = { CliSsh };
