-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema pizzeria
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema pizzeria
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pizzeria` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `pizzeria` ;

-- -----------------------------------------------------
-- Table `pizzeria`.`provincia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`provincia` (
  `IdProvincia` SMALLINT NOT NULL,
  `Provincia` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`IdProvincia`),
  UNIQUE INDEX `IdProvincia_UNIQUE` (`IdProvincia` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizzeria`.`localitat`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`localitat` (
  `Codi_Postal` SMALLINT NOT NULL,
  `Localitat` VARCHAR(60) NOT NULL,
  `IdProvincia` SMALLINT NOT NULL,
  PRIMARY KEY (`Codi_Postal`),
  UNIQUE INDEX `Codi_Postal_UNIQUE` (`Codi_Postal` ASC) VISIBLE,
  INDEX `fk_localitat_provincia_id_idx` (`IdProvincia` ASC) VISIBLE,
  CONSTRAINT `fk_localitat_provincia_id`
    FOREIGN KEY (`IdProvincia`)
    REFERENCES `pizzeria`.`provincia` (`IdProvincia`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizzeria`.`botiga`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`botiga` (
  `IdBotiga` SMALLINT NOT NULL,
  `IdComanda` SMALLINT NULL DEFAULT NULL,
  `Adreça` VARCHAR(100) NOT NULL,
  `Codi_postal` SMALLINT NOT NULL,
  PRIMARY KEY (`IdBotiga`),
  UNIQUE INDEX `IdBotiga_UNIQUE` (`IdBotiga` ASC) VISIBLE,
  INDEX `fk_botiga_localitat_cp_idx` (`Codi_postal` ASC) VISIBLE,
  CONSTRAINT `fk_botiga_localitat_cp`
    FOREIGN KEY (`Codi_postal`)
    REFERENCES `pizzeria`.`localitat` (`Codi_Postal`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizzeria`.`categoria_pizzes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`categoria_pizzes` (
  `IdCategoriaPizza` SMALLINT NOT NULL,
  `Categoria_Pizza` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`IdCategoriaPizza`),
  UNIQUE INDEX `IdCategoriaPizza_UNIQUE` (`IdCategoriaPizza` ASC) VISIBLE,
  INDEX `IdCategoriaPizzes` (`IdCategoriaPizza` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizzeria`.`clients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`clients` (
  `IdClient` SMALLINT NOT NULL,
  `Nom` VARCHAR(45) NOT NULL,
  `Cognoms` VARCHAR(80) NOT NULL,
  `Adreça` VARCHAR(100) NOT NULL,
  `Codi_Postal` SMALLINT NOT NULL,
  `Telefon` VARCHAR(12) NOT NULL,
  PRIMARY KEY (`IdClient`),
  UNIQUE INDEX `idclients_UNIQUE` (`IdClient` ASC) VISIBLE,
  INDEX `fk_clients_localitat_cp_idx` (`Codi_Postal` ASC) VISIBLE,
  CONSTRAINT `fk_clients_localitat_cp`
    FOREIGN KEY (`Codi_Postal`)
    REFERENCES `pizzeria`.`localitat` (`Codi_Postal`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizzeria`.`empleats`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`empleats` (
  `IdEmpleat` SMALLINT NOT NULL AUTO_INCREMENT,
  `IdBotiga` SMALLINT NOT NULL,
  `Nom` VARCHAR(45) NOT NULL,
  `Cognoms` VARCHAR(60) NOT NULL,
  `NIF` VARCHAR(9) NOT NULL,
  `Telefon` VARCHAR(12) NOT NULL,
  `Cuiner` TINYINT NULL DEFAULT NULL,
  `Repartidor` TINYINT NULL DEFAULT NULL,
  `IdRepartidor` SMALLINT NULL DEFAULT NULL,
  PRIMARY KEY (`IdEmpleat`),
  UNIQUE INDEX `IdEmpleat_UNIQUE` (`IdEmpleat` ASC) VISIBLE,
  INDEX `fk_empleats_botiga_id_idx` (`IdBotiga` ASC) VISIBLE,
  INDEX `IdRepartidor` (`IdRepartidor` ASC) VISIBLE,
  CONSTRAINT `fk_empleats_botiga_id`
    FOREIGN KEY (`IdBotiga`)
    REFERENCES `pizzeria`.`botiga` (`Codi_postal`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizzeria`.`productes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`productes` (
  `IdProducte` SMALLINT NOT NULL AUTO_INCREMENT,
  `Pizza` TINYINT NULL DEFAULT NULL,
  `IdCategoriaPizza` SMALLINT NULL DEFAULT NULL,
  `Hamburguesa` TINYINT NULL DEFAULT NULL,
  `Beguda` TINYINT NULL DEFAULT NULL,
  `Nom` VARCHAR(45) NOT NULL,
  `Descripcio` TEXT NULL DEFAULT NULL,
  `Imatge` LONGBLOB NOT NULL,
  `Preu` SMALLINT NOT NULL,
  PRIMARY KEY (`IdProducte`),
  UNIQUE INDEX `IdProducte_UNIQUE` (`IdProducte` ASC) VISIBLE,
  INDEX `IdCategoriaPizzes` (`IdCategoriaPizza` ASC) VISIBLE,
  CONSTRAINT `fk_productes_categoria_pizzes_id`
    FOREIGN KEY (`IdCategoriaPizza`)
    REFERENCES `pizzeria`.`categoria_pizzes` (`IdCategoriaPizza`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizzeria`.`comanda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`comanda` (
  `IdComanda` SMALLINT NOT NULL AUTO_INCREMENT,
  `IdClient` SMALLINT NOT NULL,
  `IdBotiga` SMALLINT NOT NULL,
  `Data_Hora_Comanda` DATETIME NOT NULL,
  `Domicili` TINYINT NOT NULL,
  `Botiga` TINYINT NOT NULL,
  `IdRepartidor` SMALLINT NULL DEFAULT NULL,
  `Quantitat_Productes` VARCHAR(45) NOT NULL,
  `PreuTotal` SMALLINT NOT NULL,
  `Data_Hora_Domicili` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`IdComanda`),
  UNIQUE INDEX `IdComanda_UNIQUE` (`IdComanda` ASC) VISIBLE,
  INDEX `fk_comanda_botiga_id_idx` (`IdBotiga` ASC) VISIBLE,
  INDEX `fk_comanda_clients_id_idx` (`IdClient` ASC) VISIBLE,
  INDEX `IdRepartidor` (`IdRepartidor` ASC) VISIBLE,
  CONSTRAINT `fk_comanda_botiga_id`
    FOREIGN KEY (`IdBotiga`)
    REFERENCES `pizzeria`.`botiga` (`IdBotiga`),
  CONSTRAINT `fk_comanda_clients_id`
    FOREIGN KEY (`IdClient`)
    REFERENCES `pizzeria`.`clients` (`IdClient`),
  CONSTRAINT `fk_comanda_empleats_idr`
    FOREIGN KEY (`IdRepartidor`)
    REFERENCES `pizzeria`.`empleats` (`IdRepartidor`),
  CONSTRAINT `fk_comanda_productes_id`
    FOREIGN KEY (`IdComanda`)
    REFERENCES `pizzeria`.`productes` (`IdProducte`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
