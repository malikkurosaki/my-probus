-- DropForeignKey
ALTER TABLE `Images` DROP FOREIGN KEY `Images_usersId_fkey`;

-- AlterTable
ALTER TABLE `Images` MODIFY `url` VARCHAR(191) NULL,
    MODIFY `usersId` VARCHAR(191) NULL;

-- AddForeignKey
ALTER TABLE `Images` ADD CONSTRAINT `Images_usersId_fkey` FOREIGN KEY (`usersId`) REFERENCES `Users`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;
