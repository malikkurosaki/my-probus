/*
  Warnings:

  - You are about to drop the `IssueAccepts` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `IssueAssigneds` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `IssueForwardedTo` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `IssueRejecteds` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE `IssueAccepts` DROP FOREIGN KEY `IssueAccepts_issuesId_fkey`;

-- DropForeignKey
ALTER TABLE `IssueAccepts` DROP FOREIGN KEY `IssueAccepts_usersId_fkey`;

-- DropForeignKey
ALTER TABLE `IssueAssigneds` DROP FOREIGN KEY `IssueAssigneds_issuesId_fkey`;

-- DropForeignKey
ALTER TABLE `IssueAssigneds` DROP FOREIGN KEY `IssueAssigneds_usersId_fkey`;

-- DropForeignKey
ALTER TABLE `IssueForwardedTo` DROP FOREIGN KEY `IssueForwardedTo_issuesId_fkey`;

-- DropForeignKey
ALTER TABLE `IssueForwardedTo` DROP FOREIGN KEY `IssueForwardedTo_usersId_fkey`;

-- DropForeignKey
ALTER TABLE `IssueRejecteds` DROP FOREIGN KEY `IssueRejecteds_issuesId_fkey`;

-- DropForeignKey
ALTER TABLE `IssueRejecteds` DROP FOREIGN KEY `IssueRejecteds_usersId_fkey`;

-- DropTable
DROP TABLE `IssueAccepts`;

-- DropTable
DROP TABLE `IssueAssigneds`;

-- DropTable
DROP TABLE `IssueForwardedTo`;

-- DropTable
DROP TABLE `IssueRejecteds`;
