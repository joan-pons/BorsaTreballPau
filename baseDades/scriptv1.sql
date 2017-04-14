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
CREATE SCHEMA IF NOT EXISTS `borsa` ;
USE `borsa` ;

-- -----------------------------------------------------
-- Table `borsa`.`Alumnes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `borsa`.`Alumnes` ;

CREATE TABLE IF NOT EXISTS `borsa`.`Alumnes` (
  `idAlumne` INT NOT NULL AUTO_INCREMENT,
  `Nom` VARCHAR(45) NOT NULL,
  `Llinatges` VARCHAR(45) NOT NULL,
  `Adreca` VARCHAR(100) NULL,
  `CodiPostal` CHAR(5) NULL,
  `Localitat` VARCHAR(45) NULL,
  `Provincia` VARCHAR(45) NULL,
  `Telefon` CHAR(9) NULL,
  `Email` VARCHAR(75) NOT NULL,
  `Actiu` TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`idAlumne`))
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
  `email` VARCHAR(75) NOT NULL,
  `Activa` TINYINT(1) NOT NULL DEFAULT 0,
  `Validada` TINYINT(1) NOT NULL DEFAULT 0,
  `DataAlta` DATE NULL,
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
  `email` VARCHAR(75) NULL,
  `Carrec` VARCHAR(75) NULL,
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
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `borsa`.`Alumne_has_Estudis`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `borsa`.`Alumne_has_Estudis` ;

CREATE TABLE IF NOT EXISTS `borsa`.`Alumne_has_Estudis` (
  `Alumne_idAlu` INT NOT NULL,
  `Estudis_Codi` CHAR(7) NOT NULL,
  `any` INT NULL,
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
-- Table `borsa`.`Ofertes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `borsa`.`Ofertes` ;

CREATE TABLE IF NOT EXISTS `borsa`.`Ofertes` (
  `idOferta` INT NOT NULL,
  `Titol` VARCHAR(50) NOT NULL,
  `Descripció` TEXT NOT NULL,
  `DataPublicació` DATE NOT NULL,
  `DataFinal` DATE NOT NULL,
  `Empreses_idEmpresa` INT NOT NULL,
  PRIMARY KEY (`idOferta`, `Empreses_idEmpresa`),
  CONSTRAINT `fk_Ofertes_Empreses1`
    FOREIGN KEY (`Empreses_idEmpresa`)
    REFERENCES `borsa`.`Empreses` (`idEmpresa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Ofertes_Empreses1_idx` ON `borsa`.`Ofertes` (`Empreses_idEmpresa` ASC);


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
    FOREIGN KEY (`Contactes_idContacte` , `Contactes_Empresa_idEmpresa`)
    REFERENCES `borsa`.`Contactes` (`idContacte` , `Empresa_idEmpresa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Ofertes_has_Contactes_Contactes1_idx` ON `borsa`.`Ofertes_has_Contactes` (`Contactes_idContacte` ASC, `Contactes_Empresa_idEmpresa` ASC);

CREATE INDEX `fk_Ofertes_has_Contactes_Ofertes1_idx` ON `borsa`.`Ofertes_has_Contactes` (`Ofertes_idOferta` ASC);


-- -----------------------------------------------------
-- Table `borsa`.`usuaris`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `borsa`.`usuaris` ;

CREATE TABLE IF NOT EXISTS `borsa`.`usuaris` (
  `idusuari` INT NOT NULL AUTO_INCREMENT,
  `nomUsuari` VARCHAR(75) NOT NULL,
  `contrasenya` VARCHAR(75) NOT NULL,
  PRIMARY KEY (`idusuari`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `nomUsuari_UNIQUE` ON `borsa`.`usuaris` (`nomUsuari` ASC);


-- -----------------------------------------------------
-- Table `borsa`.`rols`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `borsa`.`rols` ;

CREATE TABLE IF NOT EXISTS `borsa`.`rols` (
  `idrol` INT NOT NULL,
  `nomRol` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idrol`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `borsa`.`usuaris_has_rols`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `borsa`.`usuaris_has_rols` ;

CREATE TABLE IF NOT EXISTS `borsa`.`usuaris_has_rols` (
  `usuaris_idusuari` INT NOT NULL,
  `rols_idrol` INT NOT NULL,
  PRIMARY KEY (`usuaris_idusuari`, `rols_idrol`),
  CONSTRAINT `fk_usuaris_has_rols_usuaris1`
    FOREIGN KEY (`usuaris_idusuari`)
    REFERENCES `borsa`.`usuaris` (`idusuari`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuaris_has_rols_rols1`
    FOREIGN KEY (`rols_idrol`)
    REFERENCES `borsa`.`rols` (`idrol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_usuaris_has_rols_rols1_idx` ON `borsa`.`usuaris_has_rols` (`rols_idrol` ASC);

CREATE INDEX `fk_usuaris_has_rols_usuaris1_idx` ON `borsa`.`usuaris_has_rols` (`usuaris_idusuari` ASC);


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
USE `borsa`;

DELIMITER $$

USE `borsa`$$
DROP TRIGGER IF EXISTS `borsa`.`Alumnes_AFTER_UPDATE` $$
USE `borsa`$$
CREATE DEFINER = CURRENT_USER TRIGGER `borsa`.`Alumnes_AFTER_UPDATE` AFTER UPDATE ON `Alumnes` FOR EACH ROW
BEGIN
if NEW.email <=> OLD.email THEN
update usuaris set nomUsuari=NEW.email where nomUsuari=OLD.email;
end if;
END$$


USE `borsa`$$
DROP TRIGGER IF EXISTS `borsa`.`Alumnes_AFTER_DELETE` $$
USE `borsa`$$
CREATE DEFINER = CURRENT_USER TRIGGER `borsa`.`Alumnes_AFTER_DELETE` AFTER DELETE ON `Alumnes` FOR EACH ROW
BEGIN
DECLARE id INT;
 set id=(select idUsuari from usuaris where nomUsuari=OLD.email);
 delete from usuaris_has_rols where usuaris_idUsuari=id;
 delete from usuaris where idUsuari=id;
END$$


USE `borsa`$$
DROP TRIGGER IF EXISTS `borsa`.`Empreses_AFTER_INSERT` $$
USE `borsa`$$
CREATE DEFINER = CURRENT_USER TRIGGER `borsa`.`Empreses_AFTER_INSERT` AFTER INSERT ON `Empreses` FOR EACH ROW
BEGIN
insert into usuaris(nomUsuari,contrasenya) values(NEW.email,substring(md5(rand()),-8));
END$$


USE `borsa`$$
DROP TRIGGER IF EXISTS `borsa`.`Empreses_AFTER_UPDATE` $$
USE `borsa`$$
CREATE DEFINER = CURRENT_USER TRIGGER `borsa`.`Empreses_AFTER_UPDATE` AFTER UPDATE ON `Empreses` FOR EACH ROW
BEGIN
if NEW.email <=> OLD.email THEN
update usuaris set nomUsuari=NEW.email where nomUsuari=OLD.email;
end if;
END$$


USE `borsa`$$
DROP TRIGGER IF EXISTS `borsa`.`Empreses_AFTER_DELETE` $$
USE `borsa`$$
CREATE DEFINER = CURRENT_USER TRIGGER `borsa`.`Empreses_AFTER_DELETE` AFTER DELETE ON `Empreses` FOR EACH ROW
BEGIN
DECLARE id INT;
 set id=(select idUsuari from usuaris where nomUsuari=OLD.email);
 delete from usuaris_has_rols where usuaris_idUsuari=id;
 delete from usuaris where idUsuari=id;
END$$


DELIMITER ;
