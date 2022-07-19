-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema cul_ampolla
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema cul_ampolla
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `cul_ampolla` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `cul_ampolla` ;

-- -----------------------------------------------------
-- Table `cul_ampolla`.`empleats`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cul_ampolla`.`empleats` (
  `IdEmpleat` SMALLINT NOT NULL AUTO_INCREMENT,
  `Nom` VARCHAR(25) NOT NULL,
  `Cognoms` VARCHAR(80) NOT NULL,
  PRIMARY KEY (`IdEmpleat`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `cul_ampolla`.`proveidors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cul_ampolla`.`proveidors` (
  `IdProveidor` SMALLINT NOT NULL AUTO_INCREMENT,
  `NIF` SMALLINT NOT NULL,
  `Nom` VARCHAR(100) NOT NULL,
  `Carrer` VARCHAR(50) NOT NULL,
  `Número` SMALLINT NOT NULL,
  `Pis` SMALLINT NULL DEFAULT NULL,
  `Porta` SMALLINT NULL DEFAULT NULL,
  `Ciutat` VARCHAR(45) NOT NULL,
  `Codi_Postal` VARCHAR(8) NOT NULL,
  `Pais` VARCHAR(45) NOT NULL,
  `Telèfon` VARCHAR(12) NOT NULL,
  `Fax` VARCHAR(12) NULL DEFAULT NULL,
  PRIMARY KEY (`IdProveidor`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `cul_ampolla`.`ulleres`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cul_ampolla`.`ulleres` (
  `IdMarca` SMALLINT NOT NULL AUTO_INCREMENT,
  `ProveidorExclussiu` TINYINT NULL DEFAULT NULL,
  `IdProveidor` SMALLINT NOT NULL,
  `Marca` VARCHAR(80) NOT NULL,
  `Graduacio_vidre_dret` DECIMAL(1,1) NOT NULL,
  `Graduacio_vidre_esquerre` DECIMAL(1,1) NOT NULL,
  `Muntura_Flotant` TINYINT NULL DEFAULT NULL,
  `Muntura_Pasta` TINYINT NULL DEFAULT NULL,
  `Muntura_Metalica` TINYINT NULL DEFAULT NULL,
  `Color_Muntura` VARCHAR(10) NOT NULL,
  `Color_vidre_dret` VARCHAR(10) NOT NULL,
  `Color_vidre_esquerre` VARCHAR(10) NOT NULL,
  `Preu` SMALLINT NOT NULL,
  PRIMARY KEY (`IdMarca`),
  CONSTRAINT `fk_ulleres_proveidors_id`
    FOREIGN KEY (`IdMarca`)
    REFERENCES `cul_ampolla`.`proveidors` (`IdProveidor`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `cul_ampolla`.`clients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cul_ampolla`.`clients` (
  `IdClient` SMALLINT NOT NULL AUTO_INCREMENT,
  `Nom` VARCHAR(45) NOT NULL,
  `Cognoms` VARCHAR(80) NOT NULL,
  `Adreça` VARCHAR(100) NOT NULL,
  `Ciutat` VARCHAR(45) NOT NULL,
  `Codi_Postal` VARCHAR(8) NOT NULL,
  `Telèfon` VARCHAR(12) NOT NULL,
  `Email` VARCHAR(100) NOT NULL,
  `Data_registre` DATE NOT NULL,
  `IdClientRecomenat` SMALLINT NULL DEFAULT NULL,
  `IdEmpleat` SMALLINT NOT NULL,
  PRIMARY KEY (`IdClient`),
  CONSTRAINT `fk_clients_empleats_id`
    FOREIGN KEY (`IdClient`)
    REFERENCES `cul_ampolla`.`empleats` (`IdEmpleat`),
  CONSTRAINT `fk_clients_ulleres_id`
    FOREIGN KEY (`IdClient`)
    REFERENCES `cul_ampolla`.`ulleres` (`IdMarca`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
