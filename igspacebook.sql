-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema igspacebook
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `igspacebook` ;

-- -----------------------------------------------------
-- Schema igspacebook
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `igspacebook` DEFAULT CHARACTER SET latin1 ;
USE `igspacebook` ;

-- -----------------------------------------------------
-- Table `igspacebook`.`user_role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `igspacebook`.`user_role` ;

CREATE TABLE IF NOT EXISTS `igspacebook`.`user_role` (
  `user_role_id` TINYINT(4) NOT NULL COMMENT 'Primary key',
  `role_desc` VARCHAR(20) NOT NULL COMMENT 'A description of the alien user\'s role in the application',
  PRIMARY KEY (`user_role_id`),
  UNIQUE INDEX `role_desc` (`role_desc` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `igspacebook`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `igspacebook`.`user` ;

CREATE TABLE IF NOT EXISTS `igspacebook`.`user` (
  `user_id` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT 'Primary key',
  `date_created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'The date the user was created (e.g. registered)',
  `full_name` VARCHAR(75) NOT NULL COMMENT 'The real, full name of the alien user',
  `email` VARCHAR(255) NOT NULL COMMENT 'The email address which uniquely identifies the alien user on the application',
  `passwd` CHAR(64) NOT NULL COMMENT 'The hashed password of the user',
  `salt` CHAR(64) NOT NULL COMMENT 'The salt used to hash the password',
  `user_role_id` TINYINT(4) NOT NULL DEFAULT '1' COMMENT 'Foreign key constraint referencing user_role.user_role_id',
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `email` (`email` ASC),
  INDEX `user_fk_user_role` (`user_role_id` ASC),
  CONSTRAINT `user_fk_user_role`
    FOREIGN KEY (`user_role_id`)
    REFERENCES `igspacebook`.`user_role` (`user_role_id`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 24
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `igspacebook`.`suspension`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `igspacebook`.`suspension` ;

CREATE TABLE IF NOT EXISTS `igspacebook`.`suspension` (
  `suspension_id` BIGINT(20) NOT NULL,
  `user_id` BIGINT(20) NOT NULL,
  `status` TINYINT(4) NOT NULL,
  `suspension_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`suspension_id`),
  UNIQUE INDEX `user_id` (`user_id` ASC),
  CONSTRAINT `suspension_fk_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `igspacebook`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `igspacebook`.`user_profile`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `igspacebook`.`user_profile` ;

CREATE TABLE IF NOT EXISTS `igspacebook`.`user_profile` (
  `user_id` BIGINT(20) NOT NULL COMMENT 'Primary key. Foreign key reference to user.user_id',
  `display_name` VARCHAR(50) NOT NULL COMMENT 'The display name, or alias, of the alien user',
  `tagline` VARCHAR(75) NULL DEFAULT NULL COMMENT '(Optional) A short tagline that summarizes the user',
  `bio` VARCHAR(1000) NULL DEFAULT NULL COMMENT '(Optional) A longer description, or biography, about the user',
  `profile_photo` BLOB NULL DEFAULT NULL COMMENT '(Optional) A photo of the user',
  `galaxy_name` VARCHAR(50) NULL DEFAULT NULL COMMENT '(Optional) Which galaxy the user is from',
  `solar_sys_name` VARCHAR(50) NULL DEFAULT NULL COMMENT '(Optional) Which solar system the user is from',
  `planet_name` VARCHAR(50) NULL DEFAULT NULL COMMENT '(Optional) Which planet the user is from',
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `display_name` (`display_name` ASC),
  INDEX `galaxy_name` (`galaxy_name` ASC),
  INDEX `solar_sys_name` (`solar_sys_name` ASC),
  INDEX `planet_name` (`planet_name` ASC),
  INDEX `galaxy_name_2` (`galaxy_name` ASC, `solar_sys_name` ASC),
  INDEX `galaxy_name_3` (`galaxy_name` ASC, `solar_sys_name` ASC, `planet_name` ASC),
  CONSTRAINT `user_profile_fk_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `igspacebook`.`user` (`user_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

USE `igspacebook` ;

-- -----------------------------------------------------
-- Placeholder table for view `igspacebook`.`get_profile`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `igspacebook`.`get_profile` (`user_id` INT, `date_created` INT, `full_name` INT, `email` INT, `passwd` INT, `salt` INT, `user_role_id` INT, `display_name` INT, `tagline` INT, `bio` INT, `profile_photo` INT, `galaxy_name` INT, `solar_sys_name` INT, `planet_name` INT, `suspension_status` INT, `suspension_date` INT);

-- -----------------------------------------------------
-- View `igspacebook`.`get_profile`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `igspacebook`.`get_profile`;
DROP VIEW IF EXISTS `igspacebook`.`get_profile` ;
USE `igspacebook`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `igspacebook`.`get_profile` AS select `igspacebook`.`user`.`user_id` AS `user_id`,`igspacebook`.`user`.`date_created` AS `date_created`,`igspacebook`.`user`.`full_name` AS `full_name`,`igspacebook`.`user`.`email` AS `email`,`igspacebook`.`user`.`passwd` AS `passwd`,`igspacebook`.`user`.`salt` AS `salt`,`igspacebook`.`user`.`user_role_id` AS `user_role_id`,`igspacebook`.`user_profile`.`display_name` AS `display_name`,`igspacebook`.`user_profile`.`tagline` AS `tagline`,`igspacebook`.`user_profile`.`bio` AS `bio`,`igspacebook`.`user_profile`.`profile_photo` AS `profile_photo`,`igspacebook`.`user_profile`.`galaxy_name` AS `galaxy_name`,`igspacebook`.`user_profile`.`solar_sys_name` AS `solar_sys_name`,`igspacebook`.`user_profile`.`planet_name` AS `planet_name`,`igspacebook`.`suspension`.`status` AS `suspension_status`,`igspacebook`.`suspension`.`suspension_date` AS `suspension_date` from ((`igspacebook`.`user` join `igspacebook`.`user_profile` on((`igspacebook`.`user`.`user_id` = `igspacebook`.`user_profile`.`user_id`))) left join `igspacebook`.`suspension` on((`igspacebook`.`user`.`user_id` = `igspacebook`.`suspension`.`user_id`)));

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
