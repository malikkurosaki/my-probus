-- MySQL dump 10.13  Distrib 8.0.29, for Linux (x86_64)
--
-- Host: localhost    Database: myprobus
-- ------------------------------------------------------
-- Server version	8.0.29-0ubuntu0.22.04.2

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `AuthToken`
--

DROP TABLE IF EXISTS `AuthToken`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AuthToken` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updatedAt` datetime(3) NOT NULL,
  `expiresAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `usersId` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `AuthToken_usersId_fkey` (`usersId`),
  CONSTRAINT `AuthToken_usersId_fkey` FOREIGN KEY (`usersId`) REFERENCES `Users` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AuthToken`
--

LOCK TABLES `AuthToken` WRITE;
/*!40000 ALTER TABLE `AuthToken` DISABLE KEYS */;
INSERT INTO `AuthToken` VALUES ('066e6d7c-d9ce-4611-b530-64ce187be639','2022-06-27 06:53:40.426','2022-06-27 06:53:40.427','2022-06-27 06:53:40.426','15'),('1be777b8-ce5f-4e20-a98a-e4ba7b6ec6f5','2022-06-27 03:00:33.576','2022-06-27 03:00:33.579','2022-06-27 03:00:33.578','15'),('2b84afa4-e673-4525-bc7b-a3de52364eb6','2022-06-27 06:28:30.343','2022-06-27 06:28:30.344','2022-06-27 06:28:30.343','15'),('403445a7-eb2b-474b-99cb-760ec4f1e8b1','2022-06-27 05:19:03.341','2022-06-27 05:19:03.342','2022-06-27 05:19:03.341','1'),('4ba5db91-3bca-46f5-bc35-d157e4c06548','2022-06-27 08:31:23.910','2022-06-27 08:31:23.911','2022-06-27 08:31:23.910','5'),('5d97ad00-6022-4c59-b06d-8c1199aa688c','2022-06-27 03:10:38.336','2022-06-27 03:10:38.336','2022-06-27 03:10:38.336','15'),('760571f4-463d-486c-82c2-f478b0fc7916','2022-06-28 02:39:55.442','2022-06-28 02:39:55.442','2022-06-28 02:39:55.442','7'),('91cb4f73-feef-461a-a4b2-d0383bc3cda3','2022-06-27 01:50:18.042','2022-06-27 01:50:18.042','2022-06-27 01:50:18.042','4'),('926feb96-8718-4d87-97cd-a96067838bea','2022-06-27 03:06:28.565','2022-06-27 03:06:28.565','2022-06-27 03:06:28.565','15'),('930fa9dd-3989-4a36-bcae-2bcb45528cb6','2022-06-25 16:49:03.534','2022-06-25 16:49:03.535','2022-06-25 16:49:03.533','4'),('97719087-4da6-43d4-89ba-ac4c2dc9672c','2022-06-27 08:21:29.103','2022-06-27 08:21:29.104','2022-06-27 08:21:29.103','11'),('af19b52a-95c3-4a03-9da2-707f018bddc2','2022-06-27 02:04:52.703','2022-06-27 02:04:52.704','2022-06-27 02:04:52.703','15'),('c4d08fbc-ef8e-4a4f-9ada-947e85d8b751','2022-06-27 04:30:55.491','2022-06-27 04:30:55.491','2022-06-27 04:30:55.491','7'),('c9e6a1a0-e4f4-44cc-a4e0-81e7216d2ba8','2022-06-27 06:14:18.507','2022-06-27 06:14:18.508','2022-06-27 06:14:18.507','15'),('e8899e6a-cb6d-49d7-8f23-f8a4aab3ca17','2022-06-27 06:14:50.624','2022-06-27 06:14:50.624','2022-06-27 06:14:50.624','15'),('ebd13ca1-6ff7-41a3-aa0f-a3260d81bcad','2022-06-27 04:18:13.564','2022-06-27 04:18:13.564','2022-06-27 04:18:13.564','7'),('f559d893-c0d1-4897-8eeb-2d13dde53e95','2022-06-27 08:28:23.261','2022-06-27 08:28:23.262','2022-06-27 08:28:23.261','7');
/*!40000 ALTER TABLE `AuthToken` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Clients`
--

DROP TABLE IF EXISTS `Clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Clients` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Clients`
--

LOCK TABLES `Clients` WRITE;
/*!40000 ALTER TABLE `Clients` DISABLE KEYS */;
INSERT INTO `Clients` VALUES ('1','ABIA VILLA ',NULL,NULL,NULL),('10','BLACK PENNY VILLA UBUD ',NULL,NULL,NULL),('100','WARUNG JEMBUNG ',NULL,NULL,NULL),('101','WASABI HOTEL & RESTO ',NULL,NULL,NULL),('102','FIRDAUS MART 1',NULL,NULL,NULL),('103','FIRDAUS MART 2',NULL,NULL,NULL),('104','APOTIK IMA',NULL,NULL,NULL),('105','COCO ROTI',NULL,NULL,NULL),('106','HOLDING GOSHA',NULL,NULL,NULL),('107','TOKO SUAR',NULL,NULL,NULL),('108','WARUNG MINA STORE',NULL,NULL,NULL),('109','UD JOGLO MART',NULL,NULL,NULL),('11','BRACHA VILLA ',NULL,NULL,NULL),('110','SECURITETCH MAKASSAR ',NULL,NULL,NULL),('111','SCALLYWAGS DIVING CENTER',NULL,NULL,NULL),('112','SECURITETCH JOGJA',NULL,NULL,NULL),('113','NATYA HOTEL KUTA',NULL,NULL,NULL),('114','WARUNG MINA STORE',NULL,NULL,NULL),('115','SCALLYWAGS RESORT GA ',NULL,NULL,NULL),('116','SECURITECH BALI',NULL,NULL,NULL),('117','SCALLYWAGS DIVE GT',NULL,NULL,NULL),('118','FREEDIVE',NULL,NULL,NULL),('12','CALM VILLA ',NULL,NULL,NULL),('13','DEDARI VILLAS UBUD ',NULL,NULL,NULL),('14','DESA DUNIA BEDA ',NULL,NULL,NULL),('15','DRIAM RIVERSIDE ',NULL,NULL,NULL),('16','ECO TREE O\'TEL ',NULL,NULL,NULL),('17','EL-TROPICO ',NULL,NULL,NULL),('18','GILI ECO ',NULL,NULL,NULL),('19','GILI SAND BEACH RESORT ',NULL,NULL,NULL),('2','ALAMI LUXURY VILLA ',NULL,NULL,NULL),('20','HOTEL MINA PLAZA KUTA ',NULL,NULL,NULL),('21','HOTEL MINA TANJUNG ',NULL,NULL,NULL),('22','HOTEL SINAR BALI ',NULL,NULL,NULL),('23','HOTEL SUNRISE ',NULL,NULL,NULL),('24','KOKOMO GILI TRAWANGAN ',NULL,NULL,NULL),('25','LAROJA BUNGALOW ',NULL,NULL,NULL),('26','MEDEWI RETREAT ',NULL,NULL,NULL),('27','MENZEL UBUD ',NULL,NULL,NULL),('28','PINK COCO BALI ',NULL,NULL,NULL),('29','PINK COCO GILI AIR ',NULL,NULL,NULL),('3','ARMA RESORT ',NULL,NULL,NULL),('30','PINK COCO HOTEL ',NULL,NULL,NULL),('31','PONDOK SANTI ',NULL,NULL,NULL),('32','PURI MAS RESORT ',NULL,NULL,NULL),('33','RELAX BALI HOTEL ',NULL,NULL,NULL),('34','RESTU BALI HOTEL ',NULL,NULL,NULL),('35','SAMAJA KUBU PESISI ',NULL,NULL,NULL),('36','SAMAJA ROYAL ',NULL,NULL,NULL),('37','SAMAJA VILLA KUNTI ',NULL,NULL,NULL),('38','SCAMPY RESORT ',NULL,NULL,NULL),('39','SEGARA ANAK HOTEL ',NULL,NULL,NULL),('4','BALI TAMAN LOVINA ',NULL,NULL,NULL),('40','SMK RATNA WARTHA UBUD ',NULL,NULL,NULL),('41','SUMMER VILLE ',NULL,NULL,NULL),('42','THE BEACH HOUSE RESORT  ',NULL,NULL,NULL),('43','THE KOHO HOTEL ',NULL,NULL,NULL),('44','THE SWELL HOSTEL & RESTAURANT ',NULL,NULL,NULL),('45','UBUD PADI VILLA ',NULL,NULL,NULL),('46','ULUWATU COTTAGE ',NULL,NULL,NULL),('47','WAI ECO RESORT ',NULL,NULL,NULL),('48','WASABI HOTEL & RESTO ',NULL,NULL,NULL),('49','BEYONDA BALI RESTAURANT ',NULL,NULL,NULL),('5','BEBEK TEPI SAWAH ',NULL,NULL,NULL),('50','BLUE MARLIN DIVE RESTO ',NULL,NULL,NULL),('51','CHICAGO\'S PIZZA TWIST ',NULL,NULL,NULL),('52','COCO CAFÉ HOLDING ',NULL,NULL,NULL),('53','CP LOUNGE ',NULL,NULL,NULL),('54','HAPPY CHAPPY DSM ',NULL,NULL,NULL),('55','KAYU CAFÉ ',NULL,NULL,NULL),('56','KEDAI KESAR ',NULL,NULL,NULL),('57','LAMIS MY WARUNG ',NULL,NULL,NULL),('58','MADU RESTO UBUD ',NULL,NULL,NULL),('59','NATRABU NUSA DUA ',NULL,NULL,NULL),('6','BESAKIH BEACH HOTEL ',NULL,NULL,NULL),('60','NATRABU SANUR ',NULL,NULL,NULL),('61','NATYS CAFÉ JIMBARAN ',NULL,NULL,NULL),('62','NATYS SEMINYAK ',NULL,NULL,NULL),('63','NATYS SILIGITA ',NULL,NULL,NULL),('64','NEMESIS RESTAURANT ',NULL,NULL,NULL),('65','NEO KEDATON MALANG ',NULL,NULL,NULL),('66','ONE PLACE ',NULL,NULL,NULL),('67','PT. BHOJANA CIPTAHITA (BCC) ',NULL,NULL,NULL),('68','PT. BHOJANA CIPTAHITA (BCC) JAKARTA ',NULL,NULL,NULL),('69','PT. TAURUS GEMILANG ',NULL,NULL,NULL),('7','BINTANG BUNGALOWS ',NULL,NULL,NULL),('70','PURI MAS RESORT ',NULL,NULL,NULL),('71','SENDOK - NYOMAN BEER GARDEN ',NULL,NULL,NULL),('72','SENDOK - POSER ',NULL,NULL,NULL),('73','SENDOK EMAS ',NULL,NULL,NULL),('74','SENDOK SQUARE ',NULL,NULL,NULL),('75','SUKA ESPRESSO BRAWA ',NULL,NULL,NULL),('76','SUKA ESPRESSO CAFÉ  ',NULL,NULL,NULL),('77','SUKA ESPRESSO UBUD ',NULL,NULL,NULL),('78','TG GROUP - BAKSO AFUNG ',NULL,NULL,NULL),('79','TG GROUP - BOLU JADUL BALI ',NULL,NULL,NULL),('8','BINTANG HOSTEL ',NULL,NULL,NULL),('80','TG GROUP - FOOD CORNER 1 ',NULL,NULL,NULL),('81','TG GROUP - FOOD CORNER 2 ',NULL,NULL,NULL),('82','TG GROUP - MADE\'S WARUNG INTER ',NULL,NULL,NULL),('83','TG GROUP - REVOLVER COFFEE ',NULL,NULL,NULL),('84','TG GROUP - SOTOKU ',NULL,NULL,NULL),('85','TG GROUP - WARUNG KOFFIE BATAVIA ',NULL,NULL,NULL),('86','TG GROUP - WARUNG MADE ',NULL,NULL,NULL),('87','TG GROUP - WING MAN ',NULL,NULL,NULL),('88','TG GROUP - WISHING WELL ',NULL,NULL,NULL),('89','THE BANYAN TREE ',NULL,NULL,NULL),('9','BINTANG PENIDA RESORT ',NULL,NULL,NULL),('90','THE OFFICE BAR AND RESTO ',NULL,NULL,NULL),('91','THE PLUMBERS ARMS ',NULL,NULL,NULL),('92','THE SAND BEACH BAR & GRILL ',NULL,NULL,NULL),('93','TIRNANOG ',NULL,NULL,NULL),('94','TIS CAFÉ ',NULL,NULL,NULL),('95','TRATORIA SANUR ',NULL,NULL,NULL),('96','TROPICAL - COCO SANUR ',NULL,NULL,NULL),('97','TROPICAL - OFFICE COCO BISTRO ',NULL,NULL,NULL),('98','TROPICAL - TROPICAL UBUD ',NULL,NULL,NULL),('99','VIA EMILIA RESTO ',NULL,NULL,NULL);
/*!40000 ALTER TABLE `Clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ContactPersons`
--

DROP TABLE IF EXISTS `ContactPersons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ContactPersons` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `clientsId` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ContactPersons_clientsId_fkey` (`clientsId`),
  CONSTRAINT `ContactPersons_clientsId_fkey` FOREIGN KEY (`clientsId`) REFERENCES `Clients` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ContactPersons`
--

LOCK TABLES `ContactPersons` WRITE;
/*!40000 ALTER TABLE `ContactPersons` DISABLE KEYS */;
/*!40000 ALTER TABLE `ContactPersons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Departements`
--

DROP TABLE IF EXISTS `Departements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Departements` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Departements`
--

LOCK TABLES `Departements` WRITE;
/*!40000 ALTER TABLE `Departements` DISABLE KEYS */;
INSERT INTO `Departements` VALUES ('1','IT'),('10','Sales'),('11','Front Office'),('2','HR'),('3','Finance'),('4','Marketing'),('5','Sales'),('6','Production'),('7','Admin'),('8','Accounting'),('9','Customer Service');
/*!40000 ALTER TABLE `Departements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Discussion`
--

DROP TABLE IF EXISTS `Discussion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Discussion` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `issuesId` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `usersId` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdAt` datetime(3) DEFAULT CURRENT_TIMESTAMP(3),
  `updatedAt` datetime(3) DEFAULT NULL,
  `imagesId` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Discussion_usersId_fkey` (`usersId`),
  KEY `Discussion_issuesId_fkey` (`issuesId`),
  KEY `Discussion_imagesId_fkey` (`imagesId`),
  CONSTRAINT `Discussion_imagesId_fkey` FOREIGN KEY (`imagesId`) REFERENCES `Images` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `Discussion_issuesId_fkey` FOREIGN KEY (`issuesId`) REFERENCES `Issues` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `Discussion_usersId_fkey` FOREIGN KEY (`usersId`) REFERENCES `Users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Discussion`
--

LOCK TABLES `Discussion` WRITE;
/*!40000 ALTER TABLE `Discussion` DISABLE KEYS */;
INSERT INTO `Discussion` VALUES ('4b1678f7-689f-49e2-b6cd-e8f9690ab1b7','pending - tadi input pembelian >15 item - save, lalu langsung klik NEW tanpa close form, input lagi pembelian > 15 item  saat save yg ke tiga atau ke 4 kalau ga salah baru muncul out of range','f86d3538-303a-42fc-990b-f59d5b6e09ec','7','2022-06-27 07:00:57.181','2022-06-27 07:00:57.181',NULL),('6026057c-744c-49f2-b7bb-04a16d2b9c44','bjbhbhbh','f2d2562c-cd88-4f56-bcc3-25440c972f2f','7','2022-06-28 05:54:16.582','2022-06-28 05:54:16.582',NULL),('7fb3d0aa-7850-435d-8013-91fd57493f72','aku test dengan exe baru juga sama sama hasil nya ','f86d3538-303a-42fc-990b-f59d5b6e09ec','7','2022-06-27 07:02:14.233','2022-06-27 07:02:14.233',NULL),('b6984c50-4dda-4f83-93dd-e239a3c7beb4','jadi terakhir seperti ini case nya di klien, dia input langsung dr tombol new langsung, setelah input beberapa kali > 15 item baru muncul pesan error out of range nya ','f86d3538-303a-42fc-990b-f59d5b6e09ec','7','2022-06-27 07:02:00.971','2022-06-27 07:02:00.971',NULL);
/*!40000 ALTER TABLE `Discussion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Images`
--

DROP TABLE IF EXISTS `Images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Images` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `issuesId` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `usersId` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Images_usersId_fkey` (`usersId`),
  KEY `Images_issuesId_fkey` (`issuesId`),
  CONSTRAINT `Images_issuesId_fkey` FOREIGN KEY (`issuesId`) REFERENCES `Issues` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `Images_usersId_fkey` FOREIGN KEY (`usersId`) REFERENCES `Users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Images`
--

LOCK TABLES `Images` WRITE;
/*!40000 ALTER TABLE `Images` DISABLE KEYS */;
INSERT INTO `Images` VALUES ('05def8a7-93bb-47bc-abf4-c3d904d1714c','f5c07cc3-70ee-4c29-9810-7c57c3022a0d.png',NULL,'86304116-95ca-41d2-92fa-2e9b214a38d7',NULL),('10795677-e31e-49a9-9e55-4753126fe179','15a0f2fd-5a29-45be-b170-3d8b450fa9b7.png',NULL,NULL,NULL),('891a9d3f-acf2-4931-84e5-e4f122025596','6204249a-8d44-465d-a794-76f4a39d00ee.png',NULL,'86304116-95ca-41d2-92fa-2e9b214a38d7',NULL),('e5edfb08-4542-45f6-a5f4-3422552248fb','49d16d7d-e5b0-4613-8d65-1b396e21188f.png',NULL,NULL,NULL);
/*!40000 ALTER TABLE `Images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `IssueHistories`
--

DROP TABLE IF EXISTS `IssueHistories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `IssueHistories` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `issuesId` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `note` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `usersId` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdAt` datetime(3) DEFAULT CURRENT_TIMESTAMP(3),
  `updatedAt` datetime(3) DEFAULT NULL,
  `issueStatusesId` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IssueHistories_usersId_fkey` (`usersId`),
  KEY `IssueHistories_issuesId_fkey` (`issuesId`),
  KEY `IssueHistories_issueStatusesId_fkey` (`issueStatusesId`),
  CONSTRAINT `IssueHistories_issuesId_fkey` FOREIGN KEY (`issuesId`) REFERENCES `Issues` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `IssueHistories_issueStatusesId_fkey` FOREIGN KEY (`issueStatusesId`) REFERENCES `IssueStatuses` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `IssueHistories_usersId_fkey` FOREIGN KEY (`usersId`) REFERENCES `Users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `IssueHistories`
--

LOCK TABLES `IssueHistories` WRITE;
/*!40000 ALTER TABLE `IssueHistories` DISABLE KEYS */;
INSERT INTO `IssueHistories` VALUES ('0d837a6c-9287-456e-8d37-a8e8dbd4f29e','044d5ec8-b324-4858-bfa2-681b0504a6b3','follow up team ','1','2022-06-28 05:06:47.296','2022-06-28 05:06:47.297','5'),('11709ebb-5df1-451e-a66e-82c3ff7b2dd3','044d5ec8-b324-4858-bfa2-681b0504a6b3','yes','7','2022-06-27 08:11:38.311','2022-06-27 08:11:38.312','2'),('1ebe7179-c546-4f3b-80a0-73e983240fb0','9e1f5161-81d6-4332-8b82-1df8ee87d853','follow up team ','1','2022-06-28 05:07:16.162','2022-06-28 05:07:16.163','5'),('25648364-b6e8-445b-a0f3-035501e0ab92','d9899e9b-f73c-4e9d-b0f4-d087759240ab','yes','7','2022-06-27 07:40:52.760','2022-06-27 07:40:52.761','2'),('293a4bd5-6f5d-4cd6-a2dd-b4eb6d267361','13503c4e-ab4e-4a49-b295-c567aecfa580','','1','2022-06-28 05:03:29.817','2022-06-28 05:03:29.817','4'),('319a543d-36fa-4206-a10a-baa332cd1561','6bfcf0da-2d4d-440f-95ab-11e5e72c7f56','','1','2022-06-28 05:00:57.536','2022-06-28 05:00:57.537','4'),('50d275c9-f97c-4d58-8ad2-1dc01e5c72bf','f86d3538-303a-42fc-990b-f59d5b6e09ec','','1','2022-06-28 05:08:24.589','2022-06-28 05:08:24.589','4'),('5f33f073-f962-429c-b4d1-48f6323a9e22','13503c4e-ab4e-4a49-b295-c567aecfa580','','1','2022-06-28 05:03:21.964','2022-06-28 05:03:21.965','4'),('64013eec-16d8-4d31-8101-ccb05fa9323d','1287a323-2485-4cc8-a0d3-eef88aadf0b8','','1','2022-06-28 04:45:34.652','2022-06-28 04:45:34.654','4'),('6413b44a-12a7-4304-b28e-abbe0221337f','f2d2562c-cd88-4f56-bcc3-25440c972f2f','double','7','2022-06-28 02:02:49.902','2022-06-28 02:02:49.903','3'),('695b4e24-921e-422e-8787-b484f6c7492b','6bfcf0da-2d4d-440f-95ab-11e5e72c7f56','yes','7','2022-06-27 08:51:48.653','2022-06-27 08:51:48.653','2'),('6d2af243-d7d6-4fd9-8785-97fa20e40e45','6bfcf0da-2d4d-440f-95ab-11e5e72c7f56','','1','2022-06-28 05:00:57.174','2022-06-28 05:00:57.175','4'),('786522a8-caa1-4f00-a92e-99d86d8182fc','86304116-95ca-41d2-92fa-2e9b214a38d7','yes','7','2022-06-27 08:54:38.192','2022-06-27 08:54:38.193','2'),('7e7f7a1b-5998-4df3-8ad7-f6cdc2592d24','13503c4e-ab4e-4a49-b295-c567aecfa580','yes','7','2022-06-27 08:11:54.025','2022-06-27 08:11:54.026','2'),('808a8655-c750-4708-be8d-6b57f066d50d','6bfcf0da-2d4d-440f-95ab-11e5e72c7f56','','1','2022-06-28 05:00:57.180','2022-06-28 05:00:57.181','4'),('83f40c28-6f4d-4bc2-88cd-eae2d07c37ae','6bfcf0da-2d4d-440f-95ab-11e5e72c7f56','','1','2022-06-28 05:00:57.198','2022-06-28 05:00:57.199','4'),('8b7dba56-3103-4170-9b56-5dd99fc1bdf6','3d01f9ed-fa8d-420c-a0d2-67c8cccb5aa1','yes','7','2022-06-27 08:18:27.276','2022-06-27 08:18:27.277','2'),('8c898505-5541-44dc-a627-a3be4b82cc56','9e1f5161-81d6-4332-8b82-1df8ee87d853','follow up team ','1','2022-06-28 05:07:14.059','2022-06-28 05:07:14.060','5'),('9308e7ea-27e1-42f5-a655-e3e7723598be','1287a323-2485-4cc8-a0d3-eef88aadf0b8','yes','7','2022-06-28 02:03:14.982','2022-06-28 02:03:14.983','2'),('99e739b0-bc74-4bbd-b747-e72210d2e998','6bfcf0da-2d4d-440f-95ab-11e5e72c7f56','','1','2022-06-28 05:01:52.601','2022-06-28 05:01:52.602','4'),('a2953a6d-1dd8-43ce-a2ad-aed3c14cd43d','9e1f5161-81d6-4332-8b82-1df8ee87d853','yes','7','2022-06-27 07:43:02.832','2022-06-27 07:43:02.832','2'),('b8f88c4e-b21d-4c69-bded-ccf6260c219a','f2d2562c-cd88-4f56-bcc3-25440c972f2f','cxcc','7','2022-06-28 05:54:38.073','2022-06-28 05:54:38.073','2'),('c19faa43-7113-4f1a-a63d-712474a4ef19','2c11dff0-15ef-49b1-bf92-bc302b5cd312','yes','7','2022-06-27 08:07:17.944','2022-06-27 08:07:17.944','2'),('c28d8162-1741-4fc1-a839-b4841988e5c0','f86d3538-303a-42fc-990b-f59d5b6e09ec','tolong di cek','7','2022-06-27 07:07:27.486','2022-06-27 07:07:27.489','2'),('cef0c2e5-3e7c-4cc1-aa38-abc8e6fd4b42','9e1f5161-81d6-4332-8b82-1df8ee87d853','yes','7','2022-06-27 07:43:04.786','2022-06-27 07:43:04.787','2'),('d0466202-5370-40c6-8316-2bbe548a5770','3d01f9ed-fa8d-420c-a0d2-67c8cccb5aa1','','1','2022-06-28 05:02:39.447','2022-06-28 05:02:39.448','4'),('da28edc4-4816-4511-aca1-83cdbec0915c','d9899e9b-f73c-4e9d-b0f4-d087759240ab','','1','2022-06-28 05:07:59.205','2022-06-28 05:07:59.206','4'),('f97e962e-1031-47a7-a6f8-70dad00be95b','2c11dff0-15ef-49b1-bf92-bc302b5cd312','follow up team ','1','2022-06-28 05:06:59.664','2022-06-28 05:06:59.664','5');
/*!40000 ALTER TABLE `IssueHistories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `IssuePriorities`
--

DROP TABLE IF EXISTS `IssuePriorities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `IssuePriorities` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` int NOT NULL,
  `des` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `IssuePriorities`
--

LOCK TABLES `IssuePriorities` WRITE;
/*!40000 ALTER TABLE `IssuePriorities` DISABLE KEYS */;
INSERT INTO `IssuePriorities` VALUES ('1','primary',1,'pilih jika anda rasa adalah yang ringan'),('2','warning',2,'pilih jika anda rasa adalah sejenis issue info untuk diketahui'),('3','danger',3,'pilih jika anda rasa adalah issue penting ');
/*!40000 ALTER TABLE `IssuePriorities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `IssueStatuses`
--

DROP TABLE IF EXISTS `IssueStatuses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `IssueStatuses` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `IssueStatuses`
--

LOCK TABLES `IssueStatuses` WRITE;
/*!40000 ALTER TABLE `IssueStatuses` DISABLE KEYS */;
INSERT INTO `IssueStatuses` VALUES ('1','open'),('10','reopened'),('2','accepted'),('3','rejected'),('4','approved'),('5','decline'),('6','progress'),('7','resolved'),('8','closed'),('9','pending');
/*!40000 ALTER TABLE `IssueStatuses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `IssueTypes`
--

DROP TABLE IF EXISTS `IssueTypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `IssueTypes` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `IssueTypes`
--

LOCK TABLES `IssueTypes` WRITE;
/*!40000 ALTER TABLE `IssueTypes` DISABLE KEYS */;
INSERT INTO `IssueTypes` VALUES ('1','bug'),('2','feature'),('3','improvement'),('4','task'),('5','request'),('6','other');
/*!40000 ALTER TABLE `IssueTypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Issues`
--

DROP TABLE IF EXISTS `Issues`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Issues` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `idx` int NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `des` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `issueTypesId` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `issueStatusesId` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `clientsId` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `productsId` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdAt` datetime(3) DEFAULT CURRENT_TIMESTAMP(3),
  `updatedAt` datetime(3) DEFAULT CURRENT_TIMESTAMP(3),
  `usersId` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `issuePrioritiesId` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `departementsId` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dateSubmit` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Issues_idx_key` (`idx`),
  KEY `Issues_usersId_fkey` (`usersId`),
  KEY `Issues_departementsId_fkey` (`departementsId`),
  KEY `Issues_issueTypesId_fkey` (`issueTypesId`),
  KEY `Issues_issueStatusesId_fkey` (`issueStatusesId`),
  KEY `Issues_clientsId_fkey` (`clientsId`),
  KEY `Issues_productsId_fkey` (`productsId`),
  KEY `Issues_issuePrioritiesId_fkey` (`issuePrioritiesId`),
  CONSTRAINT `Issues_clientsId_fkey` FOREIGN KEY (`clientsId`) REFERENCES `Clients` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `Issues_departementsId_fkey` FOREIGN KEY (`departementsId`) REFERENCES `Departements` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `Issues_issuePrioritiesId_fkey` FOREIGN KEY (`issuePrioritiesId`) REFERENCES `IssuePriorities` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `Issues_issueStatusesId_fkey` FOREIGN KEY (`issueStatusesId`) REFERENCES `IssueStatuses` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `Issues_issueTypesId_fkey` FOREIGN KEY (`issueTypesId`) REFERENCES `IssueTypes` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `Issues_productsId_fkey` FOREIGN KEY (`productsId`) REFERENCES `Products` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `Issues_usersId_fkey` FOREIGN KEY (`usersId`) REFERENCES `Users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Issues`
--

LOCK TABLES `Issues` WRITE;
/*!40000 ALTER TABLE `Issues` DISABLE KEYS */;
INSERT INTO `Issues` VALUES ('044d5ec8-b324-4858-bfa2-681b0504a6b3',8,'Install system untuk Tayna','masih dalam fu untuk minta id uv by email ','6','5','47','1','2022-06-27 07:54:08.253','2022-06-27 07:54:08.253','7',NULL,'9','2022-06-27 00:00:00.000'),('1287a323-2485-4cc8-a0d3-eef88aadf0b8',14,'DRR & Daily Sales Mines','Untuk outlet yang ada komisi contoh outlet spa tgl 1 Juni 2022 nilai sales nya di lihat dr daily sales dan DRR versi system terbaru (exe 21 juni 2022) tp dengan exe lama (jarvis 2G) tidak mines di daily sales & DRR','4','4','46','1','2022-06-28 02:01:49.958','2022-06-28 02:01:49.958','7','3','8','2022-06-24 00:00:00.000'),('13503c4e-ab4e-4a49-b295-c567aecfa580',9,'Hilangkan .00 pada report DRR','Sudah cek report - modify ternyata rumus tidak memunculkan format bilangan(999,999.99), jadi blm bisa di modify secara report untuk menghilangkan nilai .00 tersebut','4','4','47','1','2022-06-27 08:02:24.230','2022-06-27 08:02:24.230','7','3','11','2022-06-27 00:00:00.000'),('2c11dff0-15ef-49b1-bf92-bc302b5cd312',7,'Bill dan cashier report tgl 14 Juni 2022 tidak balance','Per tgl 24 Juni 2022 sudah di FU ke pak komang untuk konfirm ke finacne nya - history di chat trainer ','4','5','69','2','2022-06-27 07:51:06.694','2022-06-27 07:51:06.695','7',NULL,'8','2022-06-21 00:00:00.000'),('3d01f9ed-fa8d-420c-a0d2-67c8cccb5aa1',10,'Nilai summary FB sales tidak sesuai','Nilai summary fb sales detail untuk beverage periode 1 sd 24 Juni 2022 ketika di export ke excel hasilnya selisih 75rb dengan hitungan otomatis direport ','4','4','51','2','2022-06-27 08:18:01.155','2022-06-27 08:18:01.155','7','3','8','2022-06-25 00:00:00.000'),('6bfcf0da-2d4d-440f-95ab-11e5e72c7f56',11,'Persentase di PnL tidak sesuai','Sebelumnya sudah sempat di advice oleh pak ahmad untuk cek di DB table ckat, sudah dibantu cek oleh mas david dan semua di DB sudah sesuai namun hasil di system masih belum sesuai.','4','4','99','2','2022-06-27 08:32:21.190','2022-06-27 08:32:21.190','11','3','8','2022-06-27 00:00:00.000'),('86304116-95ca-41d2-92fa-2e9b214a38d7',12,'Tools phr ','Saat klik validasi seharusnya nilai tax dan service menyesuaikan dengan di kolom seharusnya tapi saat ini belum .\nDan nilai selisih juga jadi besar ','4','2','2','1','2022-06-27 08:35:02.098','2022-06-27 08:35:02.098','5',NULL,'8','2022-06-27 00:00:00.000'),('9e1f5161-81d6-4332-8b82-1df8ee87d853',6,'Printer resto tidak bisa print','sudah di fu di grup tp tidak ada respon kembali','4','5','46','2','2022-06-27 07:14:56.533','2022-06-27 07:14:56.533','7',NULL,'1','2022-06-12 00:00:00.000'),('d9899e9b-f73c-4e9d-b0f4-d087759240ab',5,'Cek master Voucher','masih ada error saat pembuatan tabel master voucher otomatis by system ','1','4','67','2','2022-06-27 07:11:30.520','2022-06-27 07:11:30.520','7','2','8','2022-06-11 00:00:00.000'),('f2d2562c-cd88-4f56-bcc3-25440c972f2f',15,'DRR & Daily Sales Mines','Untuk outlet yang ada komisi contoh outlet spa tgl 1 Juni 2022 nilai sales nya di lihat dr daily sales dan DRR versi system terbaru (exe 21 juni 2022) tp dengan exe lama (jarvis 2G) tidak mines di daily sales & DRR','4','2','46','1','2022-06-28 02:01:53.461','2022-06-28 02:01:53.461','7',NULL,'8','2022-06-24 00:00:00.000'),('f86d3538-303a-42fc-990b-f59d5b6e09ec',4,'muncul out of range save pembelian > 15 item','muncul out of range save pembelian > 15 item','1','4','75','2','2022-06-27 06:09:31.646','2022-06-27 06:09:31.646','1','2','8','2022-06-04 00:00:00.000'),('fa26fdfd-1257-43fa-942b-729f482ffb37',13,'Pengaktifan system','klien minta untuk diaktifkan kembali systemnya, namun masih terkendala dengan server yang belum bisa diremote','4','1','9','1','2022-06-27 09:03:50.451','2022-06-27 09:03:50.451','11',NULL,'1','2022-06-27 00:00:00.000');
/*!40000 ALTER TABLE `Issues` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Positions`
--

DROP TABLE IF EXISTS `Positions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Positions` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `departementsId` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Positions_departementsId_fkey` (`departementsId`),
  CONSTRAINT `Positions_departementsId_fkey` FOREIGN KEY (`departementsId`) REFERENCES `Departements` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Positions`
--

LOCK TABLES `Positions` WRITE;
/*!40000 ALTER TABLE `Positions` DISABLE KEYS */;
INSERT INTO `Positions` VALUES ('1','helper',NULL),('10','leader',NULL),('11','id',NULL),('12','it manager',NULL),('13','production manager',NULL),('14','customer service leader',NULL),('15','trainer leader',NULL),('16','trainer manager',NULL),('17','customer service manager',NULL),('2','trainer',NULL),('3','customer service',NULL),('4','admin',NULL),('5','programer',NULL),('6','leader',NULL),('7','manager',NULL),('8','director',NULL),('9','spv',NULL);
/*!40000 ALTER TABLE `Positions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Products`
--

DROP TABLE IF EXISTS `Products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Products` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Products`
--

LOCK TABLES `Products` WRITE;
/*!40000 ALTER TABLE `Products` DISABLE KEYS */;
INSERT INTO `Products` VALUES ('1','phis'),('2','presto'),('3','ppos'),('4','ppe');
/*!40000 ALTER TABLE `Products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Profiles`
--

DROP TABLE IF EXISTS `Profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Profiles` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `first_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `bith_day` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `usersId` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `positionsId` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `rolesId` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Profiles_usersId_key` (`usersId`),
  UNIQUE KEY `Profiles_positionsId_key` (`positionsId`),
  KEY `Profiles_rolesId_fkey` (`rolesId`),
  CONSTRAINT `Profiles_positionsId_fkey` FOREIGN KEY (`positionsId`) REFERENCES `Positions` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `Profiles_rolesId_fkey` FOREIGN KEY (`rolesId`) REFERENCES `Roles` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `Profiles_usersId_fkey` FOREIGN KEY (`usersId`) REFERENCES `Users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Profiles`
--

LOCK TABLES `Profiles` WRITE;
/*!40000 ALTER TABLE `Profiles` DISABLE KEYS */;
/*!40000 ALTER TABLE `Profiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Roles`
--

DROP TABLE IF EXISTS `Roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Roles` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Roles`
--

LOCK TABLES `Roles` WRITE;
/*!40000 ALTER TABLE `Roles` DISABLE KEYS */;
INSERT INTO `Roles` VALUES ('1','User','User'),('2','Leader','Leader'),('3','Moderator','Moderator'),('4','Admin','Admin'),('5','Super Admin','Super Admin');
/*!40000 ALTER TABLE `Roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Users`
--

DROP TABLE IF EXISTS `Users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Users` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `rolesId` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Users_rolesId_fkey` (`rolesId`),
  CONSTRAINT `Users_rolesId_fkey` FOREIGN KEY (`rolesId`) REFERENCES `Roles` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Users`
--

LOCK TABLES `Users` WRITE;
/*!40000 ALTER TABLE `Users` DISABLE KEYS */;
INSERT INTO `Users` VALUES ('1','ayu','ayu@gmail.com','123456','3'),('10','david','david@gmail.com','123456','1'),('11','widia','widia@gmail.com','123456','1'),('12','ayu ari','ayu_ari@gmail.com','123456','1'),('13','yuni','yuni@gmail.com','123456','1'),('14','malik','malik@gmail.com','123456','1'),('15','mukijan','mukijan@gmail.com','123456','5'),('2','guntur','guntur@gmail.com','123456','2'),('3','adi','adi@gmail.com','123456','2'),('4','apit','apit@gmail.com','123456','1'),('5','ariska','ariska@gmail.com','123456','1'),('6','bayu','bayu@gmail.com','123456','1'),('7','dewi','dewi@gmail.com','123456','2'),('8','ahmad','ahmad@gmail.com','123456','4'),('9','gede','gede@gmail.com','123456','1');
/*!40000 ALTER TABLE `Users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `_prisma_migrations`
--

DROP TABLE IF EXISTS `_prisma_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `_prisma_migrations` (
  `id` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `checksum` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `finished_at` datetime(3) DEFAULT NULL,
  `migration_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `logs` text COLLATE utf8mb4_unicode_ci,
  `rolled_back_at` datetime(3) DEFAULT NULL,
  `started_at` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `applied_steps_count` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `_prisma_migrations`
--

LOCK TABLES `_prisma_migrations` WRITE;
/*!40000 ALTER TABLE `_prisma_migrations` DISABLE KEYS */;
INSERT INTO `_prisma_migrations` VALUES ('95359247-b988-45b7-8058-8fa635311d0f','dcfaf051273dfee44998a83ab60efe5e591c380ccb098a87ca413e8da1c1f17a','2022-06-25 15:28:18.440','20220625151205_apa',NULL,NULL,'2022-06-25 15:25:04.755',1);
/*!40000 ALTER TABLE `_prisma_migrations` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-06-29  7:27:52
