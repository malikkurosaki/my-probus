-- CreateTable
CREATE TABLE `IssueHistories` (
    `id` VARCHAR(191) NOT NULL,
    `issuesId` VARCHAR(191) NULL,
    `note` VARCHAR(191) NULL,
    `usersId` VARCHAR(191) NULL,
    `createdAt` DATETIME(3) NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NULL,
    `issueStatusesId` VARCHAR(191) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `IssueHistories` ADD CONSTRAINT `IssueHistories_usersId_fkey` FOREIGN KEY (`usersId`) REFERENCES `Users`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `IssueHistories` ADD CONSTRAINT `IssueHistories_issuesId_fkey` FOREIGN KEY (`issuesId`) REFERENCES `Issues`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `IssueHistories` ADD CONSTRAINT `IssueHistories_issueStatusesId_fkey` FOREIGN KEY (`issueStatusesId`) REFERENCES `IssueStatuses`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;
