const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();
const routeIssuePriorit = require("express").Router();

/**
 * primary = utama normalnya atau biasa
 * warning = peringatan butuh perhatian lebih
 * danger = peringatan butuh perhatian lebih besar , dan akan mengakibatkan kegagalan proses selanjutnya
 */
const _item = [
  { value: 1, name: "primary", des: "pilih jika anda rasa adalah yang ringan" },
  {
    value: 2,
    name: "warning",
    des: "pilih jika anda rasa adalah sejenis issue info untuk diketahui",
  },
  {
    value: 3,
    name: "danger",
    des: "pilih jika anda rasa adalah issue penting ",
  },
  // { "value": 4, "name": "warning", "des": "pilih jika anda rasa adalah butuh diperhatikan dan tanggapan segera" },
  // { "value": 5, "name": "danger", "des": "pilih jika anda rasa adalah issue butuh ditangani sesegera mungkin" },
  // { "value": 6, "name": "dark", "des": "pilih jika anda rasa adalah issue sangat serius " },
];

const SeedIssuePriorit = async () => {
  var id = 1;
  for (let itm of _item) {
    await prisma.issuePriorities.upsert({
      where: {
        id: id.toString(),
      },
      update: {
        des: itm["des"],
        name: itm["name"],
        value: itm["value"],
      },
      create: {
        id: id.toString(),
        name: itm["name"],
        des: itm["des"],
        value: itm["value"],
      },
    });

    id++;
  }

  console.log("seed issue priorit success");
};

module.exports = { SeedIssuePriorit };
