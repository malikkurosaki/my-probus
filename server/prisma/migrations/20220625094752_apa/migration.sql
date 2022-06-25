/*
  Warnings:

  - You are about to drop the column `submitDate` on the `Issues` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE `Issues` DROP COLUMN `submitDate`,
    ADD COLUMN `dateSubmit` DATETIME(3) NULL;
