-- AlterTable
ALTER TABLE `Users` ADD COLUMN `departementsId` VARCHAR(191) NULL;

-- AddForeignKey
ALTER TABLE `Users` ADD CONSTRAINT `Users_departementsId_fkey` FOREIGN KEY (`departementsId`) REFERENCES `Departements`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;
