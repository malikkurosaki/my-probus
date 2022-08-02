-- CreateTable
CREATE TABLE `JabatanDepartement` (
    `id` VARCHAR(191) NOT NULL,
    `jabatansId` VARCHAR(191) NULL,
    `departementsId` VARCHAR(191) NULL,
    `createdAt` DATETIME(3) NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `JabatanDepartement` ADD CONSTRAINT `JabatanDepartement_departementsId_fkey` FOREIGN KEY (`departementsId`) REFERENCES `Departements`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `JabatanDepartement` ADD CONSTRAINT `JabatanDepartement_jabatansId_fkey` FOREIGN KEY (`jabatansId`) REFERENCES `Jabatan`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;
