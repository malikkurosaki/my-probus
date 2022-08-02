-- CreateTable
CREATE TABLE `_DepartementsToJabatan` (
    `A` VARCHAR(191) NOT NULL,
    `B` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `_DepartementsToJabatan_AB_unique`(`A`, `B`),
    INDEX `_DepartementsToJabatan_B_index`(`B`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `_DepartementsToJabatan` ADD CONSTRAINT `_DepartementsToJabatan_A_fkey` FOREIGN KEY (`A`) REFERENCES `Departements`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_DepartementsToJabatan` ADD CONSTRAINT `_DepartementsToJabatan_B_fkey` FOREIGN KEY (`B`) REFERENCES `Jabatan`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
