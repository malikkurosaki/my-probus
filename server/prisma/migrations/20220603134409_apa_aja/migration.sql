/*
  Warnings:

  - A unique constraint covering the columns `[usersId]` on the table `Profiles` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[positionsId]` on the table `Profiles` will be added. If there are existing duplicate values, this will fail.

*/
-- AlterTable
ALTER TABLE `Issues` ADD COLUMN `clientsId` VARCHAR(191) NULL,
    ADD COLUMN `createdAt` DATETIME(3) NULL DEFAULT CURRENT_TIMESTAMP(3),
    ADD COLUMN `issueStatusesId` VARCHAR(191) NULL,
    ADD COLUMN `issueTypesId` VARCHAR(191) NULL,
    ADD COLUMN `productsId` VARCHAR(191) NULL,
    ADD COLUMN `updatedAt` DATETIME(3) NULL DEFAULT CURRENT_TIMESTAMP(3),
    ADD COLUMN `usersId` VARCHAR(191) NULL;

-- AlterTable
ALTER TABLE `Positions` ADD COLUMN `departementsId` VARCHAR(191) NULL;

-- AlterTable
ALTER TABLE `Profiles` ADD COLUMN `positionsId` VARCHAR(191) NULL,
    ADD COLUMN `rolesId` VARCHAR(191) NULL,
    ADD COLUMN `usersId` VARCHAR(191) NULL;

-- CreateTable
CREATE TABLE `IssueAccepts` (
    `id` VARCHAR(191) NOT NULL,
    `issuesId` VARCHAR(191) NULL,
    `createdAt` DATETIME(3) NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NULL DEFAULT CURRENT_TIMESTAMP(3),
    `usersId` VARCHAR(191) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `IssueForwardedTo` (
    `id` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NULL DEFAULT CURRENT_TIMESTAMP(3),
    `usersId` VARCHAR(191) NULL,
    `issuesId` VARCHAR(191) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `IssueRejecteds` (
    `id` VARCHAR(191) NOT NULL,
    `note` VARCHAR(191) NOT NULL,
    `issuesId` VARCHAR(191) NULL,
    `usersId` VARCHAR(191) NULL,
    `createdAt` DATETIME(3) NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `IssueAssigneds` (
    `id` VARCHAR(191) NOT NULL,
    `note` VARCHAR(191) NOT NULL,
    `issuesId` VARCHAR(191) NULL,
    `usersId` VARCHAR(191) NULL,
    `createdAt` DATETIME(3) NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateIndex
CREATE UNIQUE INDEX `Profiles_usersId_key` ON `Profiles`(`usersId`);

-- CreateIndex
CREATE UNIQUE INDEX `Profiles_positionsId_key` ON `Profiles`(`positionsId`);

-- AddForeignKey
ALTER TABLE `Profiles` ADD CONSTRAINT `Profiles_usersId_fkey` FOREIGN KEY (`usersId`) REFERENCES `Users`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Profiles` ADD CONSTRAINT `Profiles_positionsId_fkey` FOREIGN KEY (`positionsId`) REFERENCES `Positions`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Profiles` ADD CONSTRAINT `Profiles_rolesId_fkey` FOREIGN KEY (`rolesId`) REFERENCES `Roles`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Positions` ADD CONSTRAINT `Positions_departementsId_fkey` FOREIGN KEY (`departementsId`) REFERENCES `Departements`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Issues` ADD CONSTRAINT `Issues_usersId_fkey` FOREIGN KEY (`usersId`) REFERENCES `Users`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Issues` ADD CONSTRAINT `Issues_issueTypesId_fkey` FOREIGN KEY (`issueTypesId`) REFERENCES `IssueTypes`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Issues` ADD CONSTRAINT `Issues_issueStatusesId_fkey` FOREIGN KEY (`issueStatusesId`) REFERENCES `IssueStatuses`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Issues` ADD CONSTRAINT `Issues_clientsId_fkey` FOREIGN KEY (`clientsId`) REFERENCES `Clients`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Issues` ADD CONSTRAINT `Issues_productsId_fkey` FOREIGN KEY (`productsId`) REFERENCES `Products`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `IssueAccepts` ADD CONSTRAINT `IssueAccepts_usersId_fkey` FOREIGN KEY (`usersId`) REFERENCES `Users`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `IssueAccepts` ADD CONSTRAINT `IssueAccepts_issuesId_fkey` FOREIGN KEY (`issuesId`) REFERENCES `Issues`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `IssueForwardedTo` ADD CONSTRAINT `IssueForwardedTo_usersId_fkey` FOREIGN KEY (`usersId`) REFERENCES `Users`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `IssueForwardedTo` ADD CONSTRAINT `IssueForwardedTo_issuesId_fkey` FOREIGN KEY (`issuesId`) REFERENCES `Issues`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `IssueRejecteds` ADD CONSTRAINT `IssueRejecteds_usersId_fkey` FOREIGN KEY (`usersId`) REFERENCES `Users`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `IssueRejecteds` ADD CONSTRAINT `IssueRejecteds_issuesId_fkey` FOREIGN KEY (`issuesId`) REFERENCES `Issues`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `IssueAssigneds` ADD CONSTRAINT `IssueAssigneds_usersId_fkey` FOREIGN KEY (`usersId`) REFERENCES `Users`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `IssueAssigneds` ADD CONSTRAINT `IssueAssigneds_issuesId_fkey` FOREIGN KEY (`issuesId`) REFERENCES `Issues`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;
