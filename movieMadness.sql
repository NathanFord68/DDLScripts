-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema moviemadness
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema moviemadness
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `moviemadness` DEFAULT CHARACTER SET utf8 ;
USE `moviemadness` ;

-- -----------------------------------------------------
-- Table `moviemadness`.`billingaddress`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `moviemadness`.`billingaddress` (
  `BILLING_ID` INT(11) NOT NULL AUTO_INCREMENT,
  `ADDRESS_1` VARCHAR(100) NOT NULL,
  `ADDRESS_2` VARCHAR(100) NULL DEFAULT NULL,
  `ADDRESS_3` VARCHAR(100) NULL DEFAULT NULL,
  `COUNTRY` VARCHAR(30) NOT NULL,
  `CITY` VARCHAR(45) NOT NULL,
  `STATE` VARCHAR(45) NOT NULL,
  `ZIP` VARCHAR(5) NOT NULL,
  PRIMARY KEY (`BILLING_ID`))
ENGINE = InnoDB
AUTO_INCREMENT = 15
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `moviemadness`.`mailingaddress`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `moviemadness`.`mailingaddress` (
  `MAILING_ID` INT(11) NOT NULL AUTO_INCREMENT,
  `ADDRESS_1` VARCHAR(100) NOT NULL,
  `ADDRESS_2` VARCHAR(100) NULL DEFAULT NULL,
  `ADDRESS_3` VARCHAR(100) NULL DEFAULT NULL,
  `COUNTRY` VARCHAR(30) NOT NULL,
  `CITY` VARCHAR(45) NOT NULL,
  `STATE` VARCHAR(45) NOT NULL,
  `ZIP` VARCHAR(5) NOT NULL,
  PRIMARY KEY (`MAILING_ID`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `moviemadness`.`movie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `moviemadness`.`movie` (
  `MOVIE_ID` INT(11) NOT NULL AUTO_INCREMENT,
  `NAME` VARCHAR(100) NOT NULL,
  `PURCHASE_PRICE` FLOAT NOT NULL,
  `RENT_PRICE` FLOAT NOT NULL,
  `QUANTITY` INT(11) NOT NULL DEFAULT 0,
  `GENRE` VARCHAR(25) NOT NULL,
  `SUMMARY` TEXT NOT NULL,
  `IMAGE_URI` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`MOVIE_ID`),
  UNIQUE INDEX `NAME_UNIQUE` (`NAME`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `moviemadness`.`payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `moviemadness`.`payment` (
  `CARD_ID` INT(11) NOT NULL AUTO_INCREMENT,
  `CARD_NUMBER` VARCHAR(16) NOT NULL,
  `NAME` VARCHAR(100) NOT NULL,
  `EXPIRATION` DATE NOT NULL,
  `CCV` VARCHAR(3) NOT NULL,
  `BILLING_ADDRESS` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`CARD_ID`),
  UNIQUE INDEX `CARD_NUMBER_UNIQUE` (`CARD_NUMBER`),
  INDEX `Billing_Address_idx` (`BILLING_ADDRESS`),
  CONSTRAINT `Billing_Address`
    FOREIGN KEY (`BILLING_ADDRESS`)
    REFERENCES `moviemadness`.`billingaddress` (`BILLING_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `moviemadness`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `moviemadness`.`user` (
  `USER_ID` INT(11) NOT NULL AUTO_INCREMENT,
  `FIRSTNAME` VARCHAR(50) NOT NULL,
  `LASTNAME` VARCHAR(50) NOT NULL,
  `USERNAME` VARCHAR(45) NOT NULL,
  `EMAIL` VARCHAR(100) NULL DEFAULT NULL,
  `CARD_ID` INT(11) NULL DEFAULT NULL,
  `MAILING_ADD` INT(11) NULL DEFAULT NULL,
  `PASSWORD` VARCHAR(64) NOT NULL,
  `ADMIN` INT(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`USER_ID`),
  UNIQUE INDEX `EMAIL_UNIQUE` (`EMAIL`),
  INDEX `Card_Info_idx` (`CARD_ID`),
  INDEX `Mailing_idx` (`MAILING_ADD`),
  CONSTRAINT `Card_Info`
    FOREIGN KEY (`CARD_ID`)
    REFERENCES `moviemadness`.`payment` (`CARD_ID`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION,
  CONSTRAINT `Mailing`
    FOREIGN KEY (`MAILING_ADD`)
    REFERENCES `moviemadness`.`mailingaddress` (`MAILING_ID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `moviemadness`.`user_movie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `moviemadness`.`user_movie` (
  `USER_MOVIE_ID` INT(11) NOT NULL AUTO_INCREMENT,
  `USER_ID` INT(11) NOT NULL,
  `MOVIE_ID` INT(11) NOT NULL,
  `DAYS_RENTAL` INT(11) NOT NULL DEFAULT 15,
  PRIMARY KEY (`USER_MOVIE_ID`),
  INDEX `UserId_idx` (`USER_ID`),
  INDEX `MovieId_idx` (`MOVIE_ID`),
  CONSTRAINT `MovieId`
    FOREIGN KEY (`MOVIE_ID`)
    REFERENCES `moviemadness`.`movie` (`MOVIE_ID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `UserId`
    FOREIGN KEY (`USER_ID`)
    REFERENCES `moviemadness`.`user` (`USER_ID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
