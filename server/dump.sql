-- MySQL dump 10.13  Distrib 8.0.29, for macos11.6 (x86_64)
--
-- Host: localhost    Database: myprobus
-- ------------------------------------------------------
-- Server version	8.0.29

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
-- Table structure for table `_JabatanToUsers`
--

DROP TABLE IF EXISTS `_JabatanToUsers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `_JabatanToUsers` (
  `A` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `B` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  UNIQUE KEY `_JabatanToUsers_AB_unique` (`A`,`B`),
  KEY `_JabatanToUsers_B_index` (`B`),
  CONSTRAINT `_JabatanToUsers_A_fkey` FOREIGN KEY (`A`) REFERENCES `Jabatan` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `_JabatanToUsers_B_fkey` FOREIGN KEY (`B`) REFERENCES `Users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `_JabatanToUsers`
--

LOCK TABLES `_JabatanToUsers` WRITE;
/*!40000 ALTER TABLE `_JabatanToUsers` DISABLE KEYS */;
/*!40000 ALTER TABLE `_JabatanToUsers` ENABLE KEYS */;
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
INSERT INTO `_prisma_migrations` VALUES ('268ed89e-9039-45de-8534-4e5fc9ea685a','1c6d20eb781ad29ec7394fe248bf71536464cd59577e43f581919ba53c519a78','2022-07-08 07:40:26.098','20220708074025_apa',NULL,NULL,'2022-07-08 07:40:25.853',1),('7c4f8aac-07e6-41fd-aceb-5d7549ddefdd','4ce402cfe81d6c15f988be3b908b489531a373324485ec5329b191109c3b8c41','2022-07-05 07:13:10.309','20220705071132_apa',NULL,NULL,'2022-07-05 07:13:08.599',1),('b3b8fb21-fa62-4ae5-be84-99ac26961a15','9bc028f4d703875a9f002343cd2ad9361a0375d08eb088a668f341e51f05a931','2022-07-26 02:08:13.924','20220726020813_apa',NULL,NULL,'2022-07-26 02:08:13.464',1);
/*!40000 ALTER TABLE `_prisma_migrations` ENABLE KEYS */;
UNLOCK TABLES;

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
INSERT INTO `Departements` VALUES ('1','fo/pos'),('2',' bo'),('3','web'),('4','it'),('5','ecomers');
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
INSERT INTO `Discussion` VALUES ('0da7c86f-449e-489d-85eb-5beade1935a5','halo',NULL,'7','2022-07-05 17:03:37.532','2022-07-05 17:03:37.532',NULL),('10aec5b4-2dd0-455f-925a-9514df9f6e75','halo',NULL,'7','2022-07-06 07:40:02.571','2022-07-06 07:40:02.571',NULL),('11e8ab48-2f53-4308-bd17-efd29b7624ab','test disini',NULL,'8','2022-07-06 04:06:40.753','2022-07-06 04:06:40.754',NULL),('12b179b0-1129-4edf-8f41-59add52aaa4d','halo',NULL,'8','2022-07-06 04:05:29.948','2022-07-06 04:05:29.949',NULL),('1394309a-319f-4f64-977a-357065712fae','halo',NULL,'7','2022-07-05 16:03:43.596','2022-07-05 16:03:43.596',NULL),('13bd96e7-877d-4256-a0bf-cba359366e8d','tes',NULL,'7','2022-07-06 03:21:11.609','2022-07-06 03:21:11.610',NULL),('159a3877-83d0-482e-9260-9bd712474e41','tes',NULL,'7','2022-07-05 16:08:11.073','2022-07-05 16:08:11.074',NULL),('17aad8df-22fe-4e97-9946-3151169d441b','tes',NULL,'8','2022-07-06 04:10:52.188','2022-07-06 04:10:52.188',NULL),('1b8842d2-4db0-4bd3-8b5c-31f02b092ce6','tes',NULL,'8','2022-07-06 04:08:15.232','2022-07-06 04:08:15.233',NULL),('1d7b4b1f-3c6e-4c79-ac67-29f9ab8786ed','tos',NULL,'7','2022-07-06 07:40:13.440','2022-07-06 07:40:13.440',NULL),('226303cc-cc64-41a4-8154-3c6d7fa681af','tes\'',NULL,'8','2022-07-06 04:09:18.573','2022-07-06 04:09:18.574',NULL),('263d8f33-1f01-4a92-833b-702fa5adbcbb','ini dimana',NULL,'7','2022-07-05 18:23:34.845','2022-07-05 18:23:34.845',NULL),('2b408a19-93c0-44c7-92c7-da7ce06d8d1e','ini ada dimana',NULL,'7','2022-07-05 17:17:10.795','2022-07-05 17:17:10.796',NULL),('2dd92119-7f0f-4b56-b01a-eb5b5149263c','ini',NULL,'7','2022-07-05 16:26:36.979','2022-07-05 16:26:36.980',NULL),('33446f8a-adf4-49fe-bc3c-5953e42daaf2','',NULL,'7','2022-07-06 08:22:08.929','2022-07-06 08:22:08.930','7a3f4c47-4453-4bc3-8eee-298703b48ea2'),('335fd247-62b2-4a8e-9f1b-176be6d573ce','tes',NULL,'7','2022-07-06 07:57:35.118','2022-07-06 07:57:35.118',NULL),('44944def-7a64-4063-b8b1-be76785e6dc0','halo',NULL,'7','2022-07-06 08:22:59.295','2022-07-06 08:22:59.295',NULL),('487a34a2-9caa-49b3-8a9e-fa53f6dbc528','tes',NULL,'7','2022-07-06 03:21:28.472','2022-07-06 03:21:28.472',NULL),('48d9b210-1291-4550-99a6-c75ffd3fd35c','apanya ya',NULL,'7','2022-07-05 17:04:00.169','2022-07-05 17:04:00.170',NULL),('49de6c32-6e1f-4419-9e63-932acc6d7350','tes',NULL,'7','2022-07-06 03:16:01.694','2022-07-06 03:16:01.697',NULL),('4edf49e8-89a2-4755-9423-d764959b9ca8','ya',NULL,'4','2022-07-05 18:23:29.011','2022-07-05 18:23:29.012',NULL),('4f142f50-b11b-4a05-8395-01837f050f94','tes',NULL,'7','2022-07-06 07:34:35.977','2022-07-06 07:34:35.979',NULL),('55f27bcd-431e-4f80-8853-8af2f8bd0226','satu',NULL,'7','2022-07-06 07:34:41.608','2022-07-06 07:34:41.609',NULL),('576451e8-c5fd-46d3-b8c5-dfd5afe3a274','tes',NULL,'8','2022-07-06 04:07:55.282','2022-07-06 04:07:55.282',NULL),('585eeaf5-697a-4fc2-a3f9-89ce79269259','halo test',NULL,'7','2022-07-05 18:19:42.601','2022-07-05 18:19:42.601',NULL),('5c997195-0b28-41b2-be27-5ea809722e67','dua',NULL,'7','2022-07-06 07:34:45.520','2022-07-06 07:34:45.520',NULL),('655aa523-6c20-4429-b1e2-86d3426d5f51','tor',NULL,'7','2022-07-06 03:20:51.806','2022-07-06 03:20:51.806',NULL),('6ef3bc0f-4514-40ce-b5aa-cff3290c08ad','tes',NULL,'7','2022-07-05 16:07:13.209','2022-07-05 16:07:13.209',NULL),('6f5ba55b-40c3-4f10-a3c2-d8140b8726e2','tes',NULL,'7','2022-07-06 03:20:42.964','2022-07-06 03:20:42.965',NULL),('798d83b5-e7b2-4316-b485-c494a20aa026','ya halo',NULL,'7','2022-07-05 16:34:12.383','2022-07-05 16:34:12.384',NULL),('8aabc0a4-6248-4283-8bb1-9f823bd47ad1','halo',NULL,'7','2022-07-05 17:17:04.790','2022-07-05 17:17:04.791',NULL),('8c543d5d-c2a0-4bca-bbfc-120e2749c014','tos',NULL,'7','2022-07-06 07:57:43.972','2022-07-06 07:57:43.973',NULL),('90c05bba-36d5-4c82-8979-586d2c4e656a','',NULL,'7','2022-07-10 05:06:18.742','2022-07-10 05:06:18.743','16f60500-661c-468f-97fb-49b91b8d671c'),('932ba6e9-1287-4526-b9bf-3290d6b1377e','siapa ya',NULL,'7','2022-07-05 16:26:52.772','2022-07-05 16:26:52.772',NULL),('9b546558-24d1-44d9-94d3-cfa2073ac6d0','ini dimana',NULL,'7','2022-07-05 16:06:31.205','2022-07-05 16:06:31.205',NULL),('9bcce2fd-078b-4e6d-8327-411fdf12b95e','ini mana gambarnya\'',NULL,'7','2022-07-05 17:11:58.883','2022-07-05 17:11:58.884',NULL),('9cc1622a-1d2e-4dff-8a50-1dc30aa60e35','',NULL,'7','2022-07-10 05:07:21.997','2022-07-10 05:07:21.998','d76d8050-577f-493d-9c88-4b37548a19a5'),('a5cc57d2-fbff-4728-8836-94fb57b990f4','dimana',NULL,'7','2022-07-05 16:26:39.957','2022-07-05 16:26:39.958',NULL),('a8ffd48e-2186-4b7f-b7e7-d8ed23e1bfff','detai',NULL,'7','2022-07-06 03:21:20.038','2022-07-06 03:21:20.039',NULL),('aca4c32b-4ebc-442e-8268-60be0064ecc3','ini siapa',NULL,'7','2022-07-06 07:40:07.160','2022-07-06 07:40:07.161',NULL),('b0e9a7cd-4ea5-4cdb-a4d5-824d16b9072d','halo',NULL,'7','2022-07-05 16:26:45.057','2022-07-05 16:26:45.058',NULL),('c049d11f-06af-4fc9-88a9-1e25d5878cbf','ini bisa tolong',NULL,'7','2022-07-05 17:03:44.006','2022-07-05 17:03:44.007',NULL),('c54386d7-ed90-4e97-867a-0c4b62f489ea','ini ada dimana',NULL,'7','2022-07-05 16:08:19.475','2022-07-05 16:08:19.475',NULL),('c7042dcf-b950-4eb3-b624-8d7c5f3f820f','ini tes',NULL,'7','2022-07-06 07:57:38.788','2022-07-06 07:57:38.789',NULL),('d3d808af-7ba9-4851-8d94-137c4ad409b5','tes',NULL,'7','2022-07-06 07:40:09.956','2022-07-06 07:40:09.957',NULL),('d6363046-aaef-4dd1-8169-5fb8ab34af26','ap a',NULL,'7','2022-07-05 16:07:04.565','2022-07-05 16:07:04.565',NULL),('dc6260e3-1c4b-4e91-af62-f0c7350af28b','tes ini dimana',NULL,'8','2022-07-06 03:20:30.316','2022-07-06 03:20:30.316',NULL),('df549240-b9a3-4808-955e-8559cd60b689','tes',NULL,'7','2022-07-06 02:33:56.824','2022-07-06 02:33:56.826',NULL),('e673da4c-60a0-4918-acea-c22c2d320a1b','ini dimana',NULL,'7','2022-07-05 16:34:15.932','2022-07-05 16:34:15.933',NULL),('e743f137-5f48-4b88-b28d-8632e8cc8db2','','0bcb0104-30fa-45fd-9ce1-d729a21051c7','7','2022-07-10 09:50:44.242','2022-07-10 09:50:44.242','c9d05f90-19b8-44ed-b923-da867ef001bb'),('e8b2a5e8-81cf-4dfa-8154-3817c5a975a6','dimana ya',NULL,'7','2022-07-05 17:03:53.834','2022-07-05 17:03:53.834',NULL),('ebe78461-3cbc-4a69-bdca-cd46fbe73ffd','disini',NULL,'7','2022-07-10 05:10:33.738','2022-07-10 05:10:33.739',NULL),('f020ce61-55b2-46fa-992c-b4ecedec0996','gambarnya',NULL,'7','2022-07-05 17:11:47.224','2022-07-05 17:11:47.225',NULL),('f09851ec-e0a9-40b5-84f3-f5901a43c245','',NULL,'7','2022-07-05 17:04:07.589','2022-07-05 17:04:07.589','ef397f2a-f9fa-4530-9e75-5831db02155d'),('f1828aba-aad1-4866-8c22-efe62ba0c817','apa ya',NULL,'7','2022-07-05 16:34:18.785','2022-07-05 16:34:18.786',NULL),('f53528e7-e822-4f96-a570-d97ef3a45a02','test',NULL,'4','2022-07-05 18:23:46.270','2022-07-05 18:23:46.271',NULL),('f72d83eb-dda9-42de-9987-f333e7ba6f91','halo',NULL,'7','2022-07-06 08:22:41.710','2022-07-06 08:22:41.711',NULL),('f981b1ec-8969-444d-9c8b-779d83741fe0','ada olang ?','0bcb0104-30fa-45fd-9ce1-d729a21051c7','7','2022-07-10 09:50:21.955','2022-07-10 09:50:21.957',NULL),('fa234817-7af0-488b-b5a9-ad4d30bc766c','tes',NULL,'8','2022-07-06 04:05:21.418','2022-07-06 04:05:21.419',NULL),('fd2b6ded-ccef-4275-bdcb-fcf2e9aacb79','tor',NULL,'7','2022-07-06 07:57:41.654','2022-07-06 07:57:41.655',NULL),('fdbc752d-1467-4be4-8416-071b99962859','ya ini dia',NULL,'7','2022-07-05 17:03:49.718','2022-07-05 17:03:49.719',NULL);
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
INSERT INTO `Images` VALUES ('06e55d67-081c-42b4-bfea-de749ca2185a','0eed5ef4-c225-4131-aa2d-7f2ad0237ef6.png',NULL,NULL,'7'),('0e05fcff-e76d-4afe-8ccb-fcad657e7835','10420c6b-0cc5-4d93-9815-d7fa1f98976b.png',NULL,NULL,'7'),('0fec5773-6371-4b8a-955a-cd8cc91f517e','0eed5ef4-c225-4131-aa2d-7f2ad0237ef6.png',NULL,NULL,'7'),('16f60500-661c-468f-97fb-49b91b8d671c','706db1be-3ef6-4690-9a23-f746637432b0img-11145982.png',NULL,NULL,NULL),('2a27a733-6003-459d-8dca-9dad31a05e2d','0eed5ef4-c225-4131-aa2d-7f2ad0237ef6.png',NULL,NULL,'7'),('2fbd7bbd-8b2f-4ec1-a8bd-d4f58a02e48a','10420c6b-0cc5-4d93-9815-d7fa1f98976b.png',NULL,NULL,'7'),('3fac0a48-a2f6-4cb6-b8bf-af0ef4f1ce1a','0eed5ef4-c225-4131-aa2d-7f2ad0237ef6.png',NULL,NULL,'1'),('5475b23a-03db-4218-bf93-9df66e60d660','8731e1bb-b056-4357-935b-b9f353abb21f.png',NULL,NULL,'7'),('64ef3da7-eb73-4d85-92e3-8f96dae9b221','8731e1bb-b056-4357-935b-b9f353abb21f.png',NULL,NULL,'7'),('73d7ef9a-ff2c-43c0-b0be-325a47ce6794','0eed5ef4-c225-4131-aa2d-7f2ad0237ef6.png',NULL,NULL,'7'),('7a3f4c47-4453-4bc3-8eee-298703b48ea2','e33ef5c0-8ca5-4d13-89cd-87633c362c87.png',NULL,NULL,NULL),('85b43364-aa3a-4f23-8d02-fbe4f4d456e9','10420c6b-0cc5-4d93-9815-d7fa1f98976b.png',NULL,NULL,'7'),('87573ffa-d002-4ed4-a865-d700e3c99d6c','0eed5ef4-c225-4131-aa2d-7f2ad0237ef6.png',NULL,NULL,'7'),('a2cd41b0-462b-408b-9bc2-c095bd666a35','0eed5ef4-c225-4131-aa2d-7f2ad0237ef6.png',NULL,NULL,'7'),('aa9d502d-7faf-419f-a3cf-b977618d8fde','0eed5ef4-c225-4131-aa2d-7f2ad0237ef6.png',NULL,NULL,'7'),('bdaed137-aabe-4a30-be6f-eb7e706b0b8a','ababcfb5-688c-4bdb-890e-ceae4e22bdf3.png',NULL,NULL,'7'),('c11989b0-ab4a-4e17-b134-3c24f04fce83','230100cb-8995-4f89-8eb4-ec3f2cfb55a1.png',NULL,NULL,'4'),('c42b51c2-4d5c-45e2-9d36-19fa16b1801d','10420c6b-0cc5-4d93-9815-d7fa1f98976b.png',NULL,NULL,'7'),('c62b69f1-df07-4a0c-8ae6-c271024dd550','76a3c0de-5e6c-4218-a2ba-593a46699f87.png',NULL,NULL,'7'),('c9d05f90-19b8-44ed-b923-da867ef001bb','4d7000a7-6415-4ba9-938c-61e602aae1d6img-68263729.png',NULL,NULL,NULL),('cafb9192-4057-4c78-bbe8-7d9ab6eb5dec','0eed5ef4-c225-4131-aa2d-7f2ad0237ef6.png',NULL,NULL,'7'),('ccec5785-d52c-4311-be52-bd657eaff77c','0eed5ef4-c225-4131-aa2d-7f2ad0237ef6.png',NULL,NULL,'7'),('d30ab703-5bab-4f4f-b0d3-6c6fccb96aaa','0eed5ef4-c225-4131-aa2d-7f2ad0237ef6.png',NULL,NULL,'7'),('d76d8050-577f-493d-9c88-4b37548a19a5','8fae507c-2751-4149-b251-160e4c9937aaimg-74996324.png',NULL,NULL,NULL),('dba329b2-0030-4585-8a40-25b8c5b441c5','2b95762d-3b33-48d7-89d2-f4cbb86d2f67.png',NULL,NULL,NULL),('e5c31943-905e-41ab-a7d0-82836d68a95c','0eed5ef4-c225-4131-aa2d-7f2ad0237ef6.png',NULL,NULL,'7'),('ef397f2a-f9fa-4530-9e75-5831db02155d','112a8202-11d0-4646-829b-b84782b25da9.png',NULL,NULL,NULL);
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
INSERT INTO `IssueHistories` VALUES ('1a05a360-5f64-49bf-835a-355cb78ee63b',NULL,NULL,'7','2022-07-05 17:20:56.686','2022-07-05 17:20:56.692',NULL),('247f2233-6074-45a2-a1d5-9ebe4fa1c6c2','b0f97cdc-a12e-4dac-a842-9f0b9843680b',NULL,'7','2022-07-19 07:02:33.883','2022-07-19 07:02:33.886',NULL),('283d30da-308d-422f-85e9-9c066c679326','bd746ca4-4802-4345-a3a9-21d91f61a8e5',NULL,'7','2022-07-19 08:25:57.131','2022-07-19 08:25:57.132',NULL),('47e554d1-1e9d-49a5-9e41-1718b248ad52','1c04c3ef-ffa0-435c-adf4-be8bac00dc25',NULL,'7','2022-07-19 08:00:20.058','2022-07-19 08:00:20.059',NULL),('67157b4f-bff3-4210-807f-88465ea14a22',NULL,NULL,'7','2022-07-05 08:01:03.183','2022-07-05 08:01:03.184',NULL),('6f67f373-0206-4b42-9313-a25d4e2059e6','5b57b371-5098-4649-8f93-d89ba64d6eb8',NULL,'7','2022-07-19 08:58:36.096','2022-07-19 08:58:36.096',NULL),('7ad26b3d-c974-44f6-9d62-495cb288baaf','77bbda59-d842-4954-80a3-bfe87b7e3e29',NULL,'7','2022-07-19 08:58:42.781','2022-07-19 08:58:42.782',NULL),('827bba3f-be43-4872-8d88-3c2638e3bc17','07d9f1b6-a356-4af1-a0fd-5878c45b040e','','7','2022-07-19 08:57:28.546','2022-07-19 08:57:28.546','2'),('a46d46c5-7836-43f4-bcc2-689e87cbb293','5b57b371-5098-4649-8f93-d89ba64d6eb8','','7','2022-07-19 08:58:36.119','2022-07-19 08:58:36.120','4'),('b6d75069-a5fb-4605-82f7-d3ec54458088',NULL,NULL,'7','2022-07-05 09:05:08.193','2022-07-05 09:05:08.194',NULL),('b7d1e5d5-9f62-4e10-b499-decd6d87d6c1','77bbda59-d842-4954-80a3-bfe87b7e3e29','dengan alasan','7','2022-07-19 08:58:42.791','2022-07-19 08:58:42.791','3'),('d5a7bb8d-7854-4e07-a3b4-f26d72308c5b',NULL,NULL,'7','2022-07-05 09:05:10.804','2022-07-05 09:05:10.804',NULL),('e0e75736-2929-4ea0-b431-7658d069bb7c','07d9f1b6-a356-4af1-a0fd-5878c45b040e',NULL,'7','2022-07-19 08:57:28.356','2022-07-19 08:57:28.369',NULL),('fb560f35-0f2b-4f37-8eaf-8379b15bbfc5',NULL,NULL,'7','2022-07-05 09:05:13.101','2022-07-05 09:05:13.101',NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Issues`
--

LOCK TABLES `Issues` WRITE;
/*!40000 ALTER TABLE `Issues` DISABLE KEYS */;
INSERT INTO `Issues` VALUES ('07d9f1b6-a356-4af1-a0fd-5878c45b040e',36,'sdsdsds','dsdsdsds','1','2','10','1','2022-07-18 06:29:58.204','2022-07-18 06:29:58.204','7',NULL,'2','2022-07-18 06:28:21.510'),('0bcb0104-30fa-45fd-9ce1-d729a21051c7',12,'Pengaktifan system','klien minta untuk diaktifkan kembali systemnya, namun masih terkendala dengan server yang belum bisa diremote','4','1','9','1','2022-07-08 02:31:06.953','2022-07-08 02:31:06.953','11',NULL,'1','2022-06-27 00:00:00.000'),('1c04c3ef-ffa0-435c-adf4-be8bac00dc25',38,'sdsdsdsd 08','08','1','3','1','1','2022-07-18 08:17:34.017','2022-07-18 08:17:34.017','7',NULL,'2','2022-07-12 16:00:00.000'),('2379ab58-2de9-4c0d-b336-0216bd939f32',3,'Hilangkan .00 pada report DRR','Sudah cek report - modify ternyata rumus tidak memunculkan format bilangan(999,999.99), jadi blm bisa di modify secara report untuk menghilangkan nilai .00 tersebut','4','4','47','1','2022-07-08 02:31:06.669','2022-07-08 02:31:06.669','7',NULL,'3','2022-06-27 00:00:00.000'),('3ff2ea91-6ace-4ff2-8c6c-7dffae340858',5,'Nilai summary FB sales tidak sesuai','Nilai summary fb sales detail untuk beverage periode 1 sd 24 Juni 2022 ketika di export ke excel hasilnya selisih 75rb dengan hitungan otomatis direport ','4','4','51','2','2022-07-08 02:31:06.914','2022-07-08 02:31:06.914','7',NULL,'2','2022-06-27 00:00:00.000'),('434ab9ef-c28f-4baa-9ef0-fb332dfb12f0',9,'Cek master Voucher','masih ada error saat pembuatan tabel master voucher otomatis by system ','1','4','67','2','2022-07-08 02:31:06.937','2022-07-08 02:31:06.937','7',NULL,'4','2022-06-27 00:00:00.000'),('4aae8c09-642e-4114-b927-2c3331a52284',8,'Printer resto tidak bisa print','sudah di fu di grup tp tidak ada respon kembali','4','5','46','2','2022-07-08 02:31:06.932','2022-07-08 02:31:06.932','7',NULL,'1','2022-06-27 00:00:00.000'),('4d2591f1-4d2a-4b45-8512-fdcad9c7964e',1,'Install system untuk Tayna','masih dalam fu untuk minta id uv by email ','6','5','47','1','2022-07-08 02:31:06.486','2022-07-08 02:31:06.486','7',NULL,'2','2022-06-27 00:00:00.000'),('5b57b371-5098-4649-8f93-d89ba64d6eb8',41,'sdsdsdsds','sdsdsdsds','1','4','1','2','2022-07-19 08:58:28.580','2022-07-19 08:58:28.580','7',NULL,'2','2022-07-20 08:58:15.990'),('5eb4e7b8-da4b-4415-a135-a7033020689f',2,'DRR & Daily Sales Mines','Untuk outlet yang ada komisi contoh outlet spa tgl 1 Juni 2022 nilai sales nya di lihat dr daily sales dan DRR versi system terbaru (exe 21 juni 2022) tp dengan exe lama (jarvis 2G) tidak mines di daily sales & DRR','4','4','46','1','2022-07-08 02:31:06.537','2022-07-08 02:31:06.537','7',NULL,'2','2022-06-27 00:00:00.000'),('75778c3d-f586-47c2-971f-c999c2648c8a',7,'Tools phr ','Saat klik validasi seharusnya nilai tax dan service menyesuaikan dengan di kolom seharusnya tapi saat ini belum .\r\nDan nilai selisih juga jadi besar ','4','2','2','1','2022-07-08 02:31:06.927','2022-07-08 02:31:06.927','5',NULL,'2','2022-06-27 00:00:00.000'),('77bbda59-d842-4954-80a3-bfe87b7e3e29',40,'sdsdsds','dsdsdsds','1','3','1','1','2022-07-19 08:58:14.425','2022-07-19 08:58:14.425','7',NULL,'2','2022-07-20 08:57:14.213'),('ae2ee4a7-faf5-42d9-9551-5f52f7ee37b1',4,'Bill dan cashier report tgl 14 Juni 2022 tidak balance','Per tgl 24 Juni 2022 sudah di FU ke pak komang untuk konfirm ke finacne nya - history di chat trainer ','4','5','69','2','2022-07-08 02:31:06.833','2022-07-08 02:31:06.833','7',NULL,'4','2022-06-27 00:00:00.000'),('b0f97cdc-a12e-4dac-a842-9f0b9843680b',39,'sddsds','dsdsdsdsds','1','3','1','2','2022-07-18 08:19:27.534','2022-07-18 08:19:27.534','7',NULL,'2','2022-07-13 16:00:00.000'),('bd746ca4-4802-4345-a3a9-21d91f61a8e5',37,'dsdsdsdsd 07','dsdsdsd','1','3','1','1','2022-07-18 08:16:18.592','2022-07-18 08:16:18.592','7',NULL,'2','2022-07-12 16:00:00.000'),('c46004c7-dfe7-4c20-92ac-f58df3d1e4d5',10,'DRR & Daily Sales Mines','Untuk outlet yang ada komisi contoh outlet spa tgl 1 Juni 2022 nilai sales nya di lihat dr daily sales dan DRR versi system terbaru (exe 21 juni 2022) tp dengan exe lama (jarvis 2G) tidak mines di daily sales & DRR','4','2','46','1','2022-07-08 02:31:06.941','2022-07-08 02:31:06.941','7',NULL,'2','2022-06-27 00:00:00.000'),('da58e255-1150-48e5-9aec-34011ebb21ea',11,'muncul out of range save pembelian > 15 item','muncul out of range save pembelian > 15 item','1','4','75','2','2022-07-08 02:31:06.948','2022-07-08 02:31:06.948','1',NULL,'2','2022-06-27 00:00:00.000'),('dc46c899-1d95-4a7b-be15-61884c16d43a',6,'Persentase di PnL tidak sesuai','Sebelumnya sudah sempat di advice oleh pak ahmad untuk cek di DB table ckat, sudah dibantu cek oleh mas david dan semua di DB sudah sesuai namun hasil di system masih belum sesuai.','4','4','99','2','2022-07-08 02:31:06.921','2022-07-08 02:31:06.921','11',NULL,'1','2022-06-27 00:00:00.000');
/*!40000 ALTER TABLE `Issues` ENABLE KEYS */;
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
-- Table structure for table `Jabatan`
--

DROP TABLE IF EXISTS `Jabatan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Jabatan` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Jabatan`
--

LOCK TABLES `Jabatan` WRITE;
/*!40000 ALTER TABLE `Jabatan` DISABLE KEYS */;
/*!40000 ALTER TABLE `Jabatan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Notif`
--

DROP TABLE IF EXISTS `Notif`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Notif` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updatedAt` datetime(3) NOT NULL,
  `usersId` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `issuesId` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `jenis` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT 'msg',
  PRIMARY KEY (`id`),
  KEY `Notif_usersId_fkey` (`usersId`),
  KEY `Notif_issuesId_fkey` (`issuesId`),
  CONSTRAINT `Notif_issuesId_fkey` FOREIGN KEY (`issuesId`) REFERENCES `Issues` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `Notif_usersId_fkey` FOREIGN KEY (`usersId`) REFERENCES `Users` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Notif`
--

LOCK TABLES `Notif` WRITE;
/*!40000 ALTER TABLE `Notif` DISABLE KEYS */;
INSERT INTO `Notif` VALUES ('004301dc-d41e-498d-af2e-b0beda4ed9f5','2022-07-05 15:41:33.353','2022-07-05 15:41:33.354','7',NULL,'new message','ini','msg'),('073e2907-95cf-408d-af89-9183eb2edcd7','2022-07-06 13:38:20.368','2022-07-06 13:38:20.369','7',NULL,'new message','new Image Message','msg'),('09ce4e6b-4d67-4fef-8049-9fdf04a79189','2022-07-07 07:51:21.251','2022-07-07 07:51:21.251','7',NULL,'new message','new Image Message','msg'),('0aa1150c-3bae-4efe-9ac7-93c706b683bc','2022-07-06 07:40:07.269','2022-07-06 07:40:07.270','7',NULL,'new message','ini siapa','msg'),('0b3bafa3-dc11-4719-930d-f80712861baf','2022-07-05 16:34:18.848','2022-07-05 16:34:18.849','7',NULL,'new message','apa ya','msg'),('0bb7e51a-646b-419f-86c8-da729b77e861','2022-07-14 02:55:11.025','2022-07-14 02:55:11.026','7',NULL,'new message','new Image Message','msg'),('0d1b7796-be4d-42c4-9cff-89ccc64c7cda','2022-07-06 04:06:40.786','2022-07-06 04:06:40.787','8',NULL,'new message','test disini','msg'),('0e80cbef-4e19-482f-ac8a-28a3272673d0','2022-07-06 13:43:00.021','2022-07-06 13:43:00.022','7',NULL,'new message','new Image Message','msg'),('0fc9c4d8-11de-4056-9b33-d05f0f5676fc','2022-07-05 16:26:40.088','2022-07-05 16:26:40.088','7',NULL,'new message','dimana','msg'),('111e70d4-f186-4d5c-a198-ca3239c184d9','2022-07-06 03:20:51.879','2022-07-06 03:20:51.879','7',NULL,'new message','tor','msg'),('119b8fcc-ab93-439d-83b0-0921538e13af','2022-07-10 05:06:19.096','2022-07-10 05:06:19.096','7',NULL,'new message','[ image ]','msg'),('164150ef-7016-4b50-9b16-b99e3566b5c2','2022-07-07 07:50:55.380','2022-07-07 07:50:55.380','7',NULL,'new message','new Image Message','msg'),('1a8d4b7e-9ed3-4074-92c5-1402af000c31','2022-07-05 17:17:05.088','2022-07-05 17:17:05.089','7',NULL,'new message','halo','msg'),('1cc3cb1e-d73a-4048-9b95-0b7d66ae517a','2022-07-05 17:03:49.810','2022-07-05 17:03:49.811','7',NULL,'new message','ya ini dia','msg'),('1d5f89a7-70c7-4e61-9b3c-eeaf364de884','2022-07-06 07:40:55.181','2022-07-06 07:40:55.182','7',NULL,'new message','new Image Message','msg'),('1e2f2607-5534-4643-8840-2cf97f676d54','2022-07-06 04:05:30.000','2022-07-06 04:05:30.001','8',NULL,'new message','halo','msg'),('1fc9a6fd-cd46-4d6a-84d9-46309eede462','2022-07-06 02:33:57.079','2022-07-06 02:33:57.079','7',NULL,'new message','tes','msg'),('207e7205-9ef3-4cde-bff5-1f16ab43b964','2022-07-06 04:05:21.524','2022-07-06 04:05:21.525','8',NULL,'new message','tes','msg'),('2114afc0-c307-4a8c-9928-59d58fe4baf3','2022-07-05 16:08:11.157','2022-07-05 16:08:11.158','7',NULL,'new message','tes','msg'),('26467b60-aef2-478d-9fef-c2412e3002fd','2022-07-08 06:22:46.851','2022-07-08 06:22:46.852','4',NULL,'new message','new Image Message','msg'),('2a5d417c-1d5a-47c3-91ef-32d135e91a3b','2022-07-06 07:34:41.707','2022-07-06 07:34:41.708','7',NULL,'new message','satu','msg'),('2b5ea5cb-09fe-4c16-af45-ceacfb04ac53','2022-07-06 04:09:18.626','2022-07-06 04:09:18.627','8',NULL,'new message','tes\'','msg'),('2d4762fc-299b-4fc8-b8cf-77e2bfd24ae9','2022-07-05 18:19:42.722','2022-07-05 18:19:42.722','7',NULL,'new message','halo test','msg'),('3470aad0-47dc-4bf6-ba82-be9a1495d6bd','2022-07-06 07:40:10.074','2022-07-06 07:40:10.075','7',NULL,'new message','tes','msg'),('36a81d65-721c-4de4-a4de-095b9b14266f','2022-07-05 17:04:00.319','2022-07-05 17:04:00.319','7',NULL,'new message','apanya ya','msg'),('370d8c39-5bb2-4f7e-9902-3e5d3ae2fc53','2022-07-14 03:59:22.792','2022-07-14 03:59:22.794','7',NULL,'new message','new Image Message','msg'),('3cecdfac-00c4-4f9b-990f-23182d2c961e','2022-07-06 07:57:44.165','2022-07-06 07:57:44.166','7',NULL,'new message','tos','msg'),('414eaf46-bf52-4896-9598-9c60136ca2c9','2022-07-06 07:40:02.689','2022-07-06 07:40:02.696','7',NULL,'new message','halo','msg'),('43a6e3a7-d15b-457e-9cfc-854a78d7b5f5','2022-07-06 04:07:55.314','2022-07-06 04:07:55.315','8',NULL,'new message','tes','msg'),('4bc70f2a-5d9d-421c-9bdc-7dd4a3d82309','2022-07-06 07:57:41.874','2022-07-06 07:57:41.875','7',NULL,'new message','tor','msg'),('4d688365-49ea-4fce-9c79-41a5c97c7069','2022-07-07 07:49:41.143','2022-07-07 07:49:41.144','7',NULL,'new message','new Image Message','msg'),('510696be-6806-49ec-af7c-eab0e031b1ed','2022-07-05 17:17:10.883','2022-07-05 17:17:10.883','7',NULL,'new message','ini ada dimana','msg'),('5367a0bb-5acb-46e4-990e-291953ac6e17','2022-07-05 17:03:53.894','2022-07-05 17:03:53.894','7',NULL,'new message','dimana ya','msg'),('58159ec1-1f6b-4e13-80e0-5998791b4f1f','2022-07-10 09:50:44.311','2022-07-10 09:50:44.312','7',NULL,'new message','[ image ]','msg'),('58ec0bb2-11be-4b78-bff2-1477f67986da','2022-07-05 16:08:19.549','2022-07-05 16:08:19.549','7',NULL,'new message','ini ada dimana','msg'),('5ab196d8-19b6-48b4-9db1-1b87e3e6cb91','2022-07-06 03:20:42.993','2022-07-06 03:20:42.993','7',NULL,'new message','tes','msg'),('604021fa-c8c9-4088-b7a0-880ab829c181','2022-07-06 04:10:52.292','2022-07-06 04:10:52.292','8',NULL,'new message','tes','msg'),('60adb316-fefa-41ef-8ee9-f809a3a64e61','2022-07-06 07:57:35.402','2022-07-06 07:57:35.403','7',NULL,'new message','tes','msg'),('6aabd224-3c0a-4de2-a3be-527b033fc9ca','2022-07-06 13:44:13.466','2022-07-06 13:44:13.467','7',NULL,'new message','new Image Message','msg'),('6c7808c2-353d-46fb-9c06-e6ad5841f4ee','2022-07-05 18:23:29.060','2022-07-05 18:23:29.066','4',NULL,'new message','ya','msg'),('6d191424-29b2-4b0e-ad07-d4873c00c7f4','2022-07-06 13:28:32.778','2022-07-06 13:28:32.779','7',NULL,'new message','new Image Message','msg'),('6f931ff9-49a2-4473-8c5b-47ad6f40c614','2022-07-10 09:50:22.204','2022-07-10 09:50:22.204','7',NULL,'new message','ada olang ?','msg'),('730a2088-afbd-4c18-970e-587dda633564','2022-07-05 16:34:16.035','2022-07-05 16:34:16.035','7',NULL,'new message','ini dimana','msg'),('7ac492ad-9791-4125-b716-e08bddb4a1be','2022-07-06 13:37:18.122','2022-07-06 13:37:18.123','7',NULL,'new message','new Image Message','msg'),('7bad3136-349f-4da4-a49d-a23c2b7575c5','2022-07-06 08:23:16.506','2022-07-06 08:23:16.506','7',NULL,'new message','new Image Message','msg'),('7c532a9b-e514-4940-976c-67101ab15332','2022-07-05 16:26:37.051','2022-07-05 16:26:37.052','7',NULL,'new message','ini','msg'),('7d24f125-e563-432a-af95-ecd3cee48db2','2022-07-06 07:34:45.673','2022-07-06 07:34:45.674','7',NULL,'new message','dua','msg'),('7e92b59b-9f12-49dd-a7ec-824acf0d7f3e','2022-07-06 13:36:40.281','2022-07-06 13:36:40.282','7',NULL,'new message','new Image Message','msg'),('7f802cf2-96ba-44c9-adc5-c097563716ff','2022-07-06 07:34:36.750','2022-07-06 07:34:36.750','7',NULL,'new message','tes','msg'),('7f9be9a4-ad53-4f6c-bc81-168bd9d8016e','2022-07-06 03:24:37.645','2022-07-06 03:24:37.645','7',NULL,'new message','new Image Message','msg'),('81d6d921-eeea-45bc-8239-013e092e7c06','2022-07-06 13:37:45.162','2022-07-06 13:37:45.163','7',NULL,'new message','new Image Message','msg'),('93346394-e706-476a-a7fc-e61e5504171f','2022-07-06 08:22:59.335','2022-07-06 08:22:59.335','7',NULL,'new message','halo','msg'),('963a842c-331b-45f3-8b2d-bda9874d968e','2022-07-06 03:20:30.356','2022-07-06 03:20:30.357','8',NULL,'new message','tes ini dimana','msg'),('9954366c-63af-4384-96e7-458c84ae6c6e','2022-07-06 08:22:09.058','2022-07-06 08:22:09.058','7',NULL,'new message','[ image ]','msg'),('9ba92bdd-3bef-4aa4-b58d-13f5b33791f8','2022-07-10 05:10:33.828','2022-07-10 05:10:33.829','7',NULL,'new message','disini','msg'),('a496e497-4820-4a9f-b490-7c15a8d7b6a3','2022-07-06 13:42:26.877','2022-07-06 13:42:26.878','7',NULL,'new message','new Image Message','msg'),('a545e139-de82-42df-a570-7acfb2f2b8e1','2022-07-05 17:03:37.675','2022-07-05 17:03:37.676','7',NULL,'new message','halo','msg'),('abe574ed-4d3e-4013-8ba1-7e3730c55898','2022-07-06 07:40:13.605','2022-07-06 07:40:13.605','7',NULL,'new message','tos','msg'),('b71a195a-a8b0-484a-8b8f-997da9c632cd','2022-07-10 05:07:22.094','2022-07-10 05:07:22.095','7',NULL,'new message','[ image ]','msg'),('be27e9f8-653b-4540-ba44-5568cb8e32e9','2022-07-05 16:26:45.096','2022-07-05 16:26:45.097','7',NULL,'new message','halo','msg'),('c0c701a3-69da-418e-b94d-212119aebc30','2022-07-05 16:34:12.452','2022-07-05 16:34:12.453','7',NULL,'new message','ya halo','msg'),('c17826e1-6057-4ffb-8b04-cd7a977518b2','2022-07-05 17:03:44.067','2022-07-05 17:03:44.067','7',NULL,'new message','ini bisa tolong','msg'),('c70f4259-b1a9-421b-8897-9f0cd647c9d6','2022-07-05 18:23:34.873','2022-07-05 18:23:34.874','7',NULL,'new message','ini dimana','msg'),('c95759ba-840a-490f-a5ed-77f9895a0d99','2022-07-06 03:21:11.658','2022-07-06 03:21:11.659','7',NULL,'new message','tes','msg'),('cb13f60d-3cee-4e85-a62b-a912fca4fe05','2022-07-14 03:06:53.121','2022-07-14 03:06:53.122','7',NULL,'new message','new Image Message','msg'),('cbff19dc-9b5d-4441-a009-402825daa3c3','2022-07-06 13:35:30.782','2022-07-06 13:35:30.782','7',NULL,'new message','new Image Message','msg'),('cf62c167-e1dd-4acc-a495-30c55d1154c8','2022-07-06 08:22:41.738','2022-07-06 08:22:41.738','7',NULL,'new message','halo','msg'),('d15354e4-24db-4e74-b1c7-56bfca6e8bb8','2022-07-14 02:57:03.148','2022-07-14 02:57:03.149','7',NULL,'new message','new Image Message','msg'),('d3c38eb2-cb87-4223-964f-94b2e88a4d27','2022-07-07 07:38:04.029','2022-07-07 07:38:04.030','7',NULL,'new message','new Image Message','msg'),('e0e91aa8-19ab-43d0-9c3d-c417cdb39bd0','2022-07-06 03:21:28.508','2022-07-06 03:21:28.508','7',NULL,'new message','tes','msg'),('e281da82-50e5-4055-9a51-27a521c8f05e','2022-07-08 06:32:25.811','2022-07-08 06:32:25.811','7',NULL,'new message','new Image Message','msg'),('e623740c-9e66-4e2f-a6d2-d555a302d684','2022-07-05 16:27:37.049','2022-07-05 16:27:37.050','7',NULL,'new message','new Image Message','msg'),('e75ff652-938f-4d26-ba22-37333a9e7632','2022-07-06 13:36:14.103','2022-07-06 13:36:14.104','7',NULL,'new message','new Image Message','msg'),('ef34086b-a2f5-4569-b34a-07cde8e8c070','2022-07-05 18:23:46.328','2022-07-05 18:23:46.329','4',NULL,'new message','test','msg'),('f2f5dc7a-5c41-42c2-a505-401e50954e57','2022-07-06 07:57:38.915','2022-07-06 07:57:38.916','7',NULL,'new message','ini tes','msg'),('f61feb0b-7596-416e-97f1-e7dec6927d72','2022-07-06 03:16:01.886','2022-07-06 03:16:01.887','7',NULL,'new message','tes','msg'),('f9e8f393-03f1-4729-acf5-5510f04fe62f','2022-07-06 04:08:15.296','2022-07-06 04:08:15.297','8',NULL,'new message','tes','msg'),('fae379e8-5443-4c04-889f-cd77dc676b71','2022-07-06 03:21:20.120','2022-07-06 03:21:20.121','7',NULL,'new message','detai','msg'),('fdfb5456-a927-4df5-8d55-7d7373f45298','2022-07-05 16:26:52.853','2022-07-05 16:26:52.853','7',NULL,'new message','siapa ya','msg');
/*!40000 ALTER TABLE `Notif` ENABLE KEYS */;
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
-- Table structure for table `Todos`
--

DROP TABLE IF EXISTS `Todos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Todos` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updatedAt` datetime(3) NOT NULL,
  `usersId` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT 'open',
  `departementsId` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Todos_usersId_fkey` (`usersId`),
  KEY `Todos_departementsId_fkey` (`departementsId`),
  CONSTRAINT `Todos_departementsId_fkey` FOREIGN KEY (`departementsId`) REFERENCES `Departements` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `Todos_usersId_fkey` FOREIGN KEY (`usersId`) REFERENCES `Users` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Todos`
--

LOCK TABLES `Todos` WRITE;
/*!40000 ALTER TABLE `Todos` DISABLE KEYS */;
INSERT INTO `Todos` VALUES ('0093275b-923d-40b0-8c86-d53bd30deca2','2022-07-19 06:30:48.459','2022-07-18 06:35:03.622','7','sddsdsd','sdasdasdasdsadas','open',NULL),('0ca89586-192a-45e6-93c9-e7b3a11cac33','2022-07-03 16:00:00.000','2022-07-19 04:12:43.878','7','sdsddsd','sdsdsdsds','close',NULL),('0ccec649-db93-4e4a-be15-9941f93d11df','2022-07-09 16:00:00.000','2022-07-18 07:30:55.629','7','mau beli makan','ini mau beli makan','open',NULL),('0d04da69-9006-4f9a-9222-e0b5b4892860','2022-07-20 01:38:11.319','2022-07-19 02:50:15.611','7','zxzxzx','xzxzxzxz','close',NULL),('17654ce4-87cb-48b8-a7f1-d61fc2e55635','2022-07-27 16:00:00.000','2022-07-12 08:59:48.297','7','dsdsds','dsdsdsdsd','open',NULL),('17b3b449-113b-4589-a78e-6e51823707f9','2022-07-19 08:59:38.568','2022-07-18 09:00:09.620','7','sdsdsdsdsds','dsdsdsds','open',NULL),('18cae14d-0613-4dd6-9fa1-652e59047b2f','2022-07-03 16:00:00.000','2022-07-13 03:13:14.872','7','nknknk','nknknk','open',NULL),('1a63fe70-cc1d-48d5-8b41-d5d37ad5c7e7','2022-07-25 17:00:00.000','2022-07-12 08:58:45.149','7','dsdsdsd','dsdsdsdsds','open',NULL),('255772b8-a92c-417f-b77a-3be86d88ae41','2022-07-27 16:00:00.000','2022-07-25 02:09:40.946','14','sdsdsdsfdfd','sdsdsdsfdfdfd4444','close',NULL),('448bafc7-5cee-48bd-ac68-406d712c883d','2022-07-02 16:00:00.000','2022-07-19 02:50:31.144','7','tambah ','satu lagi','close',NULL),('45e918fe-af8e-4264-91f4-985662da56d1','2022-07-11 16:00:00.000','2022-07-18 07:38:03.686','7','dsdsdsd','dsdsdsdsds','open',NULL),('4692b9e7-de29-4023-8595-c15968ae0916','2022-07-16 16:00:00.000','2022-07-12 09:00:03.177','7','dsdsds','sdsdsdsdsds','open',NULL),('47e1383f-0cd6-4c5d-ad5f-9012f1c906cc','2022-07-27 16:00:00.000','2022-07-12 08:59:44.492','7','dsdsdsds','dsdsds','open',NULL),('4f13700f-e8ca-4b72-93fd-f178b59638bc','2022-07-05 16:00:00.000','2022-07-19 02:50:38.662','7','sddsd','sdsdsdsds','close',NULL),('64014311-75a1-4c23-ad34-3b2d2b6ef31e','2022-07-19 08:38:16.003','2022-07-18 08:38:20.000','7','dsdsds','dsdsds','open',NULL),('6a60ac0a-474f-4325-8918-b241765ffa28','2022-07-03 16:00:00.000','2022-07-18 07:38:42.976','7','dsdsds','dsdsdsd','open',NULL),('701cbc1e-44ce-4c2d-9223-b166041ffb16','2022-07-15 16:00:00.000','2022-07-18 08:14:37.518','7','dsdsdsds','dsdsdsds','open',NULL),('70661521-b4f2-4cac-9ab1-057c1413f58b','2022-07-20 16:00:00.000','2022-07-25 02:13:49.980','14','sdsds','sdsdsds','close',NULL),('72ac65cb-976c-4337-ba69-3dc2c898a68c','2022-07-03 16:00:00.000','2022-07-18 07:45:52.582','7','nnjbjnj','','open',NULL),('7d6f90d2-deca-4f51-8c9c-582f8c9ea899','2022-07-20 16:00:00.000','2022-07-20 07:48:10.399','7','sasasa','sasasas','open',NULL),('8e9ab539-630f-4fe6-b4f8-32c9700c006e','2022-07-31 16:00:00.000','2022-07-18 08:15:43.568','7','test apa 07','ini ditest','open',NULL),('a03ef2c6-b95b-4810-a258-015cc6f94c77','2022-07-04 16:00:00.000','2022-07-18 07:41:03.957','7','ngetes aja','ini adalah satu','open',NULL),('a260da1b-41b2-4cc0-b6ea-a4fdba5632c6','2022-07-20 01:38:11.319','2022-07-19 01:38:15.157','7','ssxzx','xzxzxzxz','open',NULL),('a4b21ada-ee88-4216-967a-c42f1844169d','2022-06-30 16:00:00.000','2022-07-18 07:39:04.582','7','satu ','tes aja','open',NULL),('a977bddf-f1bb-4441-8a33-18af34e000f1','2022-07-21 16:00:00.000','2022-07-25 06:31:13.169','7','cscss','csscscs','close',NULL),('ada518bf-e3a1-41ab-a529-39a52e2b5b80','2022-07-21 16:00:00.000','2022-07-25 06:31:15.867','7','sdsdsd','dsdsdsd','close',NULL),('ada5a7f6-6776-43cb-aafd-cac33bd5c529','2022-07-01 17:00:00.000','2022-07-12 08:58:22.118','7','sdsdsd','dsdsdsds','open',NULL),('b125c886-d83c-4e0b-b73d-1a177b3714b3','2022-07-04 16:00:00.000','2022-07-18 07:45:56.773','7','dsdsds','sdsdsds','open',NULL),('c092e489-ddb2-467e-8dad-faadbd645f83','2022-07-19 08:38:16.003','2022-07-18 08:38:27.740','7','sdsds','sdsdsds','open',NULL),('c15fa9a0-4e06-414a-a10a-3ac1e79a8c9e','2022-07-19 06:30:48.459','2022-07-18 07:21:01.834','7','ini malik','dsadsadsad','open',NULL),('c6b036c5-57fd-4b36-bac6-463698df6f15','2022-07-14 16:00:00.000','2022-07-18 08:38:30.902','7','dsds','sdsds','open',NULL),('c9fc7c80-d7b5-45fe-ab72-6c360d6ce2ab','2022-07-19 08:38:16.003','2022-07-18 08:38:24.635','7','ddsds','sdsds','open',NULL),('cfb2a465-669a-4662-98be-1e69877aaa13','2022-07-19 16:00:00.000','2022-07-18 03:30:26.215','9','sssd','dsdsds','open',NULL),('dc07699d-a272-4c80-a3ba-9f0413cdcbf8','2022-06-30 16:00:00.000','2022-07-18 07:39:40.922','7','satu dua tiga','ini stu','close',NULL),('ea54a50d-0dff-495b-94f8-d4ab43e35439','2022-07-19 06:30:48.459','2022-07-18 06:35:10.323','7','sdsadsadsa','adssadsadsa','open',NULL),('f1d5b43f-db97-49d9-912d-4827233bb1df','2022-07-05 16:00:00.000','2022-07-18 08:57:20.376','7','dsdsdsds','dsdsdsds','open',NULL),('f4c10855-70e4-4f0b-9a19-bc4f0ff2853d','2022-07-18 16:00:00.000','2022-07-18 03:44:41.031','9','dsdsd','dsdsds','close',NULL);
/*!40000 ALTER TABLE `Todos` ENABLE KEYS */;
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
  `departementsId` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Users_departementsId_fkey` (`departementsId`),
  KEY `Users_rolesId_fkey` (`rolesId`),
  CONSTRAINT `Users_departementsId_fkey` FOREIGN KEY (`departementsId`) REFERENCES `Departements` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `Users_rolesId_fkey` FOREIGN KEY (`rolesId`) REFERENCES `Roles` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Users`
--

LOCK TABLES `Users` WRITE;
/*!40000 ALTER TABLE `Users` DISABLE KEYS */;
INSERT INTO `Users` VALUES ('013a13ac-d372-4404-bcad-379043655b44','ana','ana@gamail.com','123456',NULL,NULL),('1','ayu','ayu@gmail.com','123456','3',NULL),('10','david','david@gmail.com','123456','1',NULL),('11','widia','widia@gmail.com','123456','1',NULL),('12','ayu ari','ayu_ari@gmail.com','123456','1','5'),('13','yuni','yuni@gmail.com','123456','1','5'),('14','malik','malik@gmail.com','123456','1','3'),('2','guntur','guntur@gmail.com','123456','2','1'),('3','adi','adi@gmail.com','123456','2','4'),('4','apit','apit@gmail.com','123456','1',NULL),('5','ariska','ariska@gmail.com','123456','1',NULL),('6','bayu','bayu@gmail.com','123456','1',NULL),('7','dewi','dewi@gmail.com','123456','2','2'),('8','ahmad','ahmad@gmail.com','123456','4','3'),('9','gede','gede@gmail.com','123456','1','3');
/*!40000 ALTER TABLE `Users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-07-26 14:41:58
