-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema moviesite
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema moviesite
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `moviesite` DEFAULT CHARACTER SET utf8 ;
USE `moviesite` ;

-- -----------------------------------------------------
-- Table `moviesite`.`billingaddress`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `moviesite`.`billingaddress` (
  `BILLING_ID` INT(11) NOT NULL,
  `ADDRESS_1` VARCHAR(100) NOT NULL,
  `ADDRESS_2` VARCHAR(100) NULL DEFAULT NULL,
  `ADDRESS_3` VARCHAR(100) NULL DEFAULT NULL,
  `COUNTRY` VARCHAR(30) NOT NULL,
  `CITY` VARCHAR(45) NOT NULL,
  `STATE` VARCHAR(45) NOT NULL,
  `ZIP` VARCHAR(5) NOT NULL,
  PRIMARY KEY (`BILLING_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `moviesite`.`mailingaddress`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `moviesite`.`mailingaddress` (
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
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `moviesite`.`movie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `moviesite`.`movie` (
  `MOVIE_ID` INT(11) NOT NULL AUTO_INCREMENT,
  `NAME` VARCHAR(20) NOT NULL,
  `PURCHASE_PRICE` FLOAT NOT NULL,
  `RENT_PRICE` FLOAT NOT NULL,
  PRIMARY KEY (`MOVIE_ID`),
  UNIQUE INDEX `NAME_UNIQUE` (`NAME`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `moviesite`.`payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `moviesite`.`payment` (
  `CARD_ID` INT(11) NOT NULL AUTO_INCREMENT,
  `CARD_NUMBER` VARCHAR(16) NOT NULL,
  `EXPIRATION` DATE NOT NULL,
  `CCV` VARCHAR(3) NOT NULL,
  `BILLING_ADDRESS` INT(11) NOT NULL,
  PRIMARY KEY (`CARD_ID`),
  UNIQUE INDEX `CARD_NUMBER_UNIQUE` (`CARD_NUMBER`),
  INDEX `Billing_Address_idx` (`BILLING_ADDRESS`),
  CONSTRAINT `Billing_Address`
    FOREIGN KEY (`BILLING_ADDRESS`)
    REFERENCES `moviesite`.`billingaddress` (`BILLING_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `moviesite`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `moviesite`.`user` (
  `USER_ID` INT(11) NOT NULL AUTO_INCREMENT,
  `USERNAME` VARCHAR(45) NOT NULL,
  `EMAIL` VARCHAR(100) NULL DEFAULT NULL,
  `CARD_ID` INT(11) NULL DEFAULT NULL,
  `MAILING_ADD` INT(11) NULL DEFAULT NULL,
  `BILLING_ADD` INT(11) NULL DEFAULT NULL,
  `PASSWORD` VARCHAR(64) NOT NULL,
  PRIMARY KEY (`USER_ID`),
  UNIQUE INDEX `EMAIL_UNIQUE` (`EMAIL`),
  INDEX `Card_Info_idx` (`CARD_ID`),
  INDEX `Mailing_idx` (`MAILING_ADD`),
  CONSTRAINT `Card_Info`
    FOREIGN KEY (`CARD_ID`)
    REFERENCES `moviesite`.`payment` (`CARD_ID`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION,
  CONSTRAINT `Mailing`
    FOREIGN KEY (`MAILING_ADD`)
    REFERENCES `moviesite`.`mailingaddress` (`MAILING_ID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `moviesite`.`user_movie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `moviesite`.`user_movie` (
  `USER_MOVIE_ID` INT(11) NOT NULL AUTO_INCREMENT,
  `USER_ID` INT(11) NOT NULL,
  `MOVIE_ID` INT(11) NOT NULL,
  PRIMARY KEY (`USER_MOVIE_ID`),
  INDEX `UserId_idx` (`USER_ID`),
  INDEX `MovieId_idx` (`MOVIE_ID`),
  CONSTRAINT `MovieId`
    FOREIGN KEY (`MOVIE_ID`)
    REFERENCES `moviesite`.`movie` (`MOVIE_ID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `UserId`
    FOREIGN KEY (`USER_ID`)
    REFERENCES `moviesite`.`user` (`USER_ID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
