-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema bbab
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema bbab
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `bbab` DEFAULT CHARACTER SET latin1 ;
USE `bbab` ;

-- -----------------------------------------------------
-- Table `bbab`.`gun`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bbab`.`gun` (
  `GUN_ID` INT(11) NOT NULL AUTO_INCREMENT,
  `MAKE` VARCHAR(45) NOT NULL,
  `MODEL` VARCHAR(45) NOT NULL,
  `CALIBER` VARCHAR(45) NOT NULL,
  `SERIEL_NUMBER` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`GUN_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `bbab`.`mailaddress`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bbab`.`mailaddress` (
  `MAIL_ID` INT(11) NOT NULL AUTO_INCREMENT,
  `ADDRESS_1` VARCHAR(100) NOT NULL,
  `ADDRESS_2` VARCHAR(100) NULL DEFAULT NULL,
  `STREET` VARCHAR(100) NOT NULL,
  `CITY` VARCHAR(50) NOT NULL,
  `STATE` VARCHAR(50) NOT NULL,
  `ZIP` VARCHAR(5) NOT NULL,
  PRIMARY KEY (`MAIL_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `bbab`.`payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bbab`.`payment` (
  `PAYMENT_ID` INT(11) NOT NULL,
  `CARD_NUMBER` VARCHAR(45) NULL DEFAULT NULL,
  `EX_DATE` VARCHAR(45) NULL DEFAULT NULL,
  `CVV` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`PAYMENT_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `bbab`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bbab`.`user` (
  `USER_ID` INT(11) NOT NULL AUTO_INCREMENT,
  `FULL_NAME` VARCHAR(45) NULL DEFAULT NULL,
  `USERNAME` VARCHAR(45) NOT NULL,
  `EMAIL` VARCHAR(45) NOT NULL,
  `PASSWORD` VARCHAR(64) NULL DEFAULT NULL,
  `MAIL_ADDRESS` INT(11) NULL DEFAULT NULL,
  `CARD_INFORMATION` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`USER_ID`),
  UNIQUE INDEX `USERNAME_UNIQUE` (`USERNAME` ASC) VISIBLE,
  UNIQUE INDEX `EMAIL_UNIQUE` (`EMAIL` ASC) VISIBLE,
  INDEX `mail_fk_idx` (`MAIL_ADDRESS` ASC) VISIBLE,
  INDEX `pay_fk_idx` (`CARD_INFORMATION` ASC) VISIBLE,
  CONSTRAINT `mail_fk`
    FOREIGN KEY (`MAIL_ADDRESS`)
    REFERENCES `bbab`.`mailaddress` (`MAIL_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `pay_fk`
    FOREIGN KEY (`CARD_INFORMATION`)
    REFERENCES `bbab`.`payment` (`PAYMENT_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
