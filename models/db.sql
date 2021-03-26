-- MySQL dump 10.13  Distrib 8.0.21, for Win64 (x86_64)
--
-- Host: localhost    Database: sokial
-- ------------------------------------------------------
-- Server version	8.0.21

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
-- Current Database: `sokial`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `sokial` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `sokial`;

--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `post_id` int NOT NULL,
  `author_user_id` int DEFAULT NULL,
  `content` varchar(14000) NOT NULL,
  `timestamp` datetime NOT NULL,
  `reactions_counter` int NOT NULL DEFAULT '0',
  `author_type` char(1) NOT NULL,
  `author_page_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `com_user_id_fk` (`author_user_id`),
  KEY `com_of_post_id_fk` (`post_id`),
  KEY `com_page_id_fk` (`author_page_id`),
  CONSTRAINT `com_of_post_id_fk` FOREIGN KEY (`post_id`) REFERENCES `post` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `com_page_id_fk` FOREIGN KEY (`author_page_id`) REFERENCES `page` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `com_user_id_fk` FOREIGN KEY (`author_user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
INSERT INTO `comment` VALUES (23,9,45,'Helllooooooo','2021-02-02 08:18:00',0,'U',NULL),(25,25,30,'ABC','2021-02-02 11:23:17',0,'U',NULL),(28,31,30,'helloooo','2021-02-03 10:49:33',0,'U',NULL),(29,31,30,'hellooooooo mooooooreeee!!!','2021-02-03 10:49:54',0,'U',NULL),(30,31,30,'asdadsasd','2021-02-03 10:52:09',0,'U',NULL),(31,25,30,'DEF','2021-02-03 11:32:47',0,'U',NULL),(33,25,30,'kjljlj','2021-02-11 23:19:00',0,'U',NULL),(36,32,31,'Booooooring','2021-02-15 09:19:51',0,'U',NULL),(37,31,30,'HAHAHAHAHAHAHA !@#!#!@#!@3 ┘É╪│┘è╪┤┘è╪┤','2021-02-16 03:15:52',0,'U',NULL),(38,37,30,'jkjkljkj','2021-02-19 03:04:27',0,'U',NULL),(39,37,30,'asd','2021-02-19 04:34:55',0,'U',NULL),(43,109,30,'23123 123 123 \n\n\n','2021-03-18 20:27:42',0,'U',NULL),(44,119,30,'aa','2021-03-19 00:43:49',0,'U',NULL),(45,119,30,'Hello world!!!?!!!','2021-03-19 01:10:04',0,'U',NULL),(47,119,30,'123123\n12\n31\n2312\n3','2021-03-19 01:10:05',0,'U',NULL),(50,119,30,'qqqqq','2021-03-19 02:03:10',0,'U',NULL),(51,119,30,'qqqqq','2021-03-19 02:03:48',0,'U',NULL),(52,119,30,'1212 1 2 1','2021-03-19 02:03:57',0,'U',NULL),(53,119,30,' 123 123','2021-03-19 02:05:14',0,'U',NULL),(54,119,30,'123  3 sad ','2021-03-19 02:09:49',0,'U',NULL),(55,115,30,'1 2 3','2021-03-19 02:11:59',0,'U',NULL),(56,114,30,'1 444444','2021-03-19 02:13:08',0,'U',NULL),(57,114,30,'zzzzz','2021-03-19 02:15:03',0,'U',NULL),(58,114,30,'1 4444441','2021-03-19 02:15:11',0,'U',NULL),(59,114,30,'asda dq qwe','2021-03-19 02:20:31',0,'U',NULL),(60,119,30,'','2021-03-19 20:51:35',0,'U',NULL),(61,115,30,'1','2021-03-19 20:51:57',0,'U',NULL),(62,119,30,'123','2021-03-20 16:33:20',0,'U',NULL),(63,119,30,'123313212313123132','2021-03-20 16:36:11',0,'U',NULL),(64,119,30,'hahahaha','2021-03-20 16:37:53',0,'U',NULL),(65,119,30,'asdasd ad asd a1231 123 sd ','2021-03-20 16:39:15',0,'U',NULL),(66,115,30,'123132 v1 32','2021-03-20 16:41:37',0,'U',NULL),(67,119,30,'sadqwe qwe qwe eqwe \nqw e\nqe qw\n               ','2021-03-20 16:59:03',0,'U',NULL),(68,115,30,'1111111','2021-03-20 17:00:28',0,'U',NULL),(69,114,30,'11111111111111111','2021-03-20 17:09:07',0,'U',NULL),(70,114,30,'11111111111111111','2021-03-20 17:09:08',0,'U',NULL),(71,114,30,'','2021-03-20 17:09:11',0,'U',NULL),(72,128,30,'1233 12 3 32','2021-03-20 19:27:21',0,'U',NULL),(73,128,30,'╪▒╪¼┘ê┘ä╪⌐ <3','2021-03-20 19:27:31',0,'U',NULL),(74,131,30,'Hello bro!!','2021-03-22 15:09:32',0,'U',NULL),(75,144,30,'123 123   ','2021-03-22 15:21:09',0,'U',NULL),(76,147,30,' 123 123 13 ','2021-03-22 15:23:04',0,'U',NULL),(77,150,30,' 123 3 3','2021-03-22 15:38:34',0,'U',NULL),(78,150,30,'333','2021-03-22 15:38:42',0,'U',NULL),(79,151,30,'33333 3333','2021-03-22 15:38:51',0,'U',NULL),(80,152,30,'1231321 123','2021-03-22 15:39:11',0,'U',NULL),(81,153,30,'3','2021-03-22 15:39:14',0,'U',NULL),(82,153,30,'1111','2021-03-22 15:40:02',0,'U',NULL),(84,182,30,'111111','2021-03-22 19:31:11',0,'U',NULL),(85,182,30,'sdadada\nsda\nsd\nasd\nas\ndaddddddddddddd','2021-03-22 19:31:17',0,'U',NULL),(86,181,30,'1\n\n\n\n\n\n\n\n\n\n\n','2021-03-22 19:31:32',0,'U',NULL),(87,181,30,'dddddddd\n\n\n\n\n\n\n\n\n\n\n\n\nd','2021-03-22 19:31:58',0,'U',NULL),(88,192,30,'╪ª╪ª╪ª','2021-03-22 22:56:00',0,'U',NULL),(89,209,30,'asdasd ada sdasd asd','2021-03-23 04:19:37',0,'U',NULL),(90,209,30,'heyyyyy','2021-03-23 04:19:58',0,'U',NULL),(91,207,30,'12 313 13','2021-03-23 04:21:54',0,'U',NULL),(92,207,30,'zzzz','2021-03-23 05:27:18',0,'U',NULL),(93,207,30,' 12313b 1123 3 13213 123123 1','2021-03-23 05:31:54',0,'U',NULL);
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `increase_comment_count_when_insert` AFTER INSERT ON `comment` FOR EACH ROW UPDATE post SET post.comments_counter = post.comments_counter + 1 where post.id = new.post_id */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `decrease_comment_count_when_delete` AFTER DELETE ON `comment` FOR EACH ROW UPDATE post SET post.comments_counter = post.comments_counter - 1 where post.id = old.post_id */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `friend`
--

DROP TABLE IF EXISTS `friend`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `friend` (
  `user1_id` int NOT NULL,
  `user2_id` int NOT NULL,
  PRIMARY KEY (`user1_id`,`user2_id`),
  KEY `user2_id` (`user2_id`),
  KEY `friends_index` (`user1_id`,`user2_id`),
  CONSTRAINT `friend_ibfk_3` FOREIGN KEY (`user1_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `friend_ibfk_4` FOREIGN KEY (`user2_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `friend`
--

LOCK TABLES `friend` WRITE;
/*!40000 ALTER TABLE `friend` DISABLE KEYS */;
INSERT INTO `friend` VALUES (31,30),(30,41),(30,42),(30,43),(30,44);
/*!40000 ALTER TABLE `friend` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `friendship_request`
--

DROP TABLE IF EXISTS `friendship_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `friendship_request` (
  `sender_id` int NOT NULL,
  `receiver_id` int NOT NULL,
  `timestamp` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`sender_id`,`receiver_id`),
  KEY `friendship_request_ibfk_4` (`receiver_id`),
  CONSTRAINT `friendship_request_ibfk_3` FOREIGN KEY (`sender_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `friendship_request_ibfk_4` FOREIGN KEY (`receiver_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `friendship_request`
--

LOCK TABLES `friendship_request` WRITE;
/*!40000 ALTER TABLE `friendship_request` DISABLE KEYS */;
/*!40000 ALTER TABLE `friendship_request` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group`
--

DROP TABLE IF EXISTS `group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_manager_id` int DEFAULT NULL,
  `name` varchar(20) NOT NULL,
  `about_us` varchar(1000) DEFAULT NULL,
  `number_of_members` int DEFAULT NULL,
  `creation_date` datetime DEFAULT NULL,
  `group_photo_id` int DEFAULT NULL,
  `privacy` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_grp_manager` (`user_manager_id`),
  CONSTRAINT `group_ibfk_1` FOREIGN KEY (`user_manager_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group`
--

LOCK TABLES `group` WRITE;
/*!40000 ALTER TABLE `group` DISABLE KEYS */;
/*!40000 ALTER TABLE `group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group_member`
--

DROP TABLE IF EXISTS `group_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `group_member` (
  `group_id` int NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`group_id`,`user_id`),
  KEY `fk_mmbr_id` (`user_id`),
  CONSTRAINT `fk_grp_id` FOREIGN KEY (`group_id`) REFERENCES `group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_mmbr_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group_member`
--

LOCK TABLES `group_member` WRITE;
/*!40000 ALTER TABLE `group_member` DISABLE KEYS */;
/*!40000 ALTER TABLE `group_member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group_membership_request`
--

DROP TABLE IF EXISTS `group_membership_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `group_membership_request` (
  `group_id` int NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`group_id`,`user_id`),
  KEY `fk_mmbr_id2` (`user_id`),
  CONSTRAINT `fk_grp_id2` FOREIGN KEY (`group_id`) REFERENCES `group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_mmbr_id2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group_membership_request`
--

LOCK TABLES `group_membership_request` WRITE;
/*!40000 ALTER TABLE `group_membership_request` DISABLE KEYS */;
/*!40000 ALTER TABLE `group_membership_request` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page`
--

DROP TABLE IF EXISTS `page`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `page` (
  `id` int NOT NULL AUTO_INCREMENT,
  `owner_user_id` int NOT NULL,
  `name` varchar(30) NOT NULL,
  `about_us` varchar(255) DEFAULT NULL,
  `creation_date` datetime NOT NULL,
  `number_followers` int NOT NULL DEFAULT '0',
  `page_photo_id` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page`
--

LOCK TABLES `page` WRITE;
/*!40000 ALTER TABLE `page` DISABLE KEYS */;
/*!40000 ALTER TABLE `page` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page_follower`
--

DROP TABLE IF EXISTS `page_follower`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `page_follower` (
  `followed_page_id` int NOT NULL,
  `follower_user_id` int NOT NULL,
  PRIMARY KEY (`followed_page_id`,`follower_user_id`),
  KEY `followed_page_id` (`followed_page_id`),
  KEY `user_following_ibfk_4` (`follower_user_id`),
  CONSTRAINT `user_following_ibfk_3` FOREIGN KEY (`followed_page_id`) REFERENCES `page` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_following_ibfk_4` FOREIGN KEY (`follower_user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page_follower`
--

LOCK TABLES `page_follower` WRITE;
/*!40000 ALTER TABLE `page_follower` DISABLE KEYS */;
/*!40000 ALTER TABLE `page_follower` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post`
--

DROP TABLE IF EXISTS `post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post` (
  `id` int NOT NULL AUTO_INCREMENT,
  `author_user_id` int DEFAULT NULL,
  `timestamp` datetime NOT NULL,
  `content` varchar(14000) NOT NULL,
  `reactions_counter` int NOT NULL DEFAULT '0',
  `comments_counter` int NOT NULL DEFAULT '0',
  `privacy` int NOT NULL DEFAULT (4),
  `post_type` char(1) NOT NULL,
  `group_id` int DEFAULT NULL,
  `author_page_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `page_author_id` (`author_page_id`),
  KEY `group_id` (`group_id`),
  KEY `post_ibfk_1` (`author_user_id`),
  CONSTRAINT `post_ibfk_1` FOREIGN KEY (`author_user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `post_ibfk_2` FOREIGN KEY (`author_page_id`) REFERENCES `page` (`id`),
  CONSTRAINT `post_ibfk_3` FOREIGN KEY (`group_id`) REFERENCES `group` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=210 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post`
--

LOCK TABLES `post` WRITE;
/*!40000 ALTER TABLE `post` DISABLE KEYS */;
INSERT INTO `post` VALUES (1,25,'1999-02-01 00:00:00','Hello my heart and world !! 2',0,0,2,'U',NULL,NULL),(3,25,'1999-02-01 00:00:00','Γò¬┬║Γöÿ├ÑΓò¬┬║ Γò¬ΓòúΓò¬┬║Γò¬┬║Γò¬┬║Γöÿ├¿Γò¬Γöñ Γöÿ├¬ Γöÿ├áΓò¬Γöñ Γò¬ΓòúΓò¬┬║Γöÿ├¿Γò¬Γöñ Γöÿ├¬Γöÿ├áΓò¬Γöñ Γöÿ├⌐Γò¬┬║Γò¬┬╗Γò¬ΓûÆ Γò¬ΓòúΓöÿ├ñΓöÿ├¿ Γò¬┬┐Γò¬ΓòúΓò¬┬╗Γöÿ├ó, Γöÿ├ºΓò¬┬║Γò¬┬¼ Γò¬┬½Γöÿ├ÑΓò¬┬╝Γò¬ΓûÆΓöÿ├¿Γöÿ├Ñ Γò¬┬┐Γöÿ├⌐Γöÿ├¿',0,0,1,'U',NULL,NULL),(9,32,'2021-01-27 04:45:54','Hey i\'m 32\n',0,1,5,'U',NULL,NULL),(20,30,'2021-01-28 08:49:41','3',2,0,5,'U',NULL,NULL),(25,30,'2021-01-28 08:49:57','7',3,3,5,'U',NULL,NULL),(30,31,'2021-02-02 20:21:27','Hellooooooooooooooooooooooooooooo',1,0,5,'U',NULL,NULL),(31,31,'2021-02-02 20:21:37','I\'m Fadllll broo',1,4,5,'U',NULL,NULL),(32,30,'2021-02-15 06:58:10','asaddsda asdasdsd',1,1,5,'U',NULL,NULL),(33,30,'2021-02-16 00:49:15','asddaa\nsda\ndas\nd\nas\ndadsadds',2,0,5,'U',NULL,NULL),(34,30,'2021-02-16 00:49:31','asdasdadasdadada,\nas\nda\nda\nd\nasdadas\ndasd\nad\nasddddddddddddddddddddddddd',0,0,5,'U',NULL,NULL),(37,30,'2021-02-16 00:51:15','33',0,2,5,'U',NULL,NULL),(93,30,'2021-03-18 17:48:25','123',1,0,5,'U',NULL,NULL),(97,30,'2021-03-18 17:48:39','e qwe1e23 qwe',1,0,5,'U',NULL,NULL),(99,30,'2021-03-18 17:48:48','zzzzz',1,0,5,'U',NULL,NULL),(100,30,'2021-03-18 17:48:53','12313123123123123hhhhhhhhhhh',0,0,5,'U',NULL,NULL),(101,30,'2021-03-18 17:48:56','213123asdzzz',1,0,5,'U',NULL,NULL),(102,30,'2021-03-18 17:49:01','1123ads',0,0,5,'U',NULL,NULL),(103,30,'2021-03-18 17:49:04','123 123 31 3123',3,0,5,'U',NULL,NULL),(106,30,'2021-03-18 17:49:14','1231',2,0,5,'U',NULL,NULL),(107,46,'2021-03-18 19:09:42','Hey ╪╣',0,0,5,'U',NULL,NULL),(109,30,'2021-03-18 20:26:16',' 123 32  hhhhh',0,1,5,'U',NULL,NULL),(112,30,'2021-03-18 23:51:49','123',0,0,5,'U',NULL,NULL),(113,30,'2021-03-18 23:52:47','asdadc',0,0,5,'U',NULL,NULL),(114,30,'2021-03-18 23:53:18','a sd  s ',0,7,5,'U',NULL,NULL),(115,30,'2021-03-18 23:53:44','ad1 12 13 12eqwe',0,4,5,'U',NULL,NULL),(119,30,'2021-03-18 23:58:10','aasd 123 ',0,14,5,'U',NULL,NULL),(120,30,'2021-03-20 18:01:05','123',0,0,5,'U',NULL,NULL),(121,30,'2021-03-20 18:10:34','Hello world!!',0,0,5,'U',NULL,NULL),(122,30,'2021-03-20 18:11:25','Hllllloooooaaaa',0,0,5,'U',NULL,NULL),(123,30,'2021-03-20 18:11:41','zzzz',1,0,5,'U',NULL,NULL),(124,30,'2021-03-20 18:11:51','123',1,0,5,'U',NULL,NULL),(125,30,'2021-03-20 18:14:34','123123 123132 13 13 123',0,0,5,'U',NULL,NULL),(127,30,'2021-03-20 18:21:56','heyyyy!!',1,0,5,'U',NULL,NULL),(128,30,'2021-03-20 19:27:14','haaaaaaaaaaaha',0,2,5,'U',NULL,NULL),(129,30,'2021-03-22 01:09:26','.',0,0,5,'U',NULL,NULL),(130,30,'2021-03-22 01:11:32',',',0,0,5,'U',NULL,NULL),(131,30,'2021-03-22 01:12:42','1',0,1,5,'U',NULL,NULL),(134,30,'2021-03-22 01:20:09','asd  asd ',0,0,5,'U',NULL,NULL),(135,30,'2021-03-22 01:21:14','1',0,0,5,'U',NULL,NULL),(136,30,'2021-03-22 01:23:34','4',0,0,5,'U',NULL,NULL),(137,30,'2021-03-22 01:24:19','4',0,0,5,'U',NULL,NULL),(141,30,'2021-03-22 15:18:03','5 5 5 5 5 5 5 5',0,0,5,'U',NULL,NULL),(142,30,'2021-03-22 15:18:39','123 123 132 ',0,0,5,'U',NULL,NULL),(143,30,'2021-03-22 15:19:06','123 123 123 ',0,0,5,'U',NULL,NULL),(144,30,'2021-03-22 15:20:28','123 123 ',0,1,5,'U',NULL,NULL),(145,30,'2021-03-22 15:21:18',' 123 123 132 123  33333',0,0,5,'U',NULL,NULL),(146,30,'2021-03-22 15:21:41','123 132 1  1233 3 ',0,0,5,'U',NULL,NULL),(147,30,'2021-03-22 15:22:16','44444 4444444',0,1,5,'U',NULL,NULL),(148,30,'2021-03-22 15:23:31','213 2333333',0,0,5,'U',NULL,NULL),(149,30,'2021-03-22 15:24:05','444',0,0,5,'U',NULL,NULL),(150,30,'2021-03-22 15:25:20','32 13132 ',0,2,5,'U',NULL,NULL),(151,30,'2021-03-22 15:38:20','123 3333',0,1,5,'U',NULL,NULL),(152,30,'2021-03-22 15:38:59','12313 133333',0,1,5,'U',NULL,NULL),(153,30,'2021-03-22 15:39:05','11',0,2,5,'U',NULL,NULL),(154,30,'2021-03-22 15:40:09','123 123',0,0,5,'U',NULL,NULL),(155,31,'2021-03-22 15:42:23','3333 3',0,0,5,'U',NULL,NULL),(156,31,'2021-03-22 16:39:55','11',0,0,5,'U',NULL,NULL),(157,31,'2021-03-22 16:40:36','1',0,0,5,'U',NULL,NULL),(158,30,'2021-03-22 16:41:45','1',0,0,5,'U',NULL,NULL),(159,30,'2021-03-22 16:44:12','1',0,0,5,'U',NULL,NULL),(160,30,'2021-03-22 16:51:06','zz',0,0,5,'U',NULL,NULL),(161,30,'2021-03-22 16:52:19','321',0,0,5,'U',NULL,NULL),(162,30,'2021-03-22 16:56:06','1',0,0,5,'U',NULL,NULL),(163,30,'2021-03-22 16:56:54','1',0,0,5,'U',NULL,NULL),(164,30,'2021-03-22 16:57:25','1111',0,0,5,'U',NULL,NULL),(165,30,'2021-03-22 17:07:33','1',0,0,5,'U',NULL,NULL),(166,30,'2021-03-22 17:08:01','1',0,0,5,'U',NULL,NULL),(167,30,'2021-03-22 17:11:51','123 123 2 3132 ',0,0,5,'U',NULL,NULL),(168,30,'2021-03-22 17:14:59','123 ',0,0,5,'U',NULL,NULL),(169,30,'2021-03-22 17:16:04','11121',0,0,5,'U',NULL,NULL),(170,30,'2021-03-22 17:17:30','11',0,0,5,'U',NULL,NULL),(171,30,'2021-03-22 17:30:26','123',0,0,5,'U',NULL,NULL),(172,30,'2021-03-22 17:31:52','1',0,0,5,'U',NULL,NULL),(173,30,'2021-03-22 17:33:35','123321 132',0,0,5,'U',NULL,NULL),(174,30,'2021-03-22 17:33:54',' 123',0,0,5,'U',NULL,NULL),(175,30,'2021-03-22 17:37:25','1',0,0,5,'U',NULL,NULL),(176,30,'2021-03-22 17:42:01','1',0,0,5,'U',NULL,NULL),(177,30,'2021-03-22 17:45:36','1133123',0,0,5,'U',NULL,NULL),(178,30,'2021-03-22 17:46:22','1',0,0,5,'U',NULL,NULL),(179,30,'2021-03-22 17:47:11','1',0,0,5,'U',NULL,NULL),(180,30,'2021-03-22 17:48:06','1',0,0,5,'U',NULL,NULL),(181,30,'2021-03-22 17:48:46','123',0,2,5,'U',NULL,NULL),(182,30,'2021-03-22 17:49:48','12313 ',0,2,5,'U',NULL,NULL),(183,30,'2021-03-22 18:43:06','42',0,0,5,'U',NULL,NULL),(184,30,'2021-03-22 18:54:04','1',0,0,5,'U',NULL,NULL),(185,30,'2021-03-22 18:56:00','6',0,0,5,'U',NULL,NULL),(186,30,'2021-03-22 19:06:35','123',0,0,5,'U',NULL,NULL),(187,30,'2021-03-22 19:08:40','11111111',0,0,5,'U',NULL,NULL),(188,30,'2021-03-22 19:11:18','6',0,0,5,'U',NULL,NULL),(189,30,'2021-03-22 20:39:07','44',0,0,5,'U',NULL,NULL),(190,30,'2021-03-22 21:23:47','123',0,0,5,'U',NULL,NULL),(191,30,'2021-03-22 21:26:26','╪º┘ä╪┤╪º┘ü╪╣┘è ╪▒╪¡┘à┘ç ╪º┘ä┘ä┘ç',0,0,5,'U',NULL,NULL),(192,30,'2021-03-22 21:33:55','The greatness of blue <3',1,1,5,'U',NULL,NULL),(193,47,'2021-03-22 22:29:35','╪º┘å╪º ┘é╪▒╪▒╪¬ ╪º╪¬╪¼┘ê╪▓\n╪¡╪» ╪╣┘å╪»┘ç ╪╣╪▒┘ê╪│╪⌐ ┘à┘å╪º╪│╪¿╪⌐╪ƒ',1,0,5,'U',NULL,NULL),(194,47,'2021-03-22 22:37:05','╪º┘å╪º ┘é╪▒╪▒╪¬ ╪º╪¬╪¼┘ê╪▓ ╪«┘ä╪º╪╡',0,0,5,'U',NULL,NULL),(196,30,'2021-03-23 00:45:01','123 1 123 132',0,0,5,'U',NULL,NULL),(197,30,'2021-03-23 00:45:41','Rafikkiiiii <3',0,0,5,'U',NULL,NULL),(198,30,'2021-03-23 00:46:30','helooooooo',0,0,5,'U',NULL,NULL),(199,30,'2021-03-23 00:47:11','asd',0,0,5,'U',NULL,NULL),(200,30,'2021-03-23 00:48:16','1231 23',0,0,5,'U',NULL,NULL),(201,30,'2021-03-23 00:50:05','timooooooooon',0,0,5,'U',NULL,NULL),(205,30,'2021-03-23 00:55:33','Helloooooooooo Pomba',1,0,5,'U',NULL,NULL),(206,30,'2021-03-23 00:56:03','Hello timoon',1,0,5,'U',NULL,NULL),(207,30,'2021-03-23 03:01:02','',1,3,5,'U',NULL,NULL),(209,30,'2021-03-23 03:40:46','adsa asdad asdas ',0,2,5,'U',NULL,NULL);
/*!40000 ALTER TABLE `post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post_image`
--

DROP TABLE IF EXISTS `post_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post_image` (
  `id` int NOT NULL AUTO_INCREMENT,
  `post_id` int NOT NULL,
  `image_path` varchar(1000) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_POST_IMAGE_POST_ID` (`post_id`),
  CONSTRAINT `FK_POST_IMAGE_POST_ID` FOREIGN KEY (`post_id`) REFERENCES `post` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post_image`
--

LOCK TABLES `post_image` WRITE;
/*!40000 ALTER TABLE `post_image` DISABLE KEYS */;
INSERT INTO `post_image` VALUES (9,192,'1dbae7be-dce5-4507-90f0-934e20bbea2e.jpeg'),(10,193,'29bf11fc-03ce-4817-9d29-4a02b321ee65.jpeg'),(11,194,'1bc188ba-7ffd-43d0-9271-8a1edb46e6e4.jpeg'),(13,197,'13258a7e-0a42-490c-9bbe-872d9c048ac1.png'),(14,198,'59beac3f-3f92-49a9-82f0-eb861626be28.png'),(15,199,'d944459f-060c-48e1-8767-6082c1952c40.png'),(16,200,'a7aa237e-6e46-4d43-a676-623c6835af25.png'),(17,201,'7c8321fe-d1a3-41c7-b30d-98f9698fca0b.png'),(20,205,'b3fc46a6-2ee0-4617-a77e-fd1177026cbe.png'),(21,206,'47b82cca-e983-4eac-ae61-a14839855baf.png'),(22,207,'9e8de91f-4a86-4e4e-8c26-07b8e05e3951.png');
/*!40000 ALTER TABLE `post_image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reaction`
--

DROP TABLE IF EXISTS `reaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reaction` (
  `post_id` int NOT NULL,
  `author_user_id` int NOT NULL,
  `timestamp` datetime NOT NULL,
  `reaction_type` varchar(20) NOT NULL,
  PRIMARY KEY (`post_id`,`author_user_id`),
  KEY `fk_pst_1` (`post_id`),
  KEY `fk_usr_1` (`author_user_id`),
  CONSTRAINT `reaction_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `post` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `reaction_ibfk_2` FOREIGN KEY (`author_user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reaction`
--

LOCK TABLES `reaction` WRITE;
/*!40000 ALTER TABLE `reaction` DISABLE KEYS */;
INSERT INTO `reaction` VALUES (207,30,'2021-03-23 05:32:07','1');
/*!40000 ALTER TABLE `reaction` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `increase_reaction_count_after_insert_reaction` AFTER INSERT ON `reaction` FOR EACH ROW UPDATE post set post.reactions_counter=post.reactions_counter+1 where post.id = new.post_id */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `decrease_reaction_count_after_delete_reaction` AFTER DELETE ON `reaction` FOR EACH ROW UPDATE post set post.reactions_counter=post.reactions_counter-1 where post.id = old.post_id */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(20) NOT NULL,
  `last_name` varchar(20) NOT NULL,
  `dob` date NOT NULL,
  `gender` char(1) NOT NULL,
  `country` varchar(5) NOT NULL,
  `city` varchar(20) NOT NULL,
  `profile_image_path` varchar(255) DEFAULT NULL,
  `bio` varchar(255) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email_2` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (5,'ahmed','fadl','1999-01-22','M','JP','Tokyo',NULL,NULL,'ahmed@gmail.com',''),(6,'ahmed','fadl','1999-01-22','M','JP','Tokyo',NULL,NULL,'ahmed-fadl@gmail.com',''),(7,'ahmed','fadl','1999-01-22','M','JP','Tokyo',NULL,NULL,'ahmedd-fadl@gmail.com',''),(8,'ahmed','fadl','1999-01-22','M','JP','Tokyo',NULL,NULL,'aahmed-fadl@gmail.com','123123'),(9,'ahmed','fadl','0122-12-31','M','JP','Tokyo',NULL,NULL,'aaahmed-fadl@gmail.com','123123'),(10,'ahmed','fadl','0122-12-31','M','JP','Tokyo',NULL,NULL,'aa1ahmed-fadl@gmail.com','123123'),(11,'ahmed','fadl','0122-12-31','M','JP','Tokyo',NULL,NULL,'aa1ahm3ed-fadl@gmail.com','123123'),(12,'ahmed','fadl','0122-12-31','M','JPSD','Tokyo',NULL,NULL,'aa1ah1m3ed-fadl@gmail.com','123123'),(13,'ahmed','fadl','0122-12-31','M','JPSD','Tokyo',NULL,NULL,'aa1adh1m3ed-fadl@gmail.com','123123'),(14,'ahmed','fadl','0122-12-31','M','JPA','Tokyo',NULL,NULL,'aa1adh1m3e3d-fadl@gmail.com','123123'),(15,'ahmed','fadl','0122-12-31','M','JA','Tokyo',NULL,NULL,'aa1asdl@gmail.com','123123'),(16,'ahmed','fadl','0122-12-31','M','JA','Tokyo',NULL,NULL,'newMail@asd.com','$2b$10$zeQoIQnOxZOQ1o4cuUvjAetfMZ7Mgr7UuuxPhl7Q7hBYl52jr3fwC'),(18,'ahmed','fadl','0122-12-31','M','JA','Tokyo!@#!@#!@#',NULL,NULL,'newMail@asd.comm','$2b$10$PGqKZK9zc6MOHeCgnA4QrO2mxrSMHwiHLM4CqQXXNlEw/H6./ODCm'),(19,'ahmed','fadl','0122-12-31','M','JA','Tokyo!!!!!!!',NULL,NULL,'newMail@asd.cooom','$2b$10$gfQfJvHyb/6ghn9eFp8gNOMkf2DID0zU8waDrXqMMUmvfaK/5Nv16'),(20,'ahmed','fadl','0122-12-31','M','JA','Tokyo',NULL,NULL,'aads@asd.coom','$2b$10$f/bPjSbHCAFivntStap.budULthYN9kr/xKoUgl8myEbsIz7E3vm6'),(21,'ahmed','fadl','0122-12-31','M','JA','Tokyo',NULL,NULL,'aads@asd.coom123','$2b$10$Vhx1bgCwnTvkDudIrDZl.eiocNHcPkfIdAvkf0ADp17oJb04aDLha'),(22,'ahmed','fadl','0122-12-31','M','JA','Tokyo',NULL,NULL,'aads@asd.coom123z','$2b$10$hR5c7nU7wX5p.S2c6Uv.IuxOmUzuK31yrvUx6MkQD9AtJPZUZ1Xfm'),(24,'hekmat','abdel-karim','0122-12-31','F','HEART','Tokyo',NULL,NULL,'hekmat@yahoo.com','$2b$10$KbU9ORdvvU0BgVPbHETidOPkHgJlTz3tgxLeXXylJ3.FNcKfv08xO'),(25,'hekmat','abdel-karim','0122-12-31','F','HEART','right_side',NULL,NULL,'hekmat@gmail.com','$2b$10$qDAfmbF9fnKGdY5cf5YxlOa5ByG.8HJs7YQ0nJ5jP76.tAd1SkwOC'),(26,'123123123','123123','1999-12-11','m','AL','asdadsasd',NULL,NULL,'hellothere@gmail.com11','$2b$10$wBkNo6UWULCutobCvq6X8.nhDV1upB9Z76L/NcoZEZqLMBDQqW2Ma'),(27,'asd','asd','2019-05-01','m','AE','Cairo',NULL,NULL,'abdofdl99@gmail.com','$2b$10$.z4yYF1RbD9pmu1zKsJHQe0/LYbbmOz5MaSYsgoF4dE9CM1JajJ/m'),(28,'qwe','asdsasd','2020-03-02','m','AF','asdads',NULL,NULL,'abdofdl99@gmail.co','$2b$10$zc2NaeUs8iZzAeImqmCL3u9rC9WPqLPWY/e3HjTxZFY0ymuDRQzSu'),(29,'qwe','asdsasd','2020-03-02','m','AF','asdads',NULL,NULL,'abdofdl99@gmail.o','$2b$10$cb6wjt65Xgrt/iAIx/zgq.jEiKBAAQNprYS68at05Ro337slzrrby'),(30,'Mohammed ','Ismail','2020-12-31','m','EG','El Kafr','1a69267b-adbd-4895-be44-6463e683bec2.jpeg',NULL,'abuismail@a.com','$2b$10$CQNTt7J9a/hAIFVXE8qrRuHJaGyt91E830VYB9qWzJeP9DssxZMZq'),(31,'abdo','fadl','2020-02-02','m','EG','Cairo','E:\\sokial\\sokial-backend\\uploads\\31_743a5f5dfe181f944919640126646b8c.jpg',NULL,'a@b.c','$2b$10$rCIrK9/MFpLXAjW5QsgEY.gGHeL6XYmUanxLvNCY3hWZXwX2u.Tsq'),(32,'Zaza','Lala','2016-05-31','m','AG','Cairo',NULL,NULL,'z@l.c','$2b$10$jpZIE7F7WoqyLoUAVOiNR.kNcEDBmZAN8eZR7Ay2JM0g9DyNhJn1i'),(33,'Zaza','Lala','2016-05-31','m','AG','Cairo',NULL,NULL,'z@l.com','$2b$10$QYgNxr0VoPFZjmOcAMHsEutzWOcDT7HEtntvFRo7QGgVtz1G73H.S'),(34,'Zaza','Lala','2016-05-31','m','AG','Cairo',NULL,NULL,'za@l.com','$2b$10$KBOrOBcbh0t.cSCpLf4uuuKp6rDOQzvla1du.P5zi40.FWwtoc2XC'),(35,'Zaza','Lala','2016-05-31','m','AG','Cairo',NULL,NULL,'za@12.com','$2b$10$Zkcsl9BGs5pOh1xnko7cyen7ksDkSjoUvGvQVOO.vpspQVR318kZe'),(36,'asd','qweqwe','2020-12-31','m','AD','Cairo',NULL,NULL,'tmp@z.z','$2b$10$99ozVL3zcsG8eFxbujaF2.JYfnq4PnjVhytfZuPG/htFRqD1n0Xs.'),(37,'asd','qweqwe','2020-12-31','m','AD','Cairo',NULL,NULL,'tmp@z.zz','$2b$10$Pvk/MVzQ8JG8HZt/T3exZu/Y9es3DfbQK6phCP0425OwdV9VYfC7q'),(38,'asd','qweqwe','2020-12-31','m','AD','Cairo',NULL,NULL,'tmp@z.zzz','$2b$10$iWPkxMEL4cfMkP4B2.xL5uycneDZVIJOnPzdPzgMIleMbos1Jk.Ie'),(39,'asd','qweqwe','2020-12-31','m','AD','Cairo',NULL,NULL,'tmp@zz.zzz','$2b$10$H8VmbpGPvzWAtQ2kXVnfh.9s6sdN3u3awFkoKAsJjSsYxNUlopzDC'),(40,'asd','qweqwe','2020-12-31','m','AD','Cairo',NULL,NULL,'tmp@zz.zzzz','$2b$10$/dkA6z/Ctn5Y7QN52MdVdO57IByK9L44pLZbDD1qrxICjGBAWFw2q'),(41,'asd','qweqwe','2020-12-31','m','AD','Cairo',NULL,NULL,'tmp@zz.zzzzz','$2b$10$JdvOb3.lzwYAXI1BDUjOQ.MPDnVvKe87IXVG/DhavSL4rV3.Mqh9S'),(42,'asd','qweqwe','2020-12-31','m','AD','Cairo',NULL,NULL,'tmp@zz.zzzz1z','$2b$10$AddNCR0d5hMy7whque7LRefft36D8CH0qs.Uf5bqablE4qMtFimK6'),(43,'asd','qweqwe','2020-12-31','m','AD','Cairo',NULL,NULL,'tmp@zz.zzzz1zz','$2b$10$8ULwf9ASP6AwblR4B7swOOlyjfIQvBzng9DXmSpQPokJUdjI8tlWm'),(44,'tmp','tmp2','2021-01-01','m','AD','Cairo',NULL,NULL,'tmpi@a.b','$2b$10$jwsC5AXaKFXfuTavM2DEq.CaQiK2z7nQzuktlfuxPMR6KvJMKS9Mm'),(45,'Some','Name','2020-02-01','m','AF','El Kafr',NULL,NULL,'abc@abc.com','$2b$10$l3gVA0sAVKqBa4ywusvUuOpJV4QqNS0s..rLh4DZfVI9yE4KZ.kIu'),(46,'Bro','Man','2017-07-03','m','AL','Cairo',NULL,NULL,'asd@asdasd.asd','$2b$10$48Q.xU24u5FlyHueMmNH3OdQEbGxZ02n6kb7jAsMLSlrlqQ.6D2rq'),(47,'┘â╪▒┘è┘à','╪╣╪¿╪» ╪º┘ä┘é┘ê┘è','2016-06-05','m','AI','Cairo','1a07aa6a-562e-48c6-bc0d-f6436a05a8d0.jpeg',NULL,'kimo@gmail.com','$2b$10$E4UwI2ZgZRdItiCu0HaYJO.BdqQvYWnwPrdE4as5a1H9imoEYVuTW');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_follower`
--

DROP TABLE IF EXISTS `user_follower`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_follower` (
  `followed_user_id` int NOT NULL,
  `follower_user_id` int NOT NULL,
  PRIMARY KEY (`followed_user_id`,`follower_user_id`),
  KEY `followed_user_id` (`followed_user_id`),
  KEY `user_following_ibfk_2` (`follower_user_id`),
  CONSTRAINT `user_following_ibfk_1` FOREIGN KEY (`followed_user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_following_ibfk_2` FOREIGN KEY (`follower_user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_follower`
--

LOCK TABLES `user_follower` WRITE;
/*!40000 ALTER TABLE `user_follower` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_follower` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-03-23  5:33:46
