const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();

/**
 * open = terbuka
 * accepted = diterima
 * rejected = ditolak atau tidak diterima karena tidak sesuai dengan kriteria
 * inprogress = dalam proses pengerjaan
 * resolved = selesai dengan solusi
 * closed = ditutup tanpa solusi
 * reopened = dibuka kembali dikarenakan update data atau karena ada kesalahan
 * pending = dalam proses pendingan
 * Approved = disetujui untuk naik keatas
 *
 */
const issueStatuses = [
  "open",
  "accepted",
  "rejected",
  "approved",
  "decline",
  "progress",
  "resolved",
  "closed",
  "pending",
  "reopened",
];

//     {
//         id: "1",
//         name: "pending"
//     },
//     {
//         id: "2",
//         name: "rejected"
//     },
//     {
//         id: "3",
//         name: "ongoing"
//     }
// ]

const SeedIssueStatus = async () => {
  let id = 1;
  for (let issueStatus of issueStatuses) {
    await prisma.issueStatuses.upsert({
      where: {
        id: id.toString(),
      },
      update: {
        name: issueStatus,
      },
      create: {
        id: id.toString(),
        name: issueStatus,
      },
    });
    id++;
  }

  console.log("seed issue status success");
};

module.exports = { SeedIssueStatus };
