/*
  Warnings:

  - You are about to drop the `_DepartementsToJabatan` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE `_DepartementsToJabatan` DROP FOREIGN KEY `_DepartementsToJabatan_A_fkey`;

-- DropForeignKey
ALTER TABLE `_DepartementsToJabatan` DROP FOREIGN KEY `_DepartementsToJabatan_B_fkey`;

-- DropTable
DROP TABLE `_DepartementsToJabatan`;
