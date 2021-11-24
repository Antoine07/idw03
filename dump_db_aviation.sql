-- MySQL dump 10.13  Distrib 5.7.32, for osx10.12 (x86_64)
--
-- Host: localhost    Database: db_aviation
-- ------------------------------------------------------
-- Server version	5.7.32

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `db_aviation`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `db_aviation` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */;

USE `db_aviation`;

--
-- Table structure for table `compagnies`
--

DROP TABLE IF EXISTS `compagnies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `compagnies` (
  `comp` char(4) COLLATE utf8mb4_unicode_ci NOT NULL,
  `street` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `numStreet` tinyint(3) unsigned DEFAULT NULL,
  `status` enum('published','unpublished','draft') COLLATE utf8mb4_unicode_ci DEFAULT 'draft',
  PRIMARY KEY (`comp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `compagnies`
--

LOCK TABLES `compagnies` WRITE;
/*!40000 ALTER TABLE `compagnies` DISABLE KEYS */;
INSERT INTO `compagnies` VALUES ('AUS','sidney','Australie','AUSTRA Air',19,'draft'),('CHI','chi','Chine','CHINA Air',NULL,'draft'),('FRE1','beaubourg','France','Air France',17,'draft'),('FRE2','paris','France','Air Electric',22,'draft'),('ITA','Napoli','Rome','Italia Air',20,'draft'),('SIN','pasir','Australie','AUSTRA Air',15,'draft');
/*!40000 ALTER TABLE `compagnies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `new_compagnies`
--

DROP TABLE IF EXISTS `new_compagnies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `new_compagnies` (
  `comp` char(4) COLLATE utf8mb4_unicode_ci NOT NULL,
  `street` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `numStreet` tinyint(3) unsigned DEFAULT NULL,
  `status` enum('published','unpublished','draft') COLLATE utf8mb4_unicode_ci DEFAULT 'draft'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `new_compagnies`
--

LOCK TABLES `new_compagnies` WRITE;
/*!40000 ALTER TABLE `new_compagnies` DISABLE KEYS */;
INSERT INTO `new_compagnies` VALUES ('AUS','sidney','Australie','AUSTRA Air',19,'draft');
/*!40000 ALTER TABLE `new_compagnies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pilots`
--

DROP TABLE IF EXISTS `pilots`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pilots` (
  `certificate` varchar(6) COLLATE utf8mb4_unicode_ci NOT NULL,
  `numFlying` decimal(7,1) DEFAULT NULL,
  `compagny` char(4) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `plane` enum('A380','A320','A340') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bonus` decimal(5,1) DEFAULT NULL,
  `created` datetime DEFAULT CURRENT_TIMESTAMP,
  `birth_date` datetime DEFAULT NULL,
  `next_flight` datetime DEFAULT NULL,
  `num_jobs` tinyint(3) unsigned DEFAULT NULL,
  PRIMARY KEY (`certificate`),
  KEY `fk_pilots_compagny_compagnies_comp` (`compagny`),
  CONSTRAINT `fk_pilots_compagny_compagnies_comp` FOREIGN KEY (`compagny`) REFERENCES `compagnies` (`comp`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pilots`
--

LOCK TABLES `pilots` WRITE;
/*!40000 ALTER TABLE `pilots` DISABLE KEYS */;
INSERT INTO `pilots` VALUES ('ct-1',90.0,'AUS','Alan','A380',1000.0,'2021-11-22 13:02:50',NULL,NULL,NULL),('ct-10',90.0,'FRE1','Tom','A320',500.0,'2021-11-22 13:02:50',NULL,NULL,NULL),('ct-100',200.0,'SIN','Yi','A340',500.0,'2021-11-22 13:02:50','1978-02-04 00:00:00','2020-12-04 09:50:52',10),('ct-11',200.0,'AUS','Sophie','A380',1000.0,'2021-11-22 13:02:50','1978-10-17 00:00:00','2020-06-11 12:00:52',50),('ct-12',190.0,'AUS','Albert','A380',1000.0,'2021-11-22 13:02:50','1990-04-04 00:00:00','2020-05-08 12:50:52',10),('ct-16',190.0,'SIN','Yan','A340',500.0,'2021-11-22 13:02:50','1998-01-04 00:00:00','2020-05-08 12:50:52',30),('ct-56',300.0,'AUS','Benoit','A380',2000.0,'2021-11-22 13:02:50','2000-01-04 00:00:00','2020-02-04 12:50:52',7),('ct-6',20.0,'FRE1','Jhon','A320',500.0,'2021-11-22 13:02:50','2000-01-04 00:00:00','2020-12-04 12:50:52',13),('ct-7',80.0,'CHI','Pierre','A320',500.0,'2021-11-22 13:02:50','1977-01-04 00:00:00','2020-05-04 12:50:52',8);
/*!40000 ALTER TABLE `pilots` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-11-24 11:06:18
