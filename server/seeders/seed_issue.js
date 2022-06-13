const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();

/**@returns {number} */
function acak(a, b) {
  return Math.floor(Math.random() * b) + a;
}

const issues = [
  "cek report history delete paidbill masih di gunakan atau tidak skrg di presto",
  "Muncul pesan kolom kode_out sfecified twice saat save transaksi di input invoice AR",
  "Pesan error saat pilih tidak kena pajak di master supplier (sudah showing ke group request)",
  "hpp tidak update di master stock untuk yg isi recepi ",
  "muncul pesan error sumary band too large ketika buka FB sales detail di satu pc saja",
  "Tidak bisa buka virtual box, sudah sempat share di office solid tapi belum menemukan solusi",
  "aktifkan system presto Bar & Grill (belum ada konfirmasi dari client)",
  "Tes exe presto pendingan TG",
  "Update exe terbaru ",
];

// const listIssue = [
//     {
//         "name": "",
//         "des": "",
//         "issueTypesId": acak(1, 2).toString(),
//         "clientsId": acak(1, 10).toString(),
//         "productsId": acak(1, 4).toString(),
//         "usersId": "",
//         "issuePrioritiesId": "",
//         "departementsId": "",
//     }
// ]

const SeedIssue = async () => {
  let id = 1;

  for (let issue of issues) {
    await prisma.issues.upsert({
      where: {
        id: id.toString(),
      },
      update: {
        name: issue,
        des: issue,
        issueTypesId: acak(1, 6).toString(),
        clientsId: acak(1, 10).toString(),
        productsId: acak(1, 4).toString(),
        usersId: acak(1, 10).toString(),
        departementsId: acak(1, 3).toString(),
        issueStatusesId: "1",
      },
      create: {
        id: id.toString(),
        name: issue,
        des: issue,
        issueTypesId: acak(1, 6).toString(),
        clientsId: acak(1, 10).toString(),
        productsId: acak(1, 4).toString(),
        usersId: acak(1, 10).toString(),
        departementsId: acak(1, 3).toString(),
        issueStatusesId: "1",
      },
    });
    id++;
  }

  console.log("seed issue success");
};

module.exports = { SeedIssue };
