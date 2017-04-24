-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema borsa
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `borsa` ;

-- -----------------------------------------------------
-- Schema borsa
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `borsa` DEFAULT CHARACTER SET utf8 ;
USE `borsa` ;

-- -----------------------------------------------------
-- Table `borsa`.`EstatLaboral`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `borsa`.`EstatLaboral` ;

CREATE TABLE IF NOT EXISTS `borsa`.`EstatLaboral` (
  `idEstatLaboral` INT NOT NULL AUTO_INCREMENT,
  `NomEstatLaboral` VARCHAR(50) NULL,
  PRIMARY KEY (`idEstatLaboral`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `borsa`.`Alumnes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `borsa`.`Alumnes` ;

CREATE TABLE IF NOT EXISTS `borsa`.`Alumnes` (
  `idAlumne` INT NOT NULL,
  `Nom` VARCHAR(45) NOT NULL,
  `Llinatges` VARCHAR(45) NOT NULL,
  `Adreca` VARCHAR(100) NULL,
  `CodiPostal` CHAR(5) NULL,
  `Localitat` VARCHAR(45) NULL,
  `Provincia` VARCHAR(45) NULL,
  `Telefon` CHAR(9) NULL,
  `Email` VARCHAR(75) NOT NULL,
  `Actiu` TINYINT(1) NOT NULL DEFAULT 0,
  `EstatLaboral_idEstatLaboral` INT NOT NULL,
  PRIMARY KEY (`idAlumne`),
  CONSTRAINT `fk_Alumnes_EstatLaboral1`
    FOREIGN KEY (`EstatLaboral_idEstatLaboral`)
    REFERENCES `borsa`.`EstatLaboral` (`idEstatLaboral`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Alumnes_EstatLaboral1_idx` ON `borsa`.`Alumnes` (`EstatLaboral_idEstatLaboral` ASC);


-- -----------------------------------------------------
-- Table `borsa`.`Empreses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `borsa`.`Empreses` ;

CREATE TABLE IF NOT EXISTS `borsa`.`Empreses` (
  `idEmpresa` INT NOT NULL AUTO_INCREMENT,
  `Nom` VARCHAR(45) NOT NULL,
  `Descripcio` TEXT NULL,
  `Adreca` VARCHAR(100) NULL,
  `CodiPostal` CHAR(5) NULL,
  `Localitat` VARCHAR(45) NULL,
  `Provincia` VARCHAR(45) NULL,
  `Telefon` CHAR(9) NULL,
  `email` VARCHAR(75) NOT NULL,
  `Activa` TINYINT(1) NOT NULL DEFAULT 0,
  `Validada` TINYINT(1) NOT NULL DEFAULT 0,
  `DataAlta` DATE NULL,
  `url` VARCHAR(100) NULL,
  PRIMARY KEY (`idEmpresa`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `email_UNIQUE` ON `borsa`.`Empreses` (`email` ASC);


-- -----------------------------------------------------
-- Table `borsa`.`Contactes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `borsa`.`Contactes` ;

CREATE TABLE IF NOT EXISTS `borsa`.`Contactes` (
  `idContacte` INT NOT NULL AUTO_INCREMENT,
  `Nom` VARCHAR(45) NOT NULL,
  `Llinatges` VARCHAR(45) NOT NULL,
  `Telefon` CHAR(9) NULL,
  `email` VARCHAR(75) NOT NULL,
  `Carrec` VARCHAR(75) NULL,
  `Empreses_idEmpresa` INT NOT NULL,
  PRIMARY KEY (`idContacte`),
  CONSTRAINT `fk_Contactes_Empreses1`
    FOREIGN KEY (`Empreses_idEmpresa`)
    REFERENCES `borsa`.`Empreses` (`idEmpresa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE UNIQUE INDEX `email_UNIQUE` ON `borsa`.`Contactes` (`email` ASC);

CREATE INDEX `fk_Contactes_Empreses1_idx` ON `borsa`.`Contactes` (`Empreses_idEmpresa` ASC);


-- -----------------------------------------------------
-- Table `borsa`.`Idiomes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `borsa`.`Idiomes` ;

CREATE TABLE IF NOT EXISTS `borsa`.`Idiomes` (
  `idIdiomes` INT NOT NULL AUTO_INCREMENT,
  `Idioma` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idIdiomes`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `borsa`.`NivellsIdioma`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `borsa`.`NivellsIdioma` ;

CREATE TABLE IF NOT EXISTS `borsa`.`NivellsIdioma` (
  `idNIvellsIdioma` INT NOT NULL AUTO_INCREMENT,
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
    REFERENCES `borsa`.`Alumnes` (`idAlumne`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Alumne_has_Idiomes_Idiomes1`
    FOREIGN KEY (`Idiomes_idIdiomes`)
    REFERENCES `borsa`.`Idiomes` (`idIdiomes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Alumne_has_Idiomes_NIvellsIdioma1`
    FOREIGN KEY (`NIvellsIdioma_idNIvellsIdioma`)
    REFERENCES `borsa`.`NivellsIdioma` (`idNIvellsIdioma`)
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
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `borsa`.`Alumne_has_Estudis`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `borsa`.`Alumne_has_Estudis` ;

CREATE TABLE IF NOT EXISTS `borsa`.`Alumne_has_Estudis` (
  `Alumne_idAlu` INT NOT NULL,
  `Estudis_Codi` CHAR(7) NOT NULL,
  `any` INT NOT NULL,
  `nota` INT NOT NULL,
  PRIMARY KEY (`Alumne_idAlu`, `Estudis_Codi`),
  CONSTRAINT `fk_Alumne_has_Estudis_Alumne1`
    FOREIGN KEY (`Alumne_idAlu`)
    REFERENCES `borsa`.`Alumnes` (`idAlumne`)
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


-- -----------------------------------------------------
-- Table `borsa`.`Professors`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `borsa`.`Professors` ;

CREATE TABLE IF NOT EXISTS `borsa`.`Professors` (
  `idProfessor` INT NOT NULL AUTO_INCREMENT,
  `Nom` VARCHAR(45) NOT NULL,
  `Llinatges` VARCHAR(45) NOT NULL,
  `Telefon` CHAR(9) NULL,
  `Email` VARCHAR(75) NOT NULL,
  `Actiu` TINYINT(1) NOT NULL DEFAULT 0,
  `Validat` TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`idProfessor`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `Email_UNIQUE` ON `borsa`.`Professors` (`Email` ASC);


-- -----------------------------------------------------
-- Table `borsa`.`Ofertes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `borsa`.`Ofertes` ;

CREATE TABLE IF NOT EXISTS `borsa`.`Ofertes` (
  `idOferta` INT NOT NULL,
  `Titol` VARCHAR(50) NOT NULL,
  `Descripció` TEXT NOT NULL,
  `DataPublicació` DATE NOT NULL,
  `DataFinal` DATE NOT NULL,
  `Validada` TINYINT(1) NOT NULL DEFAULT 0,
  `ProfessorValidada` INT NULL,
  `Empreses_idEmpresa` INT NOT NULL,
  `TipusContracte` VARCHAR(45) NULL,
  `Horari` VARCHAR(60) NULL,
  `Localitat` VARCHAR(60) NULL,
  PRIMARY KEY (`idOferta`, `Empreses_idEmpresa`),
  CONSTRAINT `fk_Ofertes_Empreses1`
    FOREIGN KEY (`Empreses_idEmpresa`)
    REFERENCES `borsa`.`Empreses` (`idEmpresa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ofertes_Professors1`
    FOREIGN KEY (`ProfessorValidada`)
    REFERENCES `borsa`.`Professors` (`idProfessor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Ofertes_Empreses1_idx` ON `borsa`.`Ofertes` (`Empreses_idEmpresa` ASC);

CREATE INDEX `fk_Ofertes_Professors1_idx` ON `borsa`.`Ofertes` (`ProfessorValidada` ASC);


-- -----------------------------------------------------
-- Table `borsa`.`Ofertes_has_Estudis`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `borsa`.`Ofertes_has_Estudis` ;

CREATE TABLE IF NOT EXISTS `borsa`.`Ofertes_has_Estudis` (
  `Ofertes_idOferta` INT NOT NULL,
  `Estudis_Codi` CHAR(7) NOT NULL,
  PRIMARY KEY (`Ofertes_idOferta`, `Estudis_Codi`),
  CONSTRAINT `fk_Ofertes_has_Estudis_Ofertes1`
    FOREIGN KEY (`Ofertes_idOferta`)
    REFERENCES `borsa`.`Ofertes` (`idOferta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ofertes_has_Estudis_Estudis1`
    FOREIGN KEY (`Estudis_Codi`)
    REFERENCES `borsa`.`Estudis` (`Codi`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Ofertes_has_Estudis_Estudis1_idx` ON `borsa`.`Ofertes_has_Estudis` (`Estudis_Codi` ASC);

CREATE INDEX `fk_Ofertes_has_Estudis_Ofertes1_idx` ON `borsa`.`Ofertes_has_Estudis` (`Ofertes_idOferta` ASC);


-- -----------------------------------------------------
-- Table `borsa`.`Ofertes_enviada_Alumnes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `borsa`.`Ofertes_enviada_Alumnes` ;

CREATE TABLE IF NOT EXISTS `borsa`.`Ofertes_enviada_Alumnes` (
  `Ofertes_idOferta` INT NOT NULL,
  `Alumnes_idAlumne` INT NOT NULL,
  PRIMARY KEY (`Ofertes_idOferta`, `Alumnes_idAlumne`),
  CONSTRAINT `fk_Ofertes_has_Alumnes_Ofertes1`
    FOREIGN KEY (`Ofertes_idOferta`)
    REFERENCES `borsa`.`Ofertes` (`idOferta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ofertes_has_Alumnes_Alumnes1`
    FOREIGN KEY (`Alumnes_idAlumne`)
    REFERENCES `borsa`.`Alumnes` (`idAlumne`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Ofertes_has_Alumnes_Alumnes1_idx` ON `borsa`.`Ofertes_enviada_Alumnes` (`Alumnes_idAlumne` ASC);

CREATE INDEX `fk_Ofertes_has_Alumnes_Ofertes1_idx` ON `borsa`.`Ofertes_enviada_Alumnes` (`Ofertes_idOferta` ASC);


-- -----------------------------------------------------
-- Table `borsa`.`Ofertes_has_Contactes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `borsa`.`Ofertes_has_Contactes` ;

CREATE TABLE IF NOT EXISTS `borsa`.`Ofertes_has_Contactes` (
  `Ofertes_idOferta` INT NOT NULL,
  `Contactes_idContacte` INT NOT NULL,
  `Contactes_Empresa_idEmpresa` INT NOT NULL,
  PRIMARY KEY (`Ofertes_idOferta`, `Contactes_idContacte`, `Contactes_Empresa_idEmpresa`),
  CONSTRAINT `fk_Ofertes_has_Contactes_Ofertes1`
    FOREIGN KEY (`Ofertes_idOferta`)
    REFERENCES `borsa`.`Ofertes` (`idOferta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ofertes_has_Contactes_Contactes1`
    FOREIGN KEY (`Contactes_idContacte`)
    REFERENCES `borsa`.`Contactes` (`idContacte`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Ofertes_has_Contactes_Contactes1_idx` ON `borsa`.`Ofertes_has_Contactes` (`Contactes_idContacte` ASC);

CREATE INDEX `fk_Ofertes_has_Contactes_Ofertes1_idx` ON `borsa`.`Ofertes_has_Contactes` (`Ofertes_idOferta` ASC);


-- -----------------------------------------------------
-- Table `borsa`.`TipusUsuaris`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `borsa`.`TipusUsuaris` ;

CREATE TABLE IF NOT EXISTS `borsa`.`TipusUsuaris` (
  `idTipusUsuaris` INT NOT NULL,
  `nomTipusUsuari` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idTipusUsuaris`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `borsa`.`Usuaris`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `borsa`.`Usuaris` ;

CREATE TABLE IF NOT EXISTS `borsa`.`Usuaris` (
  `idusuari` INT NOT NULL AUTO_INCREMENT,
  `tipusUsuari` INT NOT NULL,
  `nomUsuari` VARCHAR(75) NOT NULL,
  `contrasenya` VARCHAR(75) NOT NULL,
  PRIMARY KEY (`idusuari`),
  CONSTRAINT `fk_usuaris_TipusUsuaris1`
    FOREIGN KEY (`tipusUsuari`)
    REFERENCES `borsa`.`TipusUsuaris` (`idTipusUsuaris`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE UNIQUE INDEX `nomUsuari_UNIQUE` ON `borsa`.`Usuaris` (`nomUsuari` ASC);

CREATE INDEX `fk_usuaris_TipusUsuaris1_idx` ON `borsa`.`Usuaris` (`tipusUsuari` ASC);


-- -----------------------------------------------------
-- Table `borsa`.`Rols`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `borsa`.`Rols` ;

CREATE TABLE IF NOT EXISTS `borsa`.`Rols` (
  `idrol` INT NOT NULL,
  `nomRol` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idrol`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `borsa`.`Idiomes_has_Ofertes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `borsa`.`Idiomes_has_Ofertes` ;

CREATE TABLE IF NOT EXISTS `borsa`.`Idiomes_has_Ofertes` (
  `Idiomes_idIdiomes` INT NOT NULL,
  `Ofertes_idOferta` INT NOT NULL,
  `Ofertes_Empreses_idEmpresa` INT NOT NULL,
  `NivellsIdioma_idNIvellsIdioma` INT NOT NULL,
  PRIMARY KEY (`Idiomes_idIdiomes`, `Ofertes_idOferta`, `Ofertes_Empreses_idEmpresa`),
  CONSTRAINT `fk_Idiomes_has_Ofertes_Idiomes1`
    FOREIGN KEY (`Idiomes_idIdiomes`)
    REFERENCES `borsa`.`Idiomes` (`idIdiomes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Idiomes_has_Ofertes_Ofertes1`
    FOREIGN KEY (`Ofertes_idOferta` , `Ofertes_Empreses_idEmpresa`)
    REFERENCES `borsa`.`Ofertes` (`idOferta` , `Empreses_idEmpresa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Idiomes_has_Ofertes_NivellsIdioma1`
    FOREIGN KEY (`NivellsIdioma_idNIvellsIdioma`)
    REFERENCES `borsa`.`NivellsIdioma` (`idNIvellsIdioma`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Idiomes_has_Ofertes_Ofertes1_idx` ON `borsa`.`Idiomes_has_Ofertes` (`Ofertes_idOferta` ASC, `Ofertes_Empreses_idEmpresa` ASC);

CREATE INDEX `fk_Idiomes_has_Ofertes_Idiomes1_idx` ON `borsa`.`Idiomes_has_Ofertes` (`Idiomes_idIdiomes` ASC);

CREATE INDEX `fk_Idiomes_has_Ofertes_NivellsIdioma1_idx` ON `borsa`.`Idiomes_has_Ofertes` (`NivellsIdioma_idNIvellsIdioma` ASC);


-- -----------------------------------------------------
-- Table `borsa`.`Estudis_has_Responsables`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `borsa`.`Estudis_has_Responsables` ;

CREATE TABLE IF NOT EXISTS `borsa`.`Estudis_has_Responsables` (
  `Estudis_Codi` CHAR(7) NOT NULL,
  `Professors_idProfessor` INT NOT NULL,
  PRIMARY KEY (`Estudis_Codi`, `Professors_idProfessor`),
  CONSTRAINT `fk_Estudis_has_Professors_Estudis1`
    FOREIGN KEY (`Estudis_Codi`)
    REFERENCES `borsa`.`Estudis` (`Codi`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Estudis_has_Professors_Professors1`
    FOREIGN KEY (`Professors_idProfessor`)
    REFERENCES `borsa`.`Professors` (`idProfessor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Estudis_has_Professors_Professors1_idx` ON `borsa`.`Estudis_has_Responsables` (`Professors_idProfessor` ASC);

CREATE INDEX `fk_Estudis_has_Professors_Estudis1_idx` ON `borsa`.`Estudis_has_Responsables` (`Estudis_Codi` ASC);


-- -----------------------------------------------------
-- Table `borsa`.`Illes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `borsa`.`Illes` ;

CREATE TABLE IF NOT EXISTS `borsa`.`Illes` (
  `idIlla` VARCHAR(3) NOT NULL,
  `nomIlla` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idIlla`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `borsa`.`Localitats`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `borsa`.`Localitats` ;

CREATE TABLE IF NOT EXISTS `borsa`.`Localitats` (
  `idLocalitat` VARCHAR(9) NOT NULL,
  `nomLocalitat` VARCHAR(100) NOT NULL,
  `idIlla` VARCHAR(3) NOT NULL,
  PRIMARY KEY (`idLocalitat`),
  CONSTRAINT `fk_Localitats_Illes1`
    FOREIGN KEY (`idIlla`)
    REFERENCES `borsa`.`Illes` (`idIlla`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Localitats_Illes1_idx` ON `borsa`.`Localitats` (`idIlla` ASC);


-- -----------------------------------------------------
-- Table `borsa`.`Usuaris_has_Rols`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `borsa`.`Usuaris_has_Rols` ;

CREATE TABLE IF NOT EXISTS `borsa`.`Usuaris_has_Rols` (
  `Usuaris_idusuari` INT NOT NULL,
  `Rols_idrol` INT NOT NULL,
  PRIMARY KEY (`Usuaris_idusuari`, `Rols_idrol`),
  CONSTRAINT `fk_Usuaris_has_Rols_Usuaris1`
    FOREIGN KEY (`Usuaris_idusuari`)
    REFERENCES `borsa`.`Usuaris` (`idusuari`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuaris_has_Rols_Rols1`
    FOREIGN KEY (`Rols_idrol`)
    REFERENCES `borsa`.`Rols` (`idrol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Usuaris_has_Rols_Rols1_idx` ON `borsa`.`Usuaris_has_Rols` (`Rols_idrol` ASC);

CREATE INDEX `fk_Usuaris_has_Rols_Usuaris1_idx` ON `borsa`.`Usuaris_has_Rols` (`Usuaris_idusuari` ASC);

USE `borsa`;

DELIMITER $$

USE `borsa`$$
DROP TRIGGER IF EXISTS `borsa`.`Alumnes_AFTER_INSERT` $$
USE `borsa`$$
CREATE DEFINER = CURRENT_USER TRIGGER `borsa`.`Alumnes_AFTER_INSERT` AFTER INSERT ON `Alumnes` FOR EACH ROW
BEGIN
   INSERT INTO Usuaris
   (tipusUsuari,nomUsuari,contrasenya)
   VALUES
   (30,NEW.email,substring(md5(rand()),-8));
END$$


USE `borsa`$$
DROP TRIGGER IF EXISTS `borsa`.`Alumnes_AFTER_UPDATE` $$
USE `borsa`$$
CREATE DEFINER = CURRENT_USER TRIGGER `borsa`.`Alumnes_AFTER_UPDATE` AFTER UPDATE ON `Alumnes` FOR EACH ROW
BEGIN
if NEW.email <=> OLD.email THEN
update Usuaris set nomUsuari=NEW.email where nomUsuari=OLD.email;
end if;
END$$


USE `borsa`$$
DROP TRIGGER IF EXISTS `borsa`.`Alumnes_AFTER_DELETE` $$
USE `borsa`$$
CREATE DEFINER = CURRENT_USER TRIGGER `borsa`.`Alumnes_AFTER_DELETE` AFTER DELETE ON `Alumnes` FOR EACH ROW
BEGIN
DECLARE id INT;
 set id=(select idUsuari from usuaris where nomUsuari=OLD.email);
 delete from Usuaris_has_Rols where usuaris_idUsuari=id;
 delete from Usuaris where idUsuari=id;
END$$


USE `borsa`$$
DROP TRIGGER IF EXISTS `borsa`.`Empreses_AFTER_INSERT` $$
USE `borsa`$$
CREATE DEFINER = CURRENT_USER TRIGGER `borsa`.`Empreses_AFTER_INSERT` AFTER INSERT ON `Empreses` FOR EACH ROW
BEGIN
   INSERT INTO Usuaris
   (tipusUsuari,nomUsuari,contrasenya)
   VALUES
   (20,NEW.email,substring(md5(rand()),-8));
END$$


USE `borsa`$$
DROP TRIGGER IF EXISTS `borsa`.`Empreses_AFTER_UPDATE` $$
USE `borsa`$$
CREATE DEFINER = CURRENT_USER TRIGGER `borsa`.`Empreses_AFTER_UPDATE` AFTER UPDATE ON `Empreses` FOR EACH ROW
BEGIN
if NEW.email <=> OLD.email THEN
update Usuaris set nomUsuari=NEW.email where nomUsuari=OLD.email;
end if;
END$$


USE `borsa`$$
DROP TRIGGER IF EXISTS `borsa`.`Empreses_AFTER_DELETE` $$
USE `borsa`$$
CREATE DEFINER = CURRENT_USER TRIGGER `borsa`.`Empreses_AFTER_DELETE` AFTER DELETE ON `Empreses` FOR EACH ROW
BEGIN
DECLARE id INT;
 set id=(select idUsuari from usuaris where nomUsuari=OLD.email);
 delete from Usuaris_has_Rols where usuaris_idUsuari=id;
 delete from Usuaris where idUsuari=id;
END$$


USE `borsa`$$
DROP TRIGGER IF EXISTS `borsa`.`Empreses_BEFORE_INSERT` $$
USE `borsa`$$
CREATE DEFINER = CURRENT_USER TRIGGER `borsa`.`Empreses_BEFORE_INSERT` BEFORE INSERT ON `Empreses` FOR EACH ROW
BEGIN
 SET New.DataAlta=curdate();
END$$


USE `borsa`$$
DROP TRIGGER IF EXISTS `borsa`.`Professors_AFTER_INSERT` $$
USE `borsa`$$
CREATE DEFINER=`usuariWeb`@`%` TRIGGER `borsa`.`Professors_AFTER_INSERT` AFTER INSERT ON `Professors` FOR EACH ROW
BEGIN
   INSERT INTO Usuaris
   (tipusUsuari,nomUsuari,contrasenya)
   VALUES
   (10,NEW.email,substring(md5(rand()),-8));
END$$


USE `borsa`$$
DROP TRIGGER IF EXISTS `borsa`.`Professors_AFTER_UPDATE` $$
USE `borsa`$$
CREATE DEFINER = CURRENT_USER TRIGGER `borsa`.`Professors_AFTER_UPDATE` AFTER UPDATE ON `Professors` FOR EACH ROW
BEGIN
if NEW.email <=> OLD.email THEN
update Usuaris set nomUsuari=NEW.email where nomUsuari=OLD.email;
end if;
END$$


USE `borsa`$$
DROP TRIGGER IF EXISTS `borsa`.`Professors_AFTER_DELETE` $$
USE `borsa`$$
CREATE DEFINER = CURRENT_USER TRIGGER `borsa`.`Professors_AFTER_DELETE` AFTER DELETE ON `Professors` FOR EACH ROW
BEGIN
DECLARE id INT;
DECLARE tipus INT;
 set id=(select idUsuari from usuaris where nomUsuari=OLD.email);
 set tipus=(select tipusUsuari from usuaris where nomUsuari=OLD.email);
 delete from Usuaris_has_Rols where usuaris_idUsuari=id and usuaris_tipus_usuari=tipus;
 delete from Usuaris where idUsuari=id;
END$$


USE `borsa`$$
DROP TRIGGER IF EXISTS `borsa`.`usuaris_AFTER_INSERT` $$
USE `borsa`$$
CREATE DEFINER = CURRENT_USER TRIGGER `borsa`.`usuaris_AFTER_INSERT` AFTER INSERT ON `Usuaris` FOR EACH ROW
BEGIN
INSERT INTO Usuaris_has_Rols
   (usuaris_idusuari, rols_idrol)
   VALUES
   (New.idusuari,New.tipusUsuari);
END$$


DELIMITER ;
SET SQL_MODE = '';
GRANT USAGE ON *.* TO usuariWeb;
 DROP USER usuariWeb;
SET SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';
CREATE USER 'usuariWeb' IDENTIFIED BY 'seCret_16';

GRANT SELECT, INSERT, TRIGGER ON TABLE `borsa`.* TO 'usuariWeb';
GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE `borsa`.* TO 'usuariWeb';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;



-- -----------------------------------------------------
-- Data for table `borsa`.`TipusUsuaris`
-- -----------------------------------------------------
START TRANSACTION;
USE `borsa`;
INSERT INTO `borsa`.`TipusUsuaris` (`idTipusUsuaris`, `nomTipusUsuari`) VALUES (10, 'Professor');
INSERT INTO `borsa`.`TipusUsuaris` (`idTipusUsuaris`, `nomTipusUsuari`) VALUES (20, 'Empresa');
INSERT INTO `borsa`.`TipusUsuaris` (`idTipusUsuaris`, `nomTipusUsuari`) VALUES (30, 'Estudiant');

COMMIT;


-- -----------------------------------------------------
-- Data for table `borsa`.`Rols`
-- -----------------------------------------------------
START TRANSACTION;
USE `borsa`;
INSERT INTO `borsa`.`Rols` (`idrol`, `nomRol`) VALUES (30, 'Alumne');
INSERT INTO `borsa`.`Rols` (`idrol`, `nomRol`) VALUES (20, 'Empresa');
INSERT INTO `borsa`.`Rols` (`idrol`, `nomRol`) VALUES (10, 'Professor');
INSERT INTO `borsa`.`Rols` (`idrol`, `nomRol`) VALUES (40, 'Administrador');

COMMIT;

-- -----------------------------------------------------
-- Data for table `borsa`.`EstatLaboral`
-- -----------------------------------------------------
START TRANSACTION;
USE `borsa`;
INSERT INTO `borsa`.`EstatLaboral` (`idEstatLaboral`, `NomEstatLaboral`) VALUES (DEFAULT, 'Estudiant');
INSERT INTO `borsa`.`EstatLaboral` (`idEstatLaboral`, `NomEstatLaboral`) VALUES (DEFAULT, 'Aturat');
INSERT INTO `borsa`.`EstatLaboral` (`idEstatLaboral`, `NomEstatLaboral`) VALUES (DEFAULT, 'Treballant');

COMMIT;


-- -----------------------------------------------------
-- Data for table `borsa`.`Empreses`
-- -----------------------------------------------------
START TRANSACTION;
USE `borsa`;
INSERT INTO `borsa`.`Empreses` (`idEmpresa`, `Nom`, `Descripcio`, `Adreca`, `CodiPostal`, `Localitat`, `Provincia`, `Telefon`, `email`, `Activa`, `Validada`, `DataAlta`, `url`) VALUES (DEFAULT, 'Sa Meva', '<h1>Sa Meva</h1><p>Empresa dedicada a tota casta de projectes.</p>', 'Carrer nou, 10', '07300', 'Inca', 'Balears', '971456985', 'info@sameva.cat', 0, 0, NULL, 'www.sameva.cat');
INSERT INTO `borsa`.`Empreses` (`idEmpresa`, `Nom`, `Descripcio`, `Adreca`, `CodiPostal`, `Localitat`, `Provincia`, `Telefon`, `email`, `Activa`, `Validada`, `DataAlta`, `url`) VALUES (DEFAULT, 'Nissan', '<h1>Nissan</h1><p>Idò això, una altra empresa de cotxes.</p>', 'Plaça Major 6', '07300', 'Inca', 'Balears', '654785214', 'info@nissan.jp', 0, 0, NULL, 'www.nissan.jp');
INSERT INTO `borsa`.`Empreses` (`idEmpresa`, `Nom`, `Descripcio`, `Adreca`, `CodiPostal`, `Localitat`, `Provincia`, `Telefon`, `email`, `Activa`, `Validada`, `DataAlta`, `url`) VALUES (DEFAULT, '12', '<p><br></p>', '', '', '', '', '', 'asd@asd.sd', 0, 0, NULL, '');

COMMIT;


-- -----------------------------------------------------
-- Data for table `borsa`.`Contactes`
-- -----------------------------------------------------
START TRANSACTION;
USE `borsa`;
INSERT INTO `borsa`.`Contactes` (`idContacte`, `Nom`, `Llinatges`, `Telefon`, `email`, `Carrec`, `Empreses_idEmpresa`) VALUES (DEFAULT, 'Jo', 'Mateix', '', 'jomateix@nissan.jp', NULL, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `borsa`.`Idiomes`
-- -----------------------------------------------------
START TRANSACTION;
USE `borsa`;
INSERT INTO `borsa`.`Idiomes` (`idIdiomes`, `Idioma`) VALUES (DEFAULT, 'Català');
INSERT INTO `borsa`.`Idiomes` (`idIdiomes`, `Idioma`) VALUES (DEFAULT, 'Castellà');
INSERT INTO `borsa`.`Idiomes` (`idIdiomes`, `Idioma`) VALUES (DEFAULT, 'Anglès');
INSERT INTO `borsa`.`Idiomes` (`idIdiomes`, `Idioma`) VALUES (DEFAULT, 'Alemany');
INSERT INTO `borsa`.`Idiomes` (`idIdiomes`, `Idioma`) VALUES (DEFAULT, 'Àrab');

COMMIT;


-- -----------------------------------------------------
-- Data for table `borsa`.`NivellsIdioma`
-- -----------------------------------------------------
START TRANSACTION;
USE `borsa`;
INSERT INTO `borsa`.`NivellsIdioma` (`idNIvellsIdioma`, `Nivell`) VALUES (DEFAULT, 'Gens');
INSERT INTO `borsa`.`NivellsIdioma` (`idNIvellsIdioma`, `Nivell`) VALUES (DEFAULT, 'Malament');
INSERT INTO `borsa`.`NivellsIdioma` (`idNIvellsIdioma`, `Nivell`) VALUES (DEFAULT, 'Bé');
INSERT INTO `borsa`.`NivellsIdioma` (`idNIvellsIdioma`, `Nivell`) VALUES (DEFAULT, 'Molt bé');

COMMIT;


-- -----------------------------------------------------
-- Data for table `borsa`.`Estudis`
-- -----------------------------------------------------
START TRANSACTION;
USE `borsa`;
INSERT INTO `borsa`.`Estudis` (`Codi`, `Nom`) VALUES ('IFC31', 'Grau Superior en Administració de sistemes informàtics en xarxa');
INSERT INTO `borsa`.`Estudis` (`Codi`, `Nom`) VALUES ('IFC32', 'Grau Superior en Desenvolupament d\'aplicacions multiplataforma');
INSERT INTO `borsa`.`Estudis` (`Codi`, `Nom`) VALUES ('IFC33', 'Grau Superior en Desenvolupament d\'aplicacions web');
INSERT INTO `borsa`.`Estudis` (`Codi`, `Nom`) VALUES ('IFC21', 'Grau Mitjà en Sistemes microinformàtics i xarxes ');

COMMIT;


-- -----------------------------------------------------
-- Data for table `borsa`.`Professors`
-- -----------------------------------------------------
START TRANSACTION;
USE `borsa`;
INSERT INTO `borsa`.`Professors` (`idProfessor`, `Nom`, `Llinatges`, `Telefon`, `Email`, `Actiu`, `Validat`) VALUES (DEFAULT, 'Joan', 'Pons Tugores', '666555444', 'ptj@iespaucasesnoves.cat', true, DEFAULT);
INSERT INTO `borsa`.`Professors` (`idProfessor`, `Nom`, `Llinatges`, `Telefon`, `Email`, `Actiu`, `Validat`) VALUES (DEFAULT, 'Tomeu', 'Campaner Fornés', '699855477', 'cfb@iespaucasesnoves.cat', false, DEFAULT);

COMMIT;

-- -----------------------------------------------------
-- Data for table `borsa`.`Estudis_has_Responsables`
-- -----------------------------------------------------
START TRANSACTION;
USE `borsa`;
INSERT INTO `borsa`.`Estudis_has_Responsables` (`Estudis_Codi`, `Professors_idProfessor`) VALUES ('IFC31', 2);
INSERT INTO `borsa`.`Estudis_has_Responsables` (`Estudis_Codi`, `Professors_idProfessor`) VALUES ('IFC32', 1);
INSERT INTO `borsa`.`Estudis_has_Responsables` (`Estudis_Codi`, `Professors_idProfessor`) VALUES ('IFC33', 1);
INSERT INTO `borsa`.`Estudis_has_Responsables` (`Estudis_Codi`, `Professors_idProfessor`) VALUES ('IFC21', 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `borsa`.`Illes`
-- -----------------------------------------------------
START TRANSACTION;
USE `borsa`;
INSERT INTO `borsa`.`Illes` (`idIlla`, `nomIlla`) VALUES ('071', 'Mallorca');
INSERT INTO `borsa`.`Illes` (`idIlla`, `nomIlla`) VALUES ('072', 'Menorca');
INSERT INTO `borsa`.`Illes` (`idIlla`, `nomIlla`) VALUES ('073', 'Eivissa');
INSERT INTO `borsa`.`Illes` (`idIlla`, `nomIlla`) VALUES ('074', 'Formentera');

COMMIT;


-- -----------------------------------------------------
-- Data for table `borsa`.`Localitats`
-- -----------------------------------------------------
START TRANSACTION;
USE `borsa`;
INSERT INTO `borsa`.`Localitats` (`idLocalitat`, `nomLocalitat`, `idIlla`) VALUES ('071007300', 'Inca', '071');
INSERT INTO `borsa`.`Localitats` (`idLocalitat`, `nomLocalitat`, `idIlla`) VALUES ('071007310', 'Campanet', '071');

COMMIT;

