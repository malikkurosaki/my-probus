-- AlterTable
ALTER TABLE `Issues` ADD COLUMN `departementsId` VARCHAR(191) NULL;

-- AddForeignKey
ALTER TABLE `Issues` ADD CONSTRAINT `Issues_departementsId_fkey` FOREIGN KEY (`departementsId`) REFERENCES `Departements`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;
