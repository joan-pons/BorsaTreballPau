-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema borsa
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `borsa` ;

-- -----------------------------------------------------
-- Schema borsa
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `borsa` ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`user` ;

CREATE TABLE IF NOT EXISTS `mydb`.`user` (
  `username` (16) NOT NULL,
  `email` (255) NULL,
  `password` (32) NOT NULL,
  `create_time`  NULL DEFAULT CURRENT_TIMESTAMP);


-- -----------------------------------------------------
-- Table `mydb`.`user_1`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`user_1` ;

CREATE TABLE IF NOT EXISTS `mydb`.`user_1` (
  `username` (16) NOT NULL,
  `email` (255) NULL,
  `password` (32) NOT NULL,
  `create_time`  NULL DEFAULT CURRENT_TIMESTAMP);

USE `borsa` ;

-- -----------------------------------------------------
-- Table `borsa`.`Alumne`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `borsa`.`Alumne` ;

CREATE TABLE IF NOT EXISTS `borsa`.`Alumne` (
  `idAlu` INT NOT NULL AUTO_INCREMENT,
  `Nom` VARCHAR(45) NOT NULL,
  `Llinatges` VARCHAR(45) NOT NULL,
  `Adreca` VARCHAR(100) NULL,
  `CodiPostal` CHAR(5) NULL,
  `Localitat` VARCHAR(45) NULL,
  `Provincia` VARCHAR(45) NULL,
  `Telefon` CHAR(9) NULL,
  `Email` VARCHAR(75) NULL,
  `Actiu` TINYINT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`idAlu`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `borsa`.`Empreses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `borsa`.`Empreses` ;

CREATE TABLE IF NOT EXISTS `borsa`.`Empreses` (
  `idEmpresa` INT NOT NULL AUTO_INCREMENT,
  `Nom` VARCHAR(45) NOT NULL,
  `Adreca` VARCHAR(100) NULL,
  `CodiPostal` CHAR(5) NULL,
  `Localitat` VARCHAR(45) NULL,
  `Provincia` VARCHAR(45) NULL,
  `Telefon` CHAR(9) NULL,
  `email` VARCHAR(75) NULL,
  `Activa` TINYINT(1) NULL DEFAULT 1,
  PRIMARY KEY (`idEmpresa`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `borsa`.`Contactes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `borsa`.`Contactes` ;

CREATE TABLE IF NOT EXISTS `borsa`.`Contactes` (
  `idContacte` INT NULL AUTO_INCREMENT,
  `Nom` VARCHAR(45) NOT NULL,
  `Llinatges` VARCHAR(45) NOT NULL,
  `Telefon` CHAR(9) NULL,
  `email` VARCHAR(75) NULL,
  `Empresa_idEmpresa` INT NOT NULL,
  PRIMARY KEY (`idContacte`, `Empresa_idEmpresa`),
  CONSTRAINT `fk_Contacte_Empresa`
    FOREIGN KEY (`Empresa_idEmpresa`)
    REFERENCES `borsa`.`Empreses` (`idEmpresa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Contacte_Empresa_idx` ON `borsa`.`Contactes` (`Empresa_idEmpresa` ASC);


-- -----------------------------------------------------
-- Table `borsa`.`Idiomes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `borsa`.`Idiomes` ;

CREATE TABLE IF NOT EXISTS `borsa`.`Idiomes` (
  `idIdiomes` INT NULL AUTO_INCREMENT,
  `Idioma` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idIdiomes`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `borsa`.`NIvellsIdioma`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `borsa`.`NIvellsIdioma` ;

CREATE TABLE IF NOT EXISTS `borsa`.`NIvellsIdioma` (
  `idNIvellsIdioma` INT NULL AUTO_INCREMENT,
  `Nivell` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idNIvellsIdioma`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `borsa`.`Alumne_has_Idiomes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `borsa`.`Alumne_has_Idiomes` ;

CREATE TABLE IF NOT EXISTS `borsa`.`Alumne_has_Idiomes` (
  `Alumne_idAlu` INT NOT NULL,
  `Idiomes_idIdiomes` INT NOT NULL,
  `NIvellsIdioma_idNIvellsIdioma` INT NOT NULL,
  PRIMARY KEY (`Alumne_idAlu`, `Idiomes_idIdiomes`),
  CONSTRAINT `fk_Alumne_has_Idiomes_Alumne1`
    FOREIGN KEY (`Alumne_idAlu`)
    REFERENCES `borsa`.`Alumne` (`idAlu`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Alumne_has_Idiomes_Idiomes1`
    FOREIGN KEY (`Idiomes_idIdiomes`)
    REFERENCES `borsa`.`Idiomes` (`idIdiomes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Alumne_has_Idiomes_NIvellsIdioma1`
    FOREIGN KEY (`NIvellsIdioma_idNIvellsIdioma`)
    REFERENCES `borsa`.`NIvellsIdioma` (`idNIvellsIdioma`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Alumne_has_Idiomes_Idiomes1_idx` ON `borsa`.`Alumne_has_Idiomes` (`Idiomes_idIdiomes` ASC);

CREATE INDEX `fk_Alumne_has_Idiomes_Alumne1_idx` ON `borsa`.`Alumne_has_Idiomes` (`Alumne_idAlu` ASC);

CREATE INDEX `fk_Alumne_has_Idiomes_NIvellsIdioma1_idx` ON `borsa`.`Alumne_has_Idiomes` (`NIvellsIdioma_idNIvellsIdioma` ASC);


-- -----------------------------------------------------
-- Table `borsa`.`Estudis`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `borsa`.`Estudis` ;

CREATE TABLE IF NOT EXISTS `borsa`.`Estudis` (
  `Codi` CHAR(7) NOT NULL,
  `Nom` VARCHAR(150) NULL,
  PRIMARY KEY (`Codi`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `borsa`.`Alumne_has_Estudis`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `borsa`.`Alumne_has_Estudis` ;

CREATE TABLE IF NOT EXISTS `borsa`.`Alumne_has_Estudis` (
  `Alumne_idAlu` INT NOT NULL,
  `Estudis_Codi` CHAR(7) NOT NULL,
  PRIMARY KEY (`Alumne_idAlu`, `Estudis_Codi`),
  CONSTRAINT `fk_Alumne_has_Estudis_Alumne1`
    FOREIGN KEY (`Alumne_idAlu`)
    REFERENCES `borsa`.`Alumne` (`idAlu`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Alumne_has_Estudis_Estudis1`
    FOREIGN KEY (`Estudis_Codi`)
    REFERENCES `borsa`.`Estudis` (`Codi`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Alumne_has_Estudis_Estudis1_idx` ON `borsa`.`Alumne_has_Estudis` (`Estudis_Codi` ASC);

CREATE INDEX `fk_Alumne_has_Estudis_Alumne1_idx` ON `borsa`.`Alumne_has_Estudis` (`Alumne_idAlu` ASC);

SET SQL_MODE = '';
GRANT USAGE ON *.* TO usuariWeb;
 DROP USER usuariWeb;
SET SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';
CREATE USER 'usuariWeb' IDENTIFIED BY 'usuariWeb';


GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE `borsa`.* TO 'usuariWeb';
GRANT EXECUTE ON ROUTINE `borsa`.* TO 'usuariWeb';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
