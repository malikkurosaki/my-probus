-- CreateTable
CREATE TABLE `UserDepartement` (
    `id` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `_UserDepartementToUsers` (
    `A` VARCHAR(191) NOT NULL,
    `B` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `_UserDepartementToUsers_AB_unique`(`A`, `B`),
    INDEX `_UserDepartementToUsers_B_index`(`B`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `_DepartementsToUserDepartement` (
    `A` VARCHAR(191) NOT NULL,
    `B` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `_DepartementsToUserDepartement_AB_unique`(`A`, `B`),
    INDEX `_DepartementsToUserDepartement_B_index`(`B`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `_UserDepartementToUsers` ADD CONSTRAINT `_UserDepartementToUsers_A_fkey` FOREIGN KEY (`A`) REFERENCES `UserDepartement`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_UserDepartementToUsers` ADD CONSTRAINT `_UserDepartementToUsers_B_fkey` FOREIGN KEY (`B`) REFERENCES `Users`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_DepartementsToUserDepartement` ADD CONSTRAINT `_DepartementsToUserDepartement_A_fkey` FOREIGN KEY (`A`) REFERENCES `Departements`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_DepartementsToUserDepartement` ADD CONSTRAINT `_DepartementsToUserDepartement_B_fkey` FOREIGN KEY (`B`) REFERENCES `UserDepartement`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
