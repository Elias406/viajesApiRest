CREATE DATABASE  IF NOT EXISTS `blog_viajes` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `blog_viajes`;
-- MySQL dump 10.13  Distrib 8.0.28, for Win64 (x86_64)
--
-- Host: localhost    Database: blog_viajes
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
-- Table structure for table `autores`
--

DROP TABLE IF EXISTS `autores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `autores` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `contrasena` varchar(255) NOT NULL,
  `pseudonimo` varchar(255) NOT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `autores`
--

LOCK TABLES `autores` WRITE;
/*!40000 ALTER TABLE `autores` DISABLE KEYS */;
INSERT INTO `autores` VALUES (1,'luis@email.com','123123','luis200',NULL),(2,'Ana@email.com','123123','a55555',NULL),(8,'eliasdjgutierrez@gmail.com','elias406','12783hgk',NULL),(9,'Andres@email.com','12451','And456',NULL);
/*!40000 ALTER TABLE `autores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `publicaciones`
--

DROP TABLE IF EXISTS `publicaciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `publicaciones` (
  `id` int NOT NULL AUTO_INCREMENT,
  `titulo` varchar(255) NOT NULL,
  `resumen` varchar(255) NOT NULL,
  `contenido` varchar(45) NOT NULL,
  `foto` varchar(45) DEFAULT NULL,
  `votos` int DEFAULT '0',
  `fecha_hora` timestamp NULL DEFAULT NULL,
  `autor_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_autorP_idx` (`autor_id`),
  CONSTRAINT `FK_autorP` FOREIGN KEY (`autor_id`) REFERENCES `autores` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `publicaciones`
--

LOCK TABLES `publicaciones` WRITE;
/*!40000 ALTER TABLE `publicaciones` DISABLE KEYS */;
INSERT INTO `publicaciones` VALUES (1,'Roma','Buen viaje a Roma','Contenido de Roma',NULL,0,'2018-09-10 06:08:27',1),(2,'Grecia','Buen viaje a Grecia','Contenido de Grecia',NULL,0,'2018-09-11 06:08:27',1),(3,'Paris','Buen viaje a Paris','Contenido de Paris',NULL,0,'2018-09-12 06:08:27',1),(4,'Costa Rica','Buen viaje a Costa Rica','Contenido de Costa Rica',NULL,0,'2018-09-13 06:08:27',2),(5,'Mar de Plata','Buen viaje a Mar de Plata','Contenido de Mar de Plata',NULL,0,'2018-09-14 06:08:27',2),(6,'Guadalajara','Buen viaje a Guadalajara','Contenido de Guadalajara',NULL,0,'2018-09-15 06:08:27',2),(7,'China','Buen viaje a China','Contenido de China',NULL,0,'2018-09-16 06:08:27',2),(8,'Croacia','Buen viaje a Croacia','Contenido de Croacia',NULL,0,'2018-09-13 06:08:27',8),(9,'Nueva Zelanda','Buen viaje a Nueva Zelanda','Contenido de Nueva Zelanda',NULL,0,'2018-09-13 06:08:27',8),(10,'Alemania','Buen viaje a Alemania','contenido de Alemania',NULL,0,'2018-09-13 06:08:27',8),(11,'Argentina','Buen viaje a Argentina','contenido de Argentina',NULL,0,'2018-09-13 06:08:27',9);
/*!40000 ALTER TABLE `publicaciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'blog_viajes'
--

--
-- Dumping routines for database 'blog_viajes'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-05-17 10:21:48
