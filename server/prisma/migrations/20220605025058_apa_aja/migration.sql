-- AlterTable
ALTER TABLE `Issues` ADD COLUMN `issuePrioritiesId` VARCHAR(191) NULL;

-- CreateTable
CREATE TABLE `IssuePriorities` (
    `id` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `value` INTEGER NOT NULL,
    `des` VARCHAR(191) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `Issues` ADD CONSTRAINT `Issues_issuePrioritiesId_fkey` FOREIGN KEY (`issuePrioritiesId`) REFERENCES `IssuePriorities`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;
