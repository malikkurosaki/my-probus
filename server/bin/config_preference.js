const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();
const prompts = require("prompts");
const _lokasiPref = __dirname + "/../pref/pref.json";
const _pref = require(_lokasiPref);
const fs = require("fs");

const Preference = async () => {
  const users = await prisma.users.findMany({
    select: {
      id: true,
      name: true,
    },
  });

  const roles = await prisma.roles.findMany({
    select: {
      id: true,
      name: true,
    },
  });

  const menu = await prompts({
    type: "select",
    name: "pilihan",
    message: "pilih menunya",
    choices: roles.map((e) => {
      return {
        title: e.name,
        value: e.name,
      };
    }),
  });

  PilihanUser(users, menu.pilihan, roles);
};

const PilihanUser = async (users, name, roles) => {
  let pilihan = await prompts({
    type: "multiselect",
    active: [],
    name: "user",
    message: "piliha usernya yang akan dijadikan leader",
    choices: users.map((e) => {
      return {
        title: e.name,
        value: e.id,
        selected: (_pref[name]??[]).includes(e.id) ?? false,
      };
    }),
  });

  if (pilihan.user) {
    _pref[name] = pilihan.user;
    fs.writeFileSync(_lokasiPref, JSON.stringify(_pref, null, 2), {
      encoding: "utf-8",
    });
    console.log(`set ${name} berhasil`);
  } else {
    console.log("ok batal");
  }
};

module.exports = { Preference };
