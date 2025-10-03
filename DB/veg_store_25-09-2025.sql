-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: veg_store
-- ------------------------------------------------------
-- Server version	8.0.43

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
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart` (
  `cart_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `quantity` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`cart_id`),
  KEY `user_id` (`user_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `cart_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `category_id` int NOT NULL AUTO_INCREMENT,
  `category_name` varchar(100) NOT NULL,
  `description` text,
  `category_status` varchar(100) DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'Leafy Vegetables','These vegetables are fresh','active','2025-08-29 04:36:58'),(2,'Roots Vegetables','Sweet Potatoes/Yams. These are probably most people\'s top pick for a tasty root vegetable that has so many uses.','active','2025-08-29 04:40:35'),(3,'Fruits','Fruits are the mature, seed-bearing parts of a flowering plant, developing from the flower\'s ovary after fertilization. ','active','2025-08-29 04:46:19'),(4,'Fresh Garlic','Garlic is used for both culinary flavoring and medicinal purposes, leveraging compounds like allicin to offer benefits such as boosting the immune system, improving heart health by lowering cholesterol and blood pressure, and possessing anti-inflammatory and antioxidant properties.\r\nGarlic is used for both culinary flavoring and medicinal purposes, leveraging compounds like allicin to offer benefits such as boosting the immune system, improving heart health by lowering cholesterol and blood pressure, and possessing anti-inflammatory and antioxidant properties.','active','2025-08-29 04:47:31'),(5,'Normal Vegies','These Vegies are grown on trees.','active','2025-09-01 06:43:22'),(6,'flower Vegies','These vegies are grown with flowers','active','2025-09-03 09:22:48');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_items`
--

DROP TABLE IF EXISTS `order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_items` (
  `order_item_id` int NOT NULL AUTO_INCREMENT,
  `order_id` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `quantity` int NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `status` varchar(45) DEFAULT 'pending',
  PRIMARY KEY (`order_item_id`),
  KEY `order_id` (`order_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE,
  CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_items`
--

LOCK TABLES `order_items` WRITE;
/*!40000 ALTER TABLE `order_items` DISABLE KEYS */;
INSERT INTO `order_items` VALUES (1,2,2,3,20.00,'Cancelled by user'),(2,2,4,1,30.00,'pending'),(3,2,5,2,30.00,'pending'),(4,2,6,1,40.00,'pending'),(5,3,2,1,20.00,'pending'),(6,3,7,1,60.00,'pending'),(7,3,8,2,30.00,'Out for Delivery'),(8,4,3,1,40.00,'pending'),(9,4,4,1,30.00,'pending'),(10,5,4,1,30.00,'Delivered'),(11,5,2,3,20.00,'pending'),(12,5,1,1,10.00,'Out for Delivery'),(13,6,3,4,40.00,'pending'),(14,7,18,1,10.00,'pending');
/*!40000 ALTER TABLE `order_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `order_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `status` enum('pending','processing','shipped','delivered','cancelled') DEFAULT 'processing',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`order_id`),
  KEY `orders_ibfk_1` (`user_id`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (2,4,190.00,'pending','2025-09-03 07:12:07'),(3,3,140.00,'pending','2025-09-03 07:14:43'),(4,3,70.00,'pending','2025-09-03 07:17:55'),(5,4,100.00,'pending','2025-09-03 10:49:49'),(6,4,160.00,'pending','2025-09-09 09:19:04'),(7,4,10.00,'pending','2025-09-09 09:33:16');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payments` (
  `payment_id` int NOT NULL AUTO_INCREMENT,
  `order_id` int DEFAULT NULL,
  `amount` decimal(10,2) NOT NULL,
  `payment_method` enum('credit_card','debit_card','net_banking','upi','cod') NOT NULL,
  `payment_status` enum('pending','completed','failed') DEFAULT 'pending',
  `payment_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`payment_id`),
  KEY `order_id` (`order_id`),
  CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `product_id` int NOT NULL AUTO_INCREMENT,
  `category_id` int DEFAULT NULL,
  `name` varchar(150) NOT NULL,
  `description` text,
  `price` float NOT NULL,
  `unit` varchar(45) DEFAULT NULL,
  `stock` int NOT NULL,
  `pro_status` varchar(45) DEFAULT 'active',
  `image_url` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`product_id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,2,'Potato','Sweet Potatoes/Yams. These are probably most people\'s top pick for a tasty root vegetable that has so many uses.',10,'Kg',100,'active','../static/front_end/img/vegetable-item-5.jpg','2025-08-30 05:31:27'),(2,2,'Onion','These are fresh onions.',20,'Kg',150,'active','../static/front_end/img/onion-899102_1280.jpg','2025-08-30 06:19:32'),(3,3,'apple','These are fresh apples from farm.',40,'Kg',50,'active','../static/front_end/img/best-product-6.jpg','2025-08-30 06:20:41'),(4,3,'Strawberry','These are fresh Strawberries',30,'Kg',8000,'active','../static/front_end/img/featur-2.jpg','2025-08-30 06:25:44'),(5,3,'watermelon','These are fresh Watermelon',30,'Piece',800,'active','../static/front_end/img/download.jpg','2025-09-01 03:22:10'),(6,3,'Banana','fresh Banana',40,'Dozen',25,'active','../static/front_end/img/best-product-3.jpg','2025-09-01 04:06:18'),(7,3,'Raspberries','These are fresh Raspberries',60,'Kg',50,'active','../static/front_end/img/best-product-2.jpg','2025-09-01 06:39:19'),(8,3,'Oranges','These are fresh Oranges',30,'Kg',40,'active','../static/front_end/img/best-product-1.jpg','2025-09-01 06:40:34'),(9,5,'Bell Papers','These are fresh Bell Papers',50,'Kg',55,'active','../static/front_end/img/hero-img-1.png','2025-09-01 06:41:58'),(10,3,'Apricots','These are fresh Apricots',40,'Kg',25,'active','../static/front_end/img/best-product-4.jpg','2025-09-01 06:44:59'),(11,3,'Grapes','These are fresh Grapes',70,'Kg',60,'active','../static/front_end/img/best-product-5.jpg','2025-09-01 06:46:58'),(12,3,'Coconut','These are fresh Coconut',50,'Piece',40,'active','../static/front_end/img/coconut.jpg','2025-09-03 05:40:32'),(13,6,'Brock lie','These are fresh Brock lie',20,'Kg',20,'active','../static/front_end/img/featur-3.jpg','2025-09-03 09:21:41'),(14,1,'Coriander','These are fresh Coriander Leaves',200,'Kg',5,'active','../static/front_end/img/vegetable-item-6.jpg','2025-09-06 04:26:03'),(15,3,'Kashmiri Apples','These are fresh Kashmiri Apples',60,'Kg',40,'active','../static/front_end/img/baner-1.png','2025-09-06 05:21:06'),(16,5,'Tomato','These are fresh fresh',20,'Kg',100,'active','../static/front_end/img/vegetable-item-1.jpg','2025-09-09 03:43:01'),(17,5,'Capsicums Red','These are fresh Capsicum red',20,'Kg',80,'active','../static/front_end/img/vegetable-item-4.jpg','2025-09-09 03:52:22'),(18,1,'Spinach','These are fresh Spinach',10,'Kg',50,'active','../static/front_end/img/avatar.jpg','2025-09-09 06:40:11');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `user_name` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `password` varchar(255) NOT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `address` text,
  `city` varchar(100) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `zip_code` varchar(100) DEFAULT NULL,
  `role` enum('customer','admin','sales','manager') DEFAULT 'customer',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`,`email`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Mohd zubair','angzubair@gmail.com','12345678','9560840446','None','None','None','None','admin','2025-08-25 07:27:15'),(2,'Mohd zubair','zubairalam96@yahoo.com','12345678','9560840446','H-62, Ekta Vihar , Gyan Mandir Road','None','India','None','customer','2025-08-25 07:39:32'),(3,'Mohd Aleem','aleem@gmail.com','12345678','3565982515','91, Taimoor Nagar','New Delhi','India','110025','admin','2025-08-29 11:28:54'),(4,'Mohd zubair','mrzubalam@gmail.com','12345678','9560840446','H-62, Ekta vihar','New Delhi','India.','110044','customer','2025-08-25 08:34:36'),(5,'Mohd zafar','zafar@gmail.com','1345678','9560840446','None','None','None','None','customer','2025-08-25 09:06:46'),(6,'Mohd zubair','zaf@gmail.com','12345678','9560840446','None','None','None','None','customer','2025-08-25 09:15:37'),(7,'Honey  singh','honeysingh@gmail.com','12345678','36586325',NULL,NULL,NULL,NULL,'customer','2025-09-07 04:58:37'),(8,'Rahul Kumar','Rahul@gmail.com','12345678','3658965412',NULL,NULL,NULL,NULL,'sales','2025-09-07 05:32:02'),(10,'ruqmani','ruqmani@gmail.com','12345678','365268965',NULL,NULL,NULL,NULL,'sales','2025-09-08 05:04:53'),(11,'Tushar Mehta','Tushar@gmail.com','12345678','659832689',NULL,NULL,NULL,NULL,'sales','2025-09-13 06:12:57'),(12,'Rohit','Rohit@gmail.com','12345678','6598326574',NULL,NULL,NULL,NULL,'sales','2025-09-13 06:14:02');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_url`
--

DROP TABLE IF EXISTS `users_url`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_url` (
  `url_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `user_pic_url` varchar(200) DEFAULT NULL,
  `user_active` varchar(45) DEFAULT 'active',
  PRIMARY KEY (`url_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_url`
--

LOCK TABLES `users_url` WRITE;
/*!40000 ALTER TABLE `users_url` DISABLE KEYS */;
INSERT INTO `users_url` VALUES (1,1,'static/back_end/assets/img/avatars/7.png','active'),(2,2,'static/back_end/assets/img/avatars/1.png','active'),(3,3,'static/back_end/assets/img/avatars/7.png','not active'),(4,4,'../static/back_end/assets/img/avatars/7.png','active'),(5,5,'../static/back_end/assets/img/avatars/1.png','active'),(6,6,'../static/back_end/assets/img/avatars/1.png','active'),(7,7,'../static/back_end/assets/img/avatars/default_image.jpg','active'),(8,8,'../static/back_end/assets/img/avatars/default_image.jpg','not active'),(9,10,'../static/back_end/assets/img/avatars/default_image.jpg','active'),(10,11,'../static/back_end/assets/img/avatars/default_image.jpg','not active'),(11,12,'../static/back_end/assets/img/avatars/default_image.jpg','not active');
/*!40000 ALTER TABLE `users_url` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-09-25  9:42:40
