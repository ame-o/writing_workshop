CREATE DATABASE  IF NOT EXISTS `writing_workshop` /*!40100 DEFAULT CHARACTER SET utf8 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `writing_workshop`;
-- MySQL dump 10.13  Distrib 8.0.28, for Win64 (x86_64)
--
-- Host: localhost    Database: writing_workshop
-- ------------------------------------------------------
-- Server version	8.0.28

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `projects`
--

DROP TABLE IF EXISTS `projects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `projects` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(45) DEFAULT NULL,
  `due_date` datetime DEFAULT NULL,
  `week_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_projects_users1_idx` (`user_id`),
  CONSTRAINT `fk_projects_users1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projects`
--

LOCK TABLES `projects` WRITE;
/*!40000 ALTER TABLE `projects` DISABLE KEYS */;
/*!40000 ALTER TABLE `projects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(45) DEFAULT NULL,
  `username` varchar(45) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'America','admin','$2b$12$UHPIldxJk8..EpCfhCORguXJtgEJdba648LtQ6E4/VQekftrZR8AW'),(2,'Asia','admin2','$2b$12$GeFcNOc/lv8gidonhf6ZduVOFLov4kNFMBDRgUVSTCnZNBCagowZ6'),(3,'test_student','test','$2b$12$AzC8JB8vMCc.krgguwOlJerUZC2hJPpQVEMLVxa98dgECLEnExb46'),(4,'jazz','jazz','$2b$12$Y34lXWyXrtdVIsgt6DuneeWvhApbwjmnaxrqoGvqvv.w0NU.2mLRy');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vocabulary`
--

DROP TABLE IF EXISTS `vocabulary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vocabulary` (
  `id` int NOT NULL AUTO_INCREMENT,
  `spelling` varchar(45) DEFAULT NULL,
  `definition` varchar(255) DEFAULT NULL,
  `sentence` varchar(500) DEFAULT NULL,
  `due_date` datetime DEFAULT NULL,
  `week_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_vocabulary_users1_idx` (`user_id`),
  CONSTRAINT `fk_vocabulary_users1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vocabulary`
--

LOCK TABLES `vocabulary` WRITE;
/*!40000 ALTER TABLE `vocabulary` DISABLE KEYS */;
INSERT INTO `vocabulary` VALUES (1,'adjacent','next to or adjoining something else','He was standing adjacent to the pillar so as not to be in the way.','2022-04-05 00:00:00',1,1),(2,'bewilder','cause (someone) to become perplexed or confused','The magician will bewilder you with her tricks.','2022-04-05 00:00:00',1,1),(3,'candid','truthful and straightforward','She was very candid about her experience in the review.','2022-04-05 00:00:00',1,1),(4,'covet','yearn to possess or have something','Anyone would covet a lifestyle of luxury.','2022-04-06 00:00:00',1,1),(5,'despondent','in low spirits from loss of hope or courage','The team was despondent after coming in last place.','2022-04-06 00:00:00',1,1),(6,'fathom','understand (a difficult problem or an enigmatic person) after much thought','I cannot fathom how you can enjoy a movie this boring!','2022-04-06 00:00:00',1,1),(7,'grueling','extremely tiring and demanding','Swim practice is so grueling.','2022-04-06 00:00:00',1,1),(8,'homage','special honor or respect shown publicly','The altar in her home is an homage to her brother who passed away.','2022-04-06 00:00:00',1,1),(9,'mirth','amusement, especially as expressed in laughter','The family was full of mirth as they opened presents around the Christmas tree.','2022-04-06 00:00:00',1,1),(10,'ponder','think about (something) carefully, especially before making a decision or reaching a conclusion','Many philosophers ponder the meaning of life.','2022-04-06 00:00:00',1,1),(12,'avert','turn away (one‘s eyes or thoughts)','You should avert your eyes from the sun.','2022-04-12 00:00:00',2,1);
/*!40000 ALTER TABLE `vocabulary` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `weekly`
--

DROP TABLE IF EXISTS `weekly`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `weekly` (
  `id` int NOT NULL AUTO_INCREMENT,
  `vocab` varchar(45) DEFAULT NULL,
  `vocab_story` varchar(255) DEFAULT NULL,
  `hamburger_1` varchar(255) DEFAULT NULL,
  `hamburger_2` varchar(255) DEFAULT NULL,
  `essay_1` varchar(255) DEFAULT NULL,
  `essay_2` varchar(255) DEFAULT NULL,
  `week_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_weekly_users1_idx` (`user_id`),
  CONSTRAINT `fk_weekly_users1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `weekly`
--

LOCK TABLES `weekly` WRITE;
/*!40000 ALTER TABLE `weekly` DISABLE KEYS */;
INSERT INTO `weekly` VALUES (1,'not yet','Choose FIVE words from the vocabulary list and write a short story titled: The Worst Day Ever!At least 2 paragraphs long (10 sentences).Underline vocabulary words used.','If you could have any superpower, what would it be and why?','n/a','It is good to have an end to journey toward; but it is the journey that matters, in the end. When you light a candle, you also cast a shadow.A man does not make his destiny: he accepts it or denies it.― Ursula K. Le Guin\n','n/a',1,1),(2,'1','n/a','You’re a pirate trying to recruit me for your crew. Why should I join?','n/a','Still I Rise by Maya Angelou','Why did Maya Angelou right this poem? How did she convey her message?',2,1);
/*!40000 ALTER TABLE `weekly` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-04-04 23:31:32
