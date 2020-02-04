-- phpMyAdmin SQL Dump
-- version 4.7.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Feb 04, 2020 at 04:13 AM
-- Server version: 5.6.34-log
-- PHP Version: 7.1.5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `igspacebook`
--
CREATE DATABASE `igspacebook`;
USE `igspacebook`;
-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `user_id` bigint(20) NOT NULL COMMENT 'Primary key',
  `date_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'The date the user was created (e.g. registered)',
  `full_name` varchar(75) NOT NULL COMMENT 'The real, full name of the alien user',
  `email` varchar(255) NOT NULL COMMENT 'The email address which uniquely identifies the alien user on the application',
  `passwd` char(64) NOT NULL COMMENT 'The hashed password of the user',
  `salt` char(64) NOT NULL COMMENT 'The salt used to hash the password',
  `user_role_id` tinyint(4) NOT NULL DEFAULT '1' COMMENT 'Foreign key constraint referencing user_role.user_role_id'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`user_id`, `date_created`, `full_name`, `email`, `passwd`, `salt`, `user_role_id`) VALUES
(17, '2020-02-01 19:19:32', 'Michael Mason', 'mmason.pro@gmail.com', '9238c87224d8a42b802d312a90e750f380725eaa4a3742245d44a0420b41eb6a', 'bM8XebKFCuAZuSU3wfRBN3RqYGAIXJsEduWmIDiw3S38VzBqQkPGbbyrseuotITZ', 1),
(21, '2020-02-01 19:39:43', 'Michael mason', 'MMason29@my.gcu.edu', '3cffb257735766a16362c8d139a7925375ffe6f6a0267375096816e0d0e8bd4b', '935P0B2HytHVbNvQxWmkT1gjxWlL6uVkjF0dLETpZbeiF4a3uxAh9u2H8HCpd8Ol', 1),
(22, '2020-02-03 17:54:13', 'Mike Mason', 'djsavra@gmail.com', '43a4980d46c01009c5072d61f131de3f85e878928cbeadb87b978a4798288bed', 'MT3wIgp8erN4e8Jn61UK6bKBSP96r7t5F6dgtohrWnnjy4DVrQWQ51R5LS8rFQKT', 1);

-- --------------------------------------------------------

--
-- Table structure for table `user_profile`
--

CREATE TABLE `user_profile` (
  `user_id` bigint(20) NOT NULL COMMENT 'Primary key. Foreign key reference to user.user_id',
  `display_name` varchar(50) NOT NULL COMMENT 'The display name, or alias, of the alien user',
  `tagline` varchar(75) DEFAULT NULL COMMENT '(Optional) A short tagline that summarizes the user',
  `bio` varchar(1000) DEFAULT NULL COMMENT '(Optional) A longer description, or biography, about the user',
  `profile_photo` blob COMMENT '(Optional) A photo of the user',
  `galaxy_name` varchar(50) DEFAULT NULL COMMENT '(Optional) Which galaxy the user is from',
  `solar_sys_name` varchar(50) DEFAULT NULL COMMENT '(Optional) Which solar system the user is from',
  `planet_name` varchar(50) DEFAULT NULL COMMENT '(Optional) Which planet the user is from'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user_profile`
--

INSERT INTO `user_profile` (`user_id`, `display_name`, `tagline`, `bio`, `profile_photo`, `galaxy_name`, `solar_sys_name`, `planet_name`) VALUES
(21, 'Xergii the Astrol', NULL, NULL, NULL, NULL, NULL, NULL),
(22, 'Chromes', NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user_role`
--

CREATE TABLE `user_role` (
  `user_role_id` tinyint(4) NOT NULL COMMENT 'Primary key',
  `role_desc` varchar(20) COLLATE utf8_bin NOT NULL COMMENT 'A description of the alien user''s role in the application'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `user_role`
--

INSERT INTO `user_role` (`user_role_id`, `role_desc`) VALUES
(4, 'Master Admin'),
(2, 'Moderator'),
(3, 'Site Admin'),
(1, 'User');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `user_fk_user_role` (`user_role_id`);

--
-- Indexes for table `user_profile`
--
ALTER TABLE `user_profile`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `display_name` (`display_name`),
  ADD KEY `galaxy_name` (`galaxy_name`),
  ADD KEY `solar_sys_name` (`solar_sys_name`),
  ADD KEY `planet_name` (`planet_name`),
  ADD KEY `galaxy_name_2` (`galaxy_name`,`solar_sys_name`),
  ADD KEY `galaxy_name_3` (`galaxy_name`,`solar_sys_name`,`planet_name`);

--
-- Indexes for table `user_role`
--
ALTER TABLE `user_role`
  ADD PRIMARY KEY (`user_role_id`),
  ADD UNIQUE KEY `role_desc` (`role_desc`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `user_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'Primary key', AUTO_INCREMENT=23;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `user_fk_user_role` FOREIGN KEY (`user_role_id`) REFERENCES `user_role` (`user_role_id`) ON UPDATE CASCADE;

--
-- Constraints for table `user_profile`
--
ALTER TABLE `user_profile`
  ADD CONSTRAINT `user_profile_fk_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`);
COMMIT;

Create View `get_profile` As
SELECT `user_id`, `full_name`, `email`, `passwd`, `salt`, `role_desc`, `display_name`, `tagline`, `bio`, `profile_photo`, `galaxy_name`, `solar_sys_name`, `planet_name`
FROM `user`
INNER JOIN `user_profile` USING(`user_id`)
INNER JOIN `user_role` ON `user`.`user_role_id` = `user_role`.`user_role_id`;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
