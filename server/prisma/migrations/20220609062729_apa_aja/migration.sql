/*
  Warnings:

  - Added the required column `usersId` to the `Images` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `Images` ADD COLUMN `usersId` VARCHAR(191) NOT NULL;

-- AddForeignKey
ALTER TABLE `Images` ADD CONSTRAINT `Images_usersId_fkey` FOREIGN KEY (`usersId`) REFERENCES `Users`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
