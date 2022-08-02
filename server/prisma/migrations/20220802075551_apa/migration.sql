-- CreateTable
CREATE TABLE `UserJabatan` (
    `id` VARCHAR(191) NOT NULL,
    `usersId` VARCHAR(191) NULL,
    `jabatansId` VARCHAR(191) NULL,
    `createdAt` DATETIME(3) NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `UserJabatan` ADD CONSTRAINT `UserJabatan_usersId_fkey` FOREIGN KEY (`usersId`) REFERENCES `Users`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `UserJabatan` ADD CONSTRAINT `UserJabatan_jabatansId_fkey` FOREIGN KEY (`jabatansId`) REFERENCES `Jabatan`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;
