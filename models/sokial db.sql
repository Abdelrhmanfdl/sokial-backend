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
  CONSTRAINT `com_of_post_id_fk` FOREIGN KEY (`post_id`) REFERENCES `post` (`id`) ON delete cascade on update cascade,
  CONSTRAINT `com_page_id_fk` FOREIGN KEY (`author_page_id`) REFERENCES `page` (`id`) ON delete cascade on update cascade,
  CONSTRAINT `com_user_id_fk` FOREIGN KEY (`author_user_id`) REFERENCES `user` (`id`) ON delete cascade on update cascade
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
INSERT INTO `comment` VALUES (19,25,30,'╪¿╪│┘à ╪º┘ä┘ä┘ç\n╪º┘ä╪¡┘à╪» ┘ä┘ä┘ç','2021-01-31 08:01:59',0,'U',NULL),(21,22,30,'5 is a some number dude!!','2021-02-01 17:25:33',0,'U',NULL),(23,9,45,'Helllooooooo','2021-02-02 08:18:00',0,'U',NULL),(24,26,45,'It\'s good, actually very good. ','2021-02-02 08:19:57',0,'U',NULL);
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
INSERT INTO `friend` VALUES (30,41);
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
INSERT INTO `friendship_request` VALUES (42,30,'1999-12-12 10:00:00'),(43,30,'1999-12-12 10:00:00'),(44,30,'1999-12-12 10:00:00');
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
-- Table structure for table `photo`
--

DROP TABLE IF EXISTS `photo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `photo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `photo_path` varchar(1000) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `photo`
--

LOCK TABLES `photo` WRITE;
/*!40000 ALTER TABLE `photo` DISABLE KEYS */;
/*!40000 ALTER TABLE `photo` ENABLE KEYS */;
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
  `post_image_id` int DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post`
--

LOCK TABLES `post` WRITE;
/*!40000 ALTER TABLE `post` DISABLE KEYS */;
INSERT INTO `post` VALUES (1,25,'1999-02-01 00:00:00','Hello my heart and world !! 2',NULL,0,0,2,'U',NULL,NULL),(3,25,'1999-02-01 00:00:00','╪º┘å╪º ╪╣╪º╪º╪º┘è╪┤ ┘ê ┘à╪┤ ╪╣╪º┘è╪┤ ┘ê┘à╪┤ ┘é╪º╪»╪▒ ╪╣┘ä┘è ╪¿╪╣╪»┘â, ┘ç╪º╪¬ ╪«┘å╪¼╪▒┘è┘å ╪¿┘é┘è',NULL,0,0,1,'U',NULL,NULL),(9,32,'2021-01-27 04:45:54','Hey i\'m 32\n',NULL,0,1,5,'U',NULL,NULL),(16,30,'2021-01-28 08:49:32','1',NULL,1,0,5,'U',NULL,NULL),(17,30,'2021-01-28 08:49:35','1',NULL,0,0,5,'U',NULL,NULL),(18,30,'2021-01-28 08:49:38','2',NULL,1,0,5,'U',NULL,NULL),(19,30,'2021-01-28 08:49:41','3',NULL,0,0,5,'U',NULL,NULL),(20,30,'2021-01-28 08:49:41','3',NULL,0,0,5,'U',NULL,NULL),(21,30,'2021-01-28 08:49:45','4',NULL,0,0,5,'U',NULL,NULL),(22,30,'2021-01-28 08:49:50','5',NULL,0,1,5,'U',NULL,NULL),(23,30,'2021-01-28 08:49:52','',NULL,0,0,5,'U',NULL,NULL),(24,30,'2021-01-28 08:49:56','6',NULL,0,0,5,'U',NULL,NULL),(25,30,'2021-01-28 08:49:57','6',NULL,2,1,5,'U',NULL,NULL),(26,30,'2021-02-02 07:44:23','Hello There!!\nI really need to thank you for your support, last week, in the festival.\n\nBest Wishes.',NULL,1,1,5,'U',NULL,NULL);
/*!40000 ALTER TABLE `post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reaction`
--

DROP TABLE IF EXISTS `reaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reaction` (
  `id` int NOT NULL AUTO_INCREMENT,
  `post_id` int NOT NULL,
  `author_user_id` int DEFAULT NULL,
  `timestamp` datetime NOT NULL,
  `reaction_type` varchar(20) NOT NULL,
  `reactant_type` varchar(10) NOT NULL,
  `author_page_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_pst_1` (`post_id`),
  KEY `fk_usr_1` (`author_user_id`),
  KEY `fk_pg_1` (`author_page_id`),
  CONSTRAINT `reaction_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `post` (`id`) ON delete cascade on update cascade,
  CONSTRAINT `reaction_ibfk_2` FOREIGN KEY (`author_user_id`) REFERENCES `user` (`id`) ON delete cascade on update cascade,
  CONSTRAINT `reaction_ibfk_3` FOREIGN KEY (`author_page_id`) REFERENCES `page` (`id`) ON delete cascade on update cascade
) ENGINE=InnoDB AUTO_INCREMENT=116 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reaction`
--

LOCK TABLES `reaction` WRITE;
/*!40000 ALTER TABLE `reaction` DISABLE KEYS */;
INSERT INTO `reaction` VALUES (110,18,30,'2021-02-02 07:38:44','1','U',NULL),(111,16,30,'2021-02-02 07:38:49','1','U',NULL),(113,25,30,'2021-02-02 07:58:37','1','U',NULL),(114,26,45,'2021-02-02 08:19:31','1','U',NULL),(115,25,45,'2021-02-02 08:19:31','1','U',NULL);
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
  `profile_photo_path` varchar(255) DEFAULT NULL,
  `bio` varchar(255) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email_2` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (5,'ahmed','fadl','1999-01-22','M','JP','Tokyo',NULL,NULL,'ahmed@gmail.com',''),(6,'ahmed','fadl','1999-01-22','M','JP','Tokyo',NULL,NULL,'ahmed-fadl@gmail.com',''),(7,'ahmed','fadl','1999-01-22','M','JP','Tokyo',NULL,NULL,'ahmedd-fadl@gmail.com',''),(8,'ahmed','fadl','1999-01-22','M','JP','Tokyo',NULL,NULL,'aahmed-fadl@gmail.com','123123'),(9,'ahmed','fadl','0122-12-31','M','JP','Tokyo',NULL,NULL,'aaahmed-fadl@gmail.com','123123'),(10,'ahmed','fadl','0122-12-31','M','JP','Tokyo',NULL,NULL,'aa1ahmed-fadl@gmail.com','123123'),(11,'ahmed','fadl','0122-12-31','M','JP','Tokyo',NULL,NULL,'aa1ahm3ed-fadl@gmail.com','123123'),(12,'ahmed','fadl','0122-12-31','M','JPSD','Tokyo',NULL,NULL,'aa1ah1m3ed-fadl@gmail.com','123123'),(13,'ahmed','fadl','0122-12-31','M','JPSD','Tokyo',NULL,NULL,'aa1adh1m3ed-fadl@gmail.com','123123'),(14,'ahmed','fadl','0122-12-31','M','JPA','Tokyo',NULL,NULL,'aa1adh1m3e3d-fadl@gmail.com','123123'),(15,'ahmed','fadl','0122-12-31','M','JA','Tokyo',NULL,NULL,'aa1asdl@gmail.com','123123'),(16,'ahmed','fadl','0122-12-31','M','JA','Tokyo',NULL,NULL,'newMail@asd.com','$2b$10$zeQoIQnOxZOQ1o4cuUvjAetfMZ7Mgr7UuuxPhl7Q7hBYl52jr3fwC'),(18,'ahmed','fadl','0122-12-31','M','JA','Tokyo!@#!@#!@#',NULL,NULL,'newMail@asd.comm','$2b$10$PGqKZK9zc6MOHeCgnA4QrO2mxrSMHwiHLM4CqQXXNlEw/H6./ODCm'),(19,'ahmed','fadl','0122-12-31','M','JA','Tokyo!!!!!!!',NULL,NULL,'newMail@asd.cooom','$2b$10$gfQfJvHyb/6ghn9eFp8gNOMkf2DID0zU8waDrXqMMUmvfaK/5Nv16'),(20,'ahmed','fadl','0122-12-31','M','JA','Tokyo',NULL,NULL,'aads@asd.coom','$2b$10$f/bPjSbHCAFivntStap.budULthYN9kr/xKoUgl8myEbsIz7E3vm6'),(21,'ahmed','fadl','0122-12-31','M','JA','Tokyo',NULL,NULL,'aads@asd.coom123','$2b$10$Vhx1bgCwnTvkDudIrDZl.eiocNHcPkfIdAvkf0ADp17oJb04aDLha'),(22,'ahmed','fadl','0122-12-31','M','JA','Tokyo',NULL,NULL,'aads@asd.coom123z','$2b$10$hR5c7nU7wX5p.S2c6Uv.IuxOmUzuK31yrvUx6MkQD9AtJPZUZ1Xfm'),(24,'hekmat','abdel-karim','0122-12-31','F','HEART','Tokyo',NULL,NULL,'hekmat@yahoo.com','$2b$10$KbU9ORdvvU0BgVPbHETidOPkHgJlTz3tgxLeXXylJ3.FNcKfv08xO'),(25,'hekmat','abdel-karim','0122-12-31','F','HEART','right_side',NULL,NULL,'hekmat@gmail.com','$2b$10$qDAfmbF9fnKGdY5cf5YxlOa5ByG.8HJs7YQ0nJ5jP76.tAd1SkwOC'),(26,'123123123','123123','1999-12-11','m','AL','asdadsasd',NULL,NULL,'hellothere@gmail.com11','$2b$10$wBkNo6UWULCutobCvq6X8.nhDV1upB9Z76L/NcoZEZqLMBDQqW2Ma'),(27,'asd','asd','2019-05-01','m','AE','Cairo',NULL,NULL,'abdofdl99@gmail.com','$2b$10$.z4yYF1RbD9pmu1zKsJHQe0/LYbbmOz5MaSYsgoF4dE9CM1JajJ/m'),(28,'qwe','asdsasd','2020-03-02','m','AF','asdads',NULL,NULL,'abdofdl99@gmail.co','$2b$10$zc2NaeUs8iZzAeImqmCL3u9rC9WPqLPWY/e3HjTxZFY0ymuDRQzSu'),(29,'qwe','asdsasd','2020-03-02','m','AF','asdads',NULL,NULL,'abdofdl99@gmail.o','$2b$10$cb6wjt65Xgrt/iAIx/zgq.jEiKBAAQNprYS68at05Ro337slzrrby'),(30,'Mohammed ','Ismail','2020-12-31','m','EG','El Kafr',NULL,NULL,'abuismail@a.com','$2b$10$CQNTt7J9a/hAIFVXE8qrRuHJaGyt91E830VYB9qWzJeP9DssxZMZq'),(31,'abdo','fadl','2020-02-02','m','EG','Cairo',NULL,NULL,'a@b.c','$2b$10$rCIrK9/MFpLXAjW5QsgEY.gGHeL6XYmUanxLvNCY3hWZXwX2u.Tsq'),(32,'Zaza','Lala','2016-05-31','m','AG','Cairo',NULL,NULL,'z@l.c','$2b$10$jpZIE7F7WoqyLoUAVOiNR.kNcEDBmZAN8eZR7Ay2JM0g9DyNhJn1i'),(33,'Zaza','Lala','2016-05-31','m','AG','Cairo',NULL,NULL,'z@l.com','$2b$10$QYgNxr0VoPFZjmOcAMHsEutzWOcDT7HEtntvFRo7QGgVtz1G73H.S'),(34,'Zaza','Lala','2016-05-31','m','AG','Cairo',NULL,NULL,'za@l.com','$2b$10$KBOrOBcbh0t.cSCpLf4uuuKp6rDOQzvla1du.P5zi40.FWwtoc2XC'),(35,'Zaza','Lala','2016-05-31','m','AG','Cairo',NULL,NULL,'za@12.com','$2b$10$Zkcsl9BGs5pOh1xnko7cyen7ksDkSjoUvGvQVOO.vpspQVR318kZe'),(36,'asd','qweqwe','2020-12-31','m','AD','Cairo',NULL,NULL,'tmp@z.z','$2b$10$99ozVL3zcsG8eFxbujaF2.JYfnq4PnjVhytfZuPG/htFRqD1n0Xs.'),(37,'asd','qweqwe','2020-12-31','m','AD','Cairo',NULL,NULL,'tmp@z.zz','$2b$10$Pvk/MVzQ8JG8HZt/T3exZu/Y9es3DfbQK6phCP0425OwdV9VYfC7q'),(38,'asd','qweqwe','2020-12-31','m','AD','Cairo',NULL,NULL,'tmp@z.zzz','$2b$10$iWPkxMEL4cfMkP4B2.xL5uycneDZVIJOnPzdPzgMIleMbos1Jk.Ie'),(39,'asd','qweqwe','2020-12-31','m','AD','Cairo',NULL,NULL,'tmp@zz.zzz','$2b$10$H8VmbpGPvzWAtQ2kXVnfh.9s6sdN3u3awFkoKAsJjSsYxNUlopzDC'),(40,'asd','qweqwe','2020-12-31','m','AD','Cairo',NULL,NULL,'tmp@zz.zzzz','$2b$10$/dkA6z/Ctn5Y7QN52MdVdO57IByK9L44pLZbDD1qrxICjGBAWFw2q'),(41,'asd','qweqwe','2020-12-31','m','AD','Cairo',NULL,NULL,'tmp@zz.zzzzz','$2b$10$JdvOb3.lzwYAXI1BDUjOQ.MPDnVvKe87IXVG/DhavSL4rV3.Mqh9S'),(42,'asd','qweqwe','2020-12-31','m','AD','Cairo',NULL,NULL,'tmp@zz.zzzz1z','$2b$10$AddNCR0d5hMy7whque7LRefft36D8CH0qs.Uf5bqablE4qMtFimK6'),(43,'asd','qweqwe','2020-12-31','m','AD','Cairo',NULL,NULL,'tmp@zz.zzzz1zz','$2b$10$8ULwf9ASP6AwblR4B7swOOlyjfIQvBzng9DXmSpQPokJUdjI8tlWm'),(44,'tmp','tmp2','2021-01-01','m','AD','Cairo',NULL,NULL,'tmpi@a.b','$2b$10$jwsC5AXaKFXfuTavM2DEq.CaQiK2z7nQzuktlfuxPMR6KvJMKS9Mm'),(45,'Some','Name','2020-02-01','m','AF','El Kafr',NULL,NULL,'abc@abc.com','$2b$10$l3gVA0sAVKqBa4ywusvUuOpJV4QqNS0s..rLh4DZfVI9yE4KZ.kIu');
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

-- Dump completed on 2021-02-02  9:29:42
