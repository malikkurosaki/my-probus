/*
  Warnings:

  - You are about to drop the column `images` on the `Discussion` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE `Discussion` DROP COLUMN `images`,
    ADD COLUMN `imagesId` VARCHAR(191) NULL;

-- AddForeignKey
ALTER TABLE `Discussion` ADD CONSTRAINT `Discussion_imagesId_fkey` FOREIGN KEY (`imagesId`) REFERENCES `Images`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;
