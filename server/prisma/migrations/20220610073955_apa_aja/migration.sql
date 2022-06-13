/*
  Warnings:

  - Made the column `usersId` on table `AuthToken` required. This step will fail if there are existing NULL values in that column.

*/
-- DropForeignKey
ALTER TABLE `AuthToken` DROP FOREIGN KEY `AuthToken_usersId_fkey`;

-- AlterTable
ALTER TABLE `AuthToken` MODIFY `usersId` VARCHAR(191) NOT NULL;

-- AddForeignKey
ALTER TABLE `AuthToken` ADD CONSTRAINT `AuthToken_usersId_fkey` FOREIGN KEY (`usersId`) REFERENCES `Users`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
