-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema pcbay
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema pcbay
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pcbay` DEFAULT CHARACTER SET utf8 ;
USE `pcbay` ;

-- -----------------------------------------------------
-- Table `pcbay`.`storage`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pcbay`.`storage` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT,
  `BRAND` VARCHAR(20) NOT NULL,
  `MODEL` VARCHAR(20) NOT NULL,
  `SIZE` INT(11) NOT NULL,
  `QUANTITY` INT(11) NOT NULL DEFAULT '0',
  `IMAGE` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `pcbay`.`graphics`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pcbay`.`graphics` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT,
  `BRAND` VARCHAR(20) NOT NULL,
  `MODEL` VARCHAR(20) NOT NULL,
  `QUANTITY` INT(11) NOT NULL,
  `IMAGE` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `pcbay`.`ram`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pcbay`.`ram` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT,
  `BRAND` VARCHAR(20) NOT NULL,
  `MODEL` VARCHAR(20) NOT NULL,
  `SIZE` INT(11) NOT NULL,
  `QUANTITY` INT(11) NOT NULL DEFAULT '0',
  `IMAGE` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `pcbay`.`processor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pcbay`.`processor` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT,
  `BRAND` VARCHAR(20) NOT NULL,
  `TYPE` VARCHAR(20) NOT NULL,
  `QUANTITY` INT(11) NOT NULL,
  `IMAGE` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `pcbay`.`power`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pcbay`.`power` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT,
  `BRAND` VARCHAR(20) NOT NULL,
  `MODEL` VARCHAR(20) NOT NULL,
  `QUANTITY` INT(11) NOT NULL DEFAULT '0',
  `IMAGE` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `pcbay`.`motherboard`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pcbay`.`motherboard` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT,
  `BRAND` VARCHAR(20) NOT NULL,
  `MODEL` VARCHAR(20) NOT NULL,
  `QUANTITY` INT(11) NOT NULL DEFAULT '0',
  `IMAGE` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `pcbay`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pcbay`.`user` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT,
  `FIRST_NAME` VARCHAR(50) NOT NULL,
  `LAST_NAME` VARCHAR(50) NOT NULL,
  `USER_NAME` VARCHAR(20) NOT NULL,
  `EMAIL` VARCHAR(50) NOT NULL,
  `PASSWORD` VARCHAR(64) NOT NULL,
  `ADMIN` INT(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `USER_NAME_UNIQUE` (`USER_NAME` ASC),
  UNIQUE INDEX `EMAIL_UNIQUE` (`EMAIL` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `pcbay`.`cart`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pcbay`.`cart` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT,
  `STORAGE_ID` INT(11) NULL DEFAULT NULL,
  `GRAPHICS_ID` INT(11) NULL DEFAULT NULL,
  `RAM_ID` INT(11) NULL DEFAULT NULL,
  `PROCESSOR_ID` INT(11) NULL DEFAULT NULL,
  `POWER_ID` INT(11) NULL DEFAULT NULL,
  `MOTHERBOARD_ID` INT(11) NULL DEFAULT NULL,
  `USER_ID` INT(11) NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `storageid_idx` (`STORAGE_ID` ASC),
  INDEX `graphicsid_idx` (`GRAPHICS_ID` ASC),
  INDEX `ramid_idx` (`RAM_ID` ASC),
  INDEX `processorid_idx` (`PROCESSOR_ID` ASC),
  INDEX `powerid_idx` (`POWER_ID` ASC),
  INDEX `motherboardid_idx` (`MOTHERBOARD_ID` ASC),
  INDEX `userid_idx` (`USER_ID` ASC),
  CONSTRAINT `storageid`
    FOREIGN KEY (`STORAGE_ID`)
    REFERENCES `pcbay`.`storage` (`ID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `graphicsid`
    FOREIGN KEY (`GRAPHICS_ID`)
    REFERENCES `pcbay`.`graphics` (`ID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `ramid`
    FOREIGN KEY (`RAM_ID`)
    REFERENCES `pcbay`.`ram` (`ID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `processorid`
    FOREIGN KEY (`PROCESSOR_ID`)
    REFERENCES `pcbay`.`processor` (`ID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `powerid`
    FOREIGN KEY (`POWER_ID`)
    REFERENCES `pcbay`.`power` (`ID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `motherboardid`
    FOREIGN KEY (`MOTHERBOARD_ID`)
    REFERENCES `pcbay`.`motherboard` (`ID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `userid`
    FOREIGN KEY (`USER_ID`)
    REFERENCES `pcbay`.`user` (`ID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
