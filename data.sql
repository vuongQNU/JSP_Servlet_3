-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: localhost    Database: jsp_servlet1
-- ------------------------------------------------------
-- Server version	8.0.41

DROP DATABASE IF EXISTS `jsp_servlet2`;
CREATE DATABASE `jsp_servlet2`;
USE `jsp_servlet2`;

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
-- Table structure for table `provinces`
--

DROP TABLE IF EXISTS `provinces`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `provinces` (
  `idProvince` INT AUTO_INCREMENT PRIMARY KEY,
  `nameProvince` VARCHAR(100) NOT NULL,
  `note` VARCHAR(50)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `provinces`
--

LOCK TABLES `provinces` WRITE;
/*!40000 ALTER TABLE `provinces` DISABLE KEYS */;
INSERT INTO `provinces` (`nameProvince`, `note`) VALUES
('An Giang', 'Tỉnh'),
('Bà Rịa - Vũng Tàu', 'Tỉnh'),
('Bắc Giang', 'Tỉnh'),
('Bắc Kạn', 'Tỉnh'),
('Bạc Liêu', 'Tỉnh'),
('Bắc Ninh', 'Tỉnh'),
('Bến Tre', 'Tỉnh'),
('Bình Định', 'Tỉnh'),
('Bình Dương', 'Tỉnh'),
('Bình Phước', 'Tỉnh'),
('Bình Thuận', 'Tỉnh'),
('Cà Mau', 'Tỉnh'),
('Cần Thơ', 'Thành phố trực thuộc trung ương'),
('Cao Bằng', 'Tỉnh'),
('Đà Nẵng', 'Thành phố trực thuộc trung ương'),
('Đắk Lắk', 'Tỉnh'),
('Đắk Nông', 'Tỉnh'),
('Điện Biên', 'Tỉnh'),
('Đồng Nai', 'Tỉnh'),
('Đồng Tháp', 'Tỉnh'),
('Gia Lai', 'Tỉnh'),
('Hà Giang', 'Tỉnh'),
('Hà Nam', 'Tỉnh'),
('Hà Nội', 'Thành phố trực thuộc trung ương'),
('Hà Tĩnh', 'Tỉnh'),
('Hải Dương', 'Tỉnh'),
('Hải Phòng', 'Thành phố trực thuộc trung ương'),
('Hậu Giang', 'Tỉnh'),
('Hòa Bình', 'Tỉnh'),
('Hưng Yên', 'Tỉnh'),
('Khánh Hòa', 'Tỉnh'),
('Kiên Giang', 'Tỉnh'),
('Kon Tum', 'Tỉnh'),
('Lai Châu', 'Tỉnh'),
('Lâm Đồng', 'Tỉnh'),
('Lạng Sơn', 'Tỉnh'),
('Lào Cai', 'Tỉnh'),
('Long An', 'Tỉnh'),
('Nam Định', 'Tỉnh'),
('Nghệ An', 'Tỉnh'),
('Ninh Bình', 'Tỉnh'),
('Ninh Thuận', 'Tỉnh'),
('Phú Thọ', 'Tỉnh'),
('Phú Yên', 'Tỉnh'),
('Quảng Bình', 'Tỉnh'),
('Quảng Nam', 'Tỉnh'),
('Quảng Ngãi', 'Tỉnh'),
('Quảng Ninh', 'Tỉnh'),
('Quảng Trị', 'Tỉnh'),
('Sóc Trăng', 'Tỉnh'),
('Sơn La', 'Tỉnh'),
('Tây Ninh', 'Tỉnh'),
('Thái Bình', 'Tỉnh'),
('Thái Nguyên', 'Tỉnh'),
('Thanh Hóa', 'Tỉnh'),
('Thừa Thiên Huế', 'Tỉnh'),
('Tiền Giang', 'Tỉnh'),
('TP Hồ Chí Minh', 'Thành phố trực thuộc trung ương'),
('Trà Vinh', 'Tỉnh'),
('Tuyên Quang', 'Tỉnh'),
('Vĩnh Long', 'Tỉnh'),
('Vĩnh Phúc', 'Tỉnh'),
('Yên Bái', 'Tỉnh');
/*!40000 ALTER TABLE `provinces` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `created_at` DATETIME(6) DEFAULT NULL,
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `password` VARCHAR(255) DEFAULT NULL,
  `role` VARCHAR(255) DEFAULT NULL,
  `username` VARCHAR(255) DEFAULT NULL,
  `email` VARCHAR(255) UNIQUE,
  `dob` DATE,
  `province_id` INT,
  `avatar` VARCHAR(255),
  PRIMARY KEY (`id`),
  CONSTRAINT `FK_user_province` FOREIGN KEY (`province_id`) REFERENCES `provinces` (`idProvince`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`created_at`, `id`, `password`, `role`, `username`, `email`, `dob`, `province_id`, `avatar`) VALUES
('2025-02-24 22:18:06.255663', 1, 'a', 'ADMIN', 'a', 'a@example.com', '1990-01-01', 1, 'uploads/avatar1.jpg'),
('2025-02-24 22:25:59.268203', 2, 'b', 'USER', 'b', 'b@example.com', '1995-05-15', 2, 'uploads/avatar2.jpg'),
('2025-02-24 22:30:00.000000', 3, 'c', 'USER', 'c', 'c@example.com', '2000-03-20', 3, 'uploads/avatar3.jpg'),
('2025-02-24 22:35:00.000000', 4, 'd', 'USER', 'd', 'd@example.com', '1998-07-10', 4, 'uploads/avatar4.jpg'),
('2025-02-24 22:40:00.000000', 5, 'e', 'USER', 'e', 'e@example.com', '1992-11-25', 5, 'uploads/avatar5.jpg');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `follows`
--

DROP TABLE IF EXISTS `follows`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `follows` (
  `follower_id` BIGINT NOT NULL,
  `following_id` BIGINT NOT NULL,
  `created_at` DATETIME(6) DEFAULT NULL,
  PRIMARY KEY (`follower_id`, `following_id`),
  CONSTRAINT `FK_follower` FOREIGN KEY (`follower_id`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_following` FOREIGN KEY (`following_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `follows`
--

LOCK TABLES `follows` WRITE;
/*!40000 ALTER TABLE `follows` DISABLE KEYS */;
INSERT INTO `follows` VALUES 
(1, 2, '2025-02-24 22:30:00.000000'),
(2, 1, '2025-02-24 22:31:00.000000'),
(1, 3, '2025-02-24 22:32:00.000000'),
(1, 4, '2025-02-24 22:33:00.000000'),
(3, 1, '2025-02-24 22:34:00.000000'),
(4, 1, '2025-02-24 22:35:00.000000'),
(5, 1, '2025-02-24 22:36:00.000000');
/*!40000 ALTER TABLE `follows` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `posts` (
  `created_at` DATETIME(6) DEFAULT NULL,
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `user_id` BIGINT NOT NULL,
  `body` VARCHAR(255) DEFAULT NULL,
  `status` VARCHAR(255) DEFAULT NULL,
  `title` VARCHAR(255) DEFAULT NULL,
  `deleted_at` DATETIME(6) DEFAULT NULL,
  `updated_at` DATETIME(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK5lidm6cqbc7u4xhqpxm898qme` (`user_id`),
  CONSTRAINT `FK5lidm6cqbc7u4xhqpxm898qme` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts`
--

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
INSERT INTO `posts` VALUES 
('2025-02-24 22:18:15.594052', 1, 1, 'a', 'ACTIVE', 'a', NULL, NULL),
('2025-02-24 22:24:45.751505', 2, 1, 'aaaa', 'ACTIVE', 'aaaa', NULL, NULL),
('2025-02-24 22:24:58.793402', 3, 1, 'bbbbzzzzzzzzzzzzzz', 'DELETED', 'bbb', '2025-02-24 23:06:36.459835', '2025-02-24 23:01:05.330666'),
('2025-02-24 23:12:23.596535', 4, 2, 'fffffffffffffffffffffffffffffff', 'DELETED', 'fffffffffffffffffffffffff', '2025-02-24 23:17:42.486324', '2025-02-24 23:17:42.486324'),
('2025-02-24 23:17:52.175477', 5, 2, 'bbbbbbbbbbbbbb', 'DELETED', ' bbbbbbbbbb', '2025-02-24 23:18:05.631687', '2025-02-24 23:18:05.631687'),
('2025-02-24 23:17:57.388489', 6, 2, 'bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb', 'DELETED', 'bbbbbbbbbbbbbbbb', '2025-02-24 23:17:59.664889', '2025-02-24 23:17:59.664889');
/*!40000 ALTER TABLE `posts` ENABLE KEYS */;
UNLOCK TABLES;

/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-04-18 22:01:19