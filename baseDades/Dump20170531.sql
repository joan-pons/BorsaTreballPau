CREATE DATABASE  IF NOT EXISTS `borsa` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `borsa`;
-- MySQL dump 10.13  Distrib 5.7.18, for Linux (x86_64)
--
-- Host: localhost    Database: borsa
-- ------------------------------------------------------
-- Server version	5.7.18-0ubuntu0.16.10.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Alumne_has_EstatLaboral`
--

DROP TABLE IF EXISTS `Alumne_has_EstatLaboral`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Alumne_has_EstatLaboral` (
  `Alumnes_idAlumne` int(11) NOT NULL,
  `EstatLaboral_idEstatLaboral` int(11) NOT NULL,
  PRIMARY KEY (`Alumnes_idAlumne`,`EstatLaboral_idEstatLaboral`),
  KEY `fk_Alumnes_has_EstatLaboral_EstatLaboral1_idx` (`EstatLaboral_idEstatLaboral`),
  KEY `fk_Alumnes_has_EstatLaboral_Alumnes1_idx` (`Alumnes_idAlumne`),
  CONSTRAINT `fk_Alumnes_has_EstatLaboral_Alumnes1` FOREIGN KEY (`Alumnes_idAlumne`) REFERENCES `Alumnes` (`idAlumne`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Alumnes_has_EstatLaboral_EstatLaboral1` FOREIGN KEY (`EstatLaboral_idEstatLaboral`) REFERENCES `EstatLaboral` (`idEstatLaboral`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Alumne_has_EstatLaboral`
--

LOCK TABLES `Alumne_has_EstatLaboral` WRITE;
/*!40000 ALTER TABLE `Alumne_has_EstatLaboral` DISABLE KEYS */;
INSERT INTO `Alumne_has_EstatLaboral` VALUES (5,1),(3,2),(5,2),(1,3),(3,3);
/*!40000 ALTER TABLE `Alumne_has_EstatLaboral` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Alumne_has_Estudis`
--

DROP TABLE IF EXISTS `Alumne_has_Estudis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Alumne_has_Estudis` (
  `Alumnes_idAlumne` int(11) NOT NULL,
  `Estudis_codi` char(7) NOT NULL,
  `any` int(11) DEFAULT NULL,
  `nota` int(11) DEFAULT NULL,
  PRIMARY KEY (`Alumnes_idAlumne`,`Estudis_codi`),
  KEY `fk_Alumnes_has_Estudis_Estudis1_idx` (`Estudis_codi`),
  KEY `fk_Alumnes_has_Estudis_Alumnes1_idx` (`Alumnes_idAlumne`),
  CONSTRAINT `fk_Alumnes_has_Estudis_Alumnes1` FOREIGN KEY (`Alumnes_idAlumne`) REFERENCES `Alumnes` (`idAlumne`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Alumnes_has_Estudis_Estudis1` FOREIGN KEY (`Estudis_codi`) REFERENCES `Estudis` (`codi`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Alumne_has_Estudis`
--

LOCK TABLES `Alumne_has_Estudis` WRITE;
/*!40000 ALTER TABLE `Alumne_has_Estudis` DISABLE KEYS */;
INSERT INTO `Alumne_has_Estudis` VALUES (1,'IFC32',2017,5),(1,'IFC33',2014,8),(2,'IFC31',2017,7),(3,'ADG32',2012,9),(3,'IFC33',2014,8),(5,'ADG32',2015,7);
/*!40000 ALTER TABLE `Alumne_has_Estudis` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Alumne_has_Idiomes`
--

DROP TABLE IF EXISTS `Alumne_has_Idiomes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Alumne_has_Idiomes` (
  `Alumne_idAlumne` int(11) NOT NULL,
  `Idiomes_idIdiomes` int(11) NOT NULL,
  `NivellsIdioma_idNivellIdioma` int(11) NOT NULL,
  PRIMARY KEY (`Alumne_idAlumne`,`Idiomes_idIdiomes`),
  KEY `fk_Alumne_has_Idiomes_Idiomes1_idx` (`Idiomes_idIdiomes`),
  KEY `fk_Alumne_has_Idiomes_Alumne1_idx` (`Alumne_idAlumne`),
  KEY `fk_Alumne_has_Idiomes_NIvellsIdioma1_idx` (`NivellsIdioma_idNivellIdioma`),
  CONSTRAINT `fk_Alumne_has_Idiomes_Alumne1` FOREIGN KEY (`Alumne_idAlumne`) REFERENCES `Alumnes` (`idAlumne`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Alumne_has_Idiomes_Idiomes1` FOREIGN KEY (`Idiomes_idIdiomes`) REFERENCES `Idiomes` (`idIdioma`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Alumne_has_Idiomes_NIvellsIdioma1` FOREIGN KEY (`NivellsIdioma_idNivellIdioma`) REFERENCES `NivellsIdioma` (`idNivellIdioma`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Alumne_has_Idiomes`
--

LOCK TABLES `Alumne_has_Idiomes` WRITE;
/*!40000 ALTER TABLE `Alumne_has_Idiomes` DISABLE KEYS */;
INSERT INTO `Alumne_has_Idiomes` VALUES (5,4,2),(1,3,3),(5,3,3),(1,1,4),(1,2,4),(1,4,4),(5,1,4),(5,2,4);
/*!40000 ALTER TABLE `Alumne_has_Idiomes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Alumnes`
--

DROP TABLE IF EXISTS `Alumnes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Alumnes` (
  `idAlumne` int(11) NOT NULL,
  `nom` varchar(45) NOT NULL,
  `llinatges` varchar(45) NOT NULL,
  `adreca` varchar(100) DEFAULT NULL,
  `codiPostal` char(5) DEFAULT NULL,
  `localitat` varchar(45) DEFAULT NULL,
  `provincia` varchar(45) DEFAULT NULL,
  `telefon` char(9) DEFAULT NULL,
  `email` varchar(75) NOT NULL,
  `actiu` tinyint(1) NOT NULL DEFAULT '0',
  `url` varchar(150) DEFAULT NULL,
  `descripcio` text,
  PRIMARY KEY (`idAlumne`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Alumnes`
--

LOCK TABLES `Alumnes` WRITE;
/*!40000 ALTER TABLE `Alumnes` DISABLE KEYS */;
INSERT INTO `Alumnes` VALUES (1,'Rafel','Vallespir','Carrer s\'olivera 12','07320','Selva','Illes Balears','666555444','rafel@iespaucasesnoves.cat',1,'',''),(2,'Borja','Sàez','Plaça Major 4','07514','Llucmajor','Iiles Balears','698523654','borja@iespaucasesnoves.cat',0,NULL,NULL),(3,'Cristian','Noguera','Carrer Albada 32','07436','Can Picafort','Illes Balears','647854123','cristian@iespaucasesnoves.cat',1,NULL,NULL),(5,'Antònia','Crespí','Avda d\'Alcúdia','07300','Inca','Illes Balears','632569874','antonia@iespaucasesnoves.cat',1,NULL,'');
/*!40000 ALTER TABLE `Alumnes` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `borsa`.`Alumnes_AFTER_INSERT` AFTER INSERT ON `Alumnes` FOR EACH ROW
BEGIN
   INSERT INTO Usuaris
   (tipusUsuari,nomUsuari,contrasenya)
   VALUES
   (30,NEW.email,substring(md5(rand()),-8));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `borsa`.`Alumnes_AFTER_UPDATE` AFTER UPDATE ON `Alumnes` FOR EACH ROW
BEGIN
if NEW.email <=> OLD.email THEN
update Usuaris set nomUsuari=NEW.email where nomUsuari=OLD.email;
end if;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `borsa`.`Alumnes_AFTER_DELETE` AFTER DELETE ON `Alumnes` FOR EACH ROW
BEGIN
DECLARE id INT;
 set id=(select idUsuari from usuaris where nomUsuari=OLD.email);
 delete from Usuaris_has_Rols where usuaris_idUsuari=id;
 delete from Usuaris where idUsuari=id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Contactes`
--

DROP TABLE IF EXISTS `Contactes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Contactes` (
  `idContacte` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(45) NOT NULL,
  `llinatges` varchar(45) NOT NULL,
  `telefon` char(9) DEFAULT NULL,
  `email` varchar(75) NOT NULL,
  `carrec` varchar(75) DEFAULT NULL,
  `Empreses_idEmpresa` int(11) NOT NULL,
  PRIMARY KEY (`idContacte`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  KEY `fk_Contactes_Empreses1_idx` (`Empreses_idEmpresa`),
  CONSTRAINT `fk_Contactes_Empreses1` FOREIGN KEY (`Empreses_idEmpresa`) REFERENCES `Empreses` (`idEmpresa`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Contactes`
--

LOCK TABLES `Contactes` WRITE;
/*!40000 ALTER TABLE `Contactes` DISABLE KEYS */;
INSERT INTO `Contactes` VALUES (1,'Jo','Mateix','','jomateix@nissan.jp',NULL,2),(2,'Jo','Mateix','','jomateix@intel.es','RRHH',3),(3,'Miquel','Servera','','miquel@intel.es','RRHH',3);
/*!40000 ALTER TABLE `Contactes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Empreses`
--

DROP TABLE IF EXISTS `Empreses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Empreses` (
  `idEmpresa` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(45) NOT NULL,
  `descripcio` text,
  `adreca` varchar(100) DEFAULT NULL,
  `codiPostal` char(5) DEFAULT NULL,
  `localitat` varchar(45) DEFAULT NULL,
  `provincia` varchar(45) DEFAULT NULL,
  `telefon` char(9) DEFAULT NULL,
  `email` varchar(75) NOT NULL,
  `activa` tinyint(1) NOT NULL DEFAULT '0',
  `validada` tinyint(1) NOT NULL DEFAULT '0',
  `dataAlta` date DEFAULT NULL,
  `url` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`idEmpresa`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Empreses`
--

LOCK TABLES `Empreses` WRITE;
/*!40000 ALTER TABLE `Empreses` DISABLE KEYS */;
INSERT INTO `Empreses` VALUES (1,'Sa Meva','<h1>Sa Meva</h1><p>Empresa dedicada a tota casta de projectes.</p>','Carrer nou, 10','07300','Inca','Balears','971456985','info@sameva.cat',0,0,'2017-05-29','www.sameva.cat'),(2,'Nissan','<h1>Nissan</h1><p>Idò això, una altra empresa de cotxes.</p>','Plaça Major 6','07300','Inca','Balears','654785214','info@nissan.jp',0,0,'2017-05-29','www.nissan.jp'),(3,'Intel','<h1>Intel</h1><p>Una gran companyia que fa coses petites.</p>','Avinguda No Sé Què, s/n','07300','Inca','Balears','','info@intel.es',1,0,'2017-05-29','www.intel.com');
/*!40000 ALTER TABLE `Empreses` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `borsa`.`Empreses_BEFORE_INSERT` BEFORE INSERT ON `Empreses` FOR EACH ROW
BEGIN
 SET New.dataAlta=curdate();
 if NEW.validada = false THEN
	set NEW.activa=false;
 end if;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `borsa`.`Empreses_AFTER_INSERT` AFTER INSERT ON `Empreses` FOR EACH ROW
BEGIN
   INSERT INTO Usuaris
   (tipusUsuari,nomUsuari,contrasenya)
   VALUES
   (20,NEW.email,substring(md5(rand()),-8));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `borsa`.`Empreses_AFTER_UPDATE` AFTER UPDATE ON `Empreses` FOR EACH ROW
BEGIN
if NEW.email <> OLD.email THEN
update Usuaris set nomUsuari=NEW.email where nomUsuari=OLD.email;
end if;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `borsa`.`Empreses_AFTER_DELETE` AFTER DELETE ON `Empreses` FOR EACH ROW
BEGIN
DECLARE id INT;
 set id=(select idUsuari from usuaris where nomUsuari=OLD.email);
 delete from Usuaris_has_Rols where usuaris_idUsuari=id;
 delete from Usuaris where idUsuari=id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `EstatLaboral`
--

DROP TABLE IF EXISTS `EstatLaboral`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `EstatLaboral` (
  `idEstatLaboral` int(11) NOT NULL AUTO_INCREMENT,
  `nomEstatLaboral` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idEstatLaboral`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `EstatLaboral`
--

LOCK TABLES `EstatLaboral` WRITE;
/*!40000 ALTER TABLE `EstatLaboral` DISABLE KEYS */;
INSERT INTO `EstatLaboral` VALUES (1,'Estudiant'),(2,'Aturat'),(3,'Treballant');
/*!40000 ALTER TABLE `EstatLaboral` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Estudis`
--

DROP TABLE IF EXISTS `Estudis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Estudis` (
  `codi` char(7) NOT NULL,
  `nom` varchar(150) NOT NULL,
  PRIMARY KEY (`codi`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Estudis`
--

LOCK TABLES `Estudis` WRITE;
/*!40000 ALTER TABLE `Estudis` DISABLE KEYS */;
INSERT INTO `Estudis` VALUES ('ADG21','Gestió administrativa'),('ADG32','Administració i finances'),('IFC21','Grau Mitjà en Sistemes microinformàtics i xarxes '),('IFC31','Administració de sistemes informàtics en xarxa'),('IFC32','Desenvolupament d\'aplicacions multiplataforma'),('IFC33','Desenvolupament d\'aplicacions web');
/*!40000 ALTER TABLE `Estudis` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Estudis_has_Responsables`
--

DROP TABLE IF EXISTS `Estudis_has_Responsables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Estudis_has_Responsables` (
  `Estudis_codi` char(7) NOT NULL,
  `Professors_idProfessor` int(11) NOT NULL,
  PRIMARY KEY (`Estudis_codi`,`Professors_idProfessor`),
  KEY `fk_Estudis_has_Professors_Professors1_idx` (`Professors_idProfessor`),
  KEY `fk_Estudis_has_Professors_Estudis1_idx` (`Estudis_codi`),
  CONSTRAINT `fk_Estudis_has_Professors_Estudis1` FOREIGN KEY (`Estudis_codi`) REFERENCES `Estudis` (`codi`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Estudis_has_Professors_Professors1` FOREIGN KEY (`Professors_idProfessor`) REFERENCES `Professors` (`idProfessor`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Estudis_has_Responsables`
--

LOCK TABLES `Estudis_has_Responsables` WRITE;
/*!40000 ALTER TABLE `Estudis_has_Responsables` DISABLE KEYS */;
INSERT INTO `Estudis_has_Responsables` VALUES ('IFC32',2),('IFC33',2);
/*!40000 ALTER TABLE `Estudis_has_Responsables` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Idiomes`
--

DROP TABLE IF EXISTS `Idiomes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Idiomes` (
  `idIdioma` int(11) NOT NULL AUTO_INCREMENT,
  `idioma` varchar(45) NOT NULL,
  PRIMARY KEY (`idIdioma`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Idiomes`
--

LOCK TABLES `Idiomes` WRITE;
/*!40000 ALTER TABLE `Idiomes` DISABLE KEYS */;
INSERT INTO `Idiomes` VALUES (1,'Català'),(2,'Castellà'),(3,'Anglès'),(4,'Alemany'),(5,'Àrab');
/*!40000 ALTER TABLE `Idiomes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Illes`
--

DROP TABLE IF EXISTS `Illes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Illes` (
  `idIlla` varchar(3) NOT NULL,
  `nomIlla` varchar(45) NOT NULL,
  PRIMARY KEY (`idIlla`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Illes`
--

LOCK TABLES `Illes` WRITE;
/*!40000 ALTER TABLE `Illes` DISABLE KEYS */;
INSERT INTO `Illes` VALUES ('071','Mallorca'),('072','Menorca'),('073','Eivissa'),('074','Formentera');
/*!40000 ALTER TABLE `Illes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Localitats`
--

DROP TABLE IF EXISTS `Localitats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Localitats` (
  `idLocalitat` varchar(9) NOT NULL,
  `nomLocalitat` varchar(100) NOT NULL,
  `idIlla` varchar(3) NOT NULL,
  PRIMARY KEY (`idLocalitat`),
  KEY `fk_Localitats_Illes1_idx` (`idIlla`),
  CONSTRAINT `fk_Localitats_Illes1` FOREIGN KEY (`idIlla`) REFERENCES `Illes` (`idIlla`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Localitats`
--

LOCK TABLES `Localitats` WRITE;
/*!40000 ALTER TABLE `Localitats` DISABLE KEYS */;
INSERT INTO `Localitats` VALUES ('071007300','Inca','071'),('071007310','Campanet','071');
/*!40000 ALTER TABLE `Localitats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `NivellsIdioma`
--

DROP TABLE IF EXISTS `NivellsIdioma`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `NivellsIdioma` (
  `idNivellIdioma` int(11) NOT NULL AUTO_INCREMENT,
  `nivell` varchar(45) NOT NULL,
  PRIMARY KEY (`idNivellIdioma`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `NivellsIdioma`
--

LOCK TABLES `NivellsIdioma` WRITE;
/*!40000 ALTER TABLE `NivellsIdioma` DISABLE KEYS */;
INSERT INTO `NivellsIdioma` VALUES (1,'Gens'),(2,'Malament'),(3,'Bé'),(4,'Molt bé');
/*!40000 ALTER TABLE `NivellsIdioma` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Ofertes`
--

DROP TABLE IF EXISTS `Ofertes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Ofertes` (
  `idOferta` int(11) NOT NULL AUTO_INCREMENT,
  `titol` varchar(50) NOT NULL,
  `descripcio` text NOT NULL,
  `dataPublicacio` date DEFAULT NULL,
  `dataFinal` date DEFAULT NULL,
  `validada` tinyint(1) NOT NULL DEFAULT '0',
  `professorValidada` int(11) DEFAULT NULL,
  `Empreses_idEmpresa` int(11) NOT NULL,
  `tipusContracte` varchar(45) DEFAULT NULL,
  `horari` varchar(60) DEFAULT NULL,
  `localitat` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`idOferta`),
  KEY `fk_Ofertes_Empreses1_idx` (`Empreses_idEmpresa`),
  KEY `fk_Ofertes_Professors1_idx` (`professorValidada`),
  CONSTRAINT `fk_Ofertes_Empreses1` FOREIGN KEY (`Empreses_idEmpresa`) REFERENCES `Empreses` (`idEmpresa`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ofertes_Professors1` FOREIGN KEY (`professorValidada`) REFERENCES `Professors` (`idProfessor`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Ofertes`
--

LOCK TABLES `Ofertes` WRITE;
/*!40000 ALTER TABLE `Ofertes` DISABLE KEYS */;
INSERT INTO `Ofertes` VALUES (1,'Recepcionista','<h3>\n                        Recepcionista</h3><p>Necessitam urgentment incorporar un/una recepcionista per a la nostra oficina de Lloseta.</p><p>Imprescindible domini de l\'anglès i l\'alemany.</p>',NULL,'2017-06-28',0,NULL,3,'Indefinit','Matí de 9:00 a 14:00','Lloseta'),(2,'Dissenyador web','<h3>\n                        Dissenyador web</h3><p>Cercam un dissenyador web amb profund coneixement de CSS responsive i domini de Thymeleave.</p><p>Contracte indefinit a jornada completa. Sou negociable.</p>',NULL,'2017-06-15',0,NULL,3,'Indefinit','Matí i tarda','Lloseta'),(3,'Auxiliar administratiu','\n                        \n                        <h3>Auxiliar administratiu</h3><p>Necessitam incorporar immediatament dos auxiliars administratius a la nostra oficina de Lloseta.</p><p>El contracte serà de pràctiques, amb una durada inicial d\'un any. Sou negociable.</p>\n                        \n                    \n                    \n                    ','2017-05-31','2017-06-05',0,NULL,3,'Pràctiques','Matí','Lloseta'),(4,'Programador junior Java','<h3>\n                        Programador junior Java</h3><p>L\'empresa necessita incorporar a finals de juny tres programadors amb coneixements de Java. </p><p>Es valorarà la familiaritat amb JEE i Struts.</p><p>El sou serà d\'uns 15.000€ bruts.</p><h3>\n                    </h3>',NULL,'2017-06-12',0,NULL,3,'Indefinit','Complet','Lloseta');
/*!40000 ALTER TABLE `Ofertes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Ofertes_enviada_Alumnes`
--

DROP TABLE IF EXISTS `Ofertes_enviada_Alumnes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Ofertes_enviada_Alumnes` (
  `Ofertes_idOferta` int(11) NOT NULL,
  `Alumnes_idAlumne` int(11) NOT NULL,
  PRIMARY KEY (`Ofertes_idOferta`,`Alumnes_idAlumne`),
  KEY `fk_Ofertes_has_Alumnes_Alumnes1_idx` (`Alumnes_idAlumne`),
  KEY `fk_Ofertes_has_Alumnes_Ofertes1_idx` (`Ofertes_idOferta`),
  CONSTRAINT `fk_Ofertes_has_Alumnes_Alumnes1` FOREIGN KEY (`Alumnes_idAlumne`) REFERENCES `Alumnes` (`idAlumne`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ofertes_has_Alumnes_Ofertes1` FOREIGN KEY (`Ofertes_idOferta`) REFERENCES `Ofertes` (`idOferta`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Ofertes_enviada_Alumnes`
--

LOCK TABLES `Ofertes_enviada_Alumnes` WRITE;
/*!40000 ALTER TABLE `Ofertes_enviada_Alumnes` DISABLE KEYS */;
/*!40000 ALTER TABLE `Ofertes_enviada_Alumnes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Ofertes_has_Contactes`
--

DROP TABLE IF EXISTS `Ofertes_has_Contactes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Ofertes_has_Contactes` (
  `Ofertes_idOferta` int(11) NOT NULL,
  `Contactes_idContacte` int(11) NOT NULL,
  PRIMARY KEY (`Ofertes_idOferta`,`Contactes_idContacte`),
  KEY `fk_Ofertes_has_Contactes_Contactes1_idx` (`Contactes_idContacte`),
  KEY `fk_Ofertes_has_Contactes_Ofertes1_idx` (`Ofertes_idOferta`),
  CONSTRAINT `fk_Ofertes_has_Contactes_Contactes1` FOREIGN KEY (`Contactes_idContacte`) REFERENCES `Contactes` (`idContacte`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ofertes_has_Contactes_Ofertes1` FOREIGN KEY (`Ofertes_idOferta`) REFERENCES `Ofertes` (`idOferta`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Ofertes_has_Contactes`
--

LOCK TABLES `Ofertes_has_Contactes` WRITE;
/*!40000 ALTER TABLE `Ofertes_has_Contactes` DISABLE KEYS */;
INSERT INTO `Ofertes_has_Contactes` VALUES (3,2),(4,2),(3,3),(4,3);
/*!40000 ALTER TABLE `Ofertes_has_Contactes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Ofertes_has_EstatLaboral`
--

DROP TABLE IF EXISTS `Ofertes_has_EstatLaboral`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Ofertes_has_EstatLaboral` (
  `Ofertes_idOferta` int(11) NOT NULL,
  `EstatLaboral_idEstatLaboral` int(11) NOT NULL,
  PRIMARY KEY (`Ofertes_idOferta`,`EstatLaboral_idEstatLaboral`),
  KEY `fk_Ofertes_has_EstatLaboral_EstatLaboral1_idx` (`EstatLaboral_idEstatLaboral`),
  KEY `fk_Ofertes_has_EstatLaboral_Ofertes1_idx` (`Ofertes_idOferta`),
  CONSTRAINT `fk_Ofertes_has_EstatLaboral_EstatLaboral1` FOREIGN KEY (`EstatLaboral_idEstatLaboral`) REFERENCES `EstatLaboral` (`idEstatLaboral`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ofertes_has_EstatLaboral_Ofertes1` FOREIGN KEY (`Ofertes_idOferta`) REFERENCES `Ofertes` (`idOferta`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Ofertes_has_EstatLaboral`
--

LOCK TABLES `Ofertes_has_EstatLaboral` WRITE;
/*!40000 ALTER TABLE `Ofertes_has_EstatLaboral` DISABLE KEYS */;
INSERT INTO `Ofertes_has_EstatLaboral` VALUES (4,1),(3,2),(4,3);
/*!40000 ALTER TABLE `Ofertes_has_EstatLaboral` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Ofertes_has_Estudis`
--

DROP TABLE IF EXISTS `Ofertes_has_Estudis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Ofertes_has_Estudis` (
  `Ofertes_idOferta` int(11) NOT NULL,
  `Estudis_codi` char(7) NOT NULL,
  `any` int(11) DEFAULT NULL,
  `nota` int(11) DEFAULT NULL,
  PRIMARY KEY (`Ofertes_idOferta`,`Estudis_codi`),
  KEY `fk_Ofertes_has_Estudis_Estudis1_idx` (`Estudis_codi`),
  KEY `fk_Ofertes_has_Estudis_Ofertes1_idx` (`Ofertes_idOferta`),
  CONSTRAINT `fk_Ofertes_has_Estudis_Estudis1` FOREIGN KEY (`Estudis_codi`) REFERENCES `Estudis` (`codi`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ofertes_has_Estudis_Ofertes1` FOREIGN KEY (`Ofertes_idOferta`) REFERENCES `Ofertes` (`idOferta`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Ofertes_has_Estudis`
--

LOCK TABLES `Ofertes_has_Estudis` WRITE;
/*!40000 ALTER TABLE `Ofertes_has_Estudis` DISABLE KEYS */;
INSERT INTO `Ofertes_has_Estudis` VALUES (3,'ADG32',2015,5),(4,'IFC31',2017,5),(4,'IFC32',2017,5),(4,'IFC33',2014,7);
/*!40000 ALTER TABLE `Ofertes_has_Estudis` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Ofertes_has_Idiomes`
--

DROP TABLE IF EXISTS `Ofertes_has_Idiomes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Ofertes_has_Idiomes` (
  `Ofertes_idOferta` int(11) NOT NULL,
  `Idiomes_idIdioma` int(11) NOT NULL,
  `NivellsIdioma_idNivellIdioma` int(11) NOT NULL,
  PRIMARY KEY (`Ofertes_idOferta`,`Idiomes_idIdioma`,`NivellsIdioma_idNivellIdioma`),
  KEY `fk_Ofertes_has_Idiomes_Idiomes1_idx` (`Idiomes_idIdioma`),
  KEY `fk_Ofertes_has_Idiomes_Ofertes1_idx` (`Ofertes_idOferta`),
  KEY `fk_Ofertes_has_Idiomes_NivellsIdioma1_idx` (`NivellsIdioma_idNivellIdioma`),
  CONSTRAINT `fk_Ofertes_has_Idiomes_Idiomes1` FOREIGN KEY (`Idiomes_idIdioma`) REFERENCES `Idiomes` (`idIdioma`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ofertes_has_Idiomes_NivellsIdioma1` FOREIGN KEY (`NivellsIdioma_idNivellIdioma`) REFERENCES `NivellsIdioma` (`idNivellIdioma`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ofertes_has_Idiomes_Ofertes1` FOREIGN KEY (`Ofertes_idOferta`) REFERENCES `Ofertes` (`idOferta`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Ofertes_has_Idiomes`
--

LOCK TABLES `Ofertes_has_Idiomes` WRITE;
/*!40000 ALTER TABLE `Ofertes_has_Idiomes` DISABLE KEYS */;
INSERT INTO `Ofertes_has_Idiomes` VALUES (3,1,4),(3,2,4),(4,3,3),(4,4,4);
/*!40000 ALTER TABLE `Ofertes_has_Idiomes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Professors`
--

DROP TABLE IF EXISTS `Professors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Professors` (
  `idProfessor` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(45) NOT NULL,
  `llinatges` varchar(45) NOT NULL,
  `telefon` char(9) DEFAULT NULL,
  `email` varchar(75) NOT NULL,
  `actiu` tinyint(1) NOT NULL DEFAULT '0',
  `validat` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`idProfessor`),
  UNIQUE KEY `Email_UNIQUE` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Professors`
--

LOCK TABLES `Professors` WRITE;
/*!40000 ALTER TABLE `Professors` DISABLE KEYS */;
INSERT INTO `Professors` VALUES (1,'Joan','Pons Tugores','666555444','ptj@iespaucasesnoves.cat',1,1),(2,'Tomeu','Campaner Fornés','699855477','cfb@iespaucasesnoves.cat',0,0);
/*!40000 ALTER TABLE `Professors` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `borsa`.`Professors_BEFORE_INSERT` BEFORE INSERT ON `Professors` FOR EACH ROW
BEGIN
if NEW.validat = false THEN
	set NEW.actiu=false;
 end if;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`usuariWeb`@`%`*/ /*!50003 TRIGGER `borsa`.`Professors_AFTER_INSERT` AFTER INSERT ON `Professors` FOR EACH ROW
BEGIN
   INSERT INTO Usuaris
   (tipusUsuari,nomUsuari,contrasenya)
   VALUES
   (10,NEW.email,substring(md5(rand()),-8));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `borsa`.`Professors_AFTER_UPDATE` AFTER UPDATE ON `Professors` FOR EACH ROW
BEGIN
if NEW.email <=> OLD.email THEN
update Usuaris set nomUsuari=NEW.email where nomUsuari=OLD.email;
end if;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `borsa`.`Professors_AFTER_DELETE` AFTER DELETE ON `Professors` FOR EACH ROW
BEGIN
DECLARE id INT;
DECLARE tipus INT;
 set id=(select idUsuari from usuaris where nomUsuari=OLD.email);
 set tipus=(select tipusUsuari from usuaris where nomUsuari=OLD.email);
 delete from Usuaris_has_Rols where usuaris_idUsuari=id and usuaris_tipus_usuari=tipus;
 delete from Usuaris where idUsuari=id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Rols`
--

DROP TABLE IF EXISTS `Rols`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Rols` (
  `idRol` int(11) NOT NULL,
  `nomRol` varchar(45) NOT NULL,
  PRIMARY KEY (`idRol`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Rols`
--

LOCK TABLES `Rols` WRITE;
/*!40000 ALTER TABLE `Rols` DISABLE KEYS */;
INSERT INTO `Rols` VALUES (10,'Professor'),(20,'Empresa'),(30,'Alumne'),(40,'Administrador');
/*!40000 ALTER TABLE `Rols` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TipusUsuaris`
--

DROP TABLE IF EXISTS `TipusUsuaris`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `TipusUsuaris` (
  `idTipusUsuaris` int(11) NOT NULL,
  `nomTipusUsuari` varchar(45) NOT NULL,
  PRIMARY KEY (`idTipusUsuaris`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TipusUsuaris`
--

LOCK TABLES `TipusUsuaris` WRITE;
/*!40000 ALTER TABLE `TipusUsuaris` DISABLE KEYS */;
INSERT INTO `TipusUsuaris` VALUES (10,'Professor'),(20,'Empresa'),(30,'Estudiant');
/*!40000 ALTER TABLE `TipusUsuaris` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Usuaris`
--

DROP TABLE IF EXISTS `Usuaris`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Usuaris` (
  `idUsuari` int(11) NOT NULL AUTO_INCREMENT,
  `tipusUsuari` int(11) NOT NULL,
  `nomUsuari` varchar(75) NOT NULL,
  `contrasenya` varchar(75) NOT NULL,
  PRIMARY KEY (`idUsuari`),
  UNIQUE KEY `nomUsuari_UNIQUE` (`nomUsuari`),
  KEY `fk_usuaris_TipusUsuaris1_idx` (`tipusUsuari`),
  CONSTRAINT `fk_usuaris_TipusUsuaris1` FOREIGN KEY (`tipusUsuari`) REFERENCES `TipusUsuaris` (`idTipusUsuaris`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Usuaris`
--

LOCK TABLES `Usuaris` WRITE;
/*!40000 ALTER TABLE `Usuaris` DISABLE KEYS */;
INSERT INTO `Usuaris` VALUES (1,30,'rafel@iespaucasesnoves.cat','12345678'),(2,30,'borja@iespaucasesnoves.cat','12345678'),(3,30,'cristian@iespaucasesnoves.cat','12345678'),(4,20,'info@sameva.cat','12345678'),(5,20,'info@nissan.jp','12345678'),(6,20,'info@intel.es','12345678'),(7,10,'ptj@iespaucasesnoves.cat','12345678'),(8,10,'cfb@iespaucasesnoves.cat','12345678'),(9,30,'antonia@iespaucasesnoves.cat','5f083069');
/*!40000 ALTER TABLE `Usuaris` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `borsa`.`usuaris_AFTER_INSERT` AFTER INSERT ON `Usuaris` FOR EACH ROW
BEGIN
INSERT INTO Usuaris_has_Rols
   (usuaris_idusuari, rols_idrol)
   VALUES
   (New.idusuari,New.tipusUsuari);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Usuaris_has_Rols`
--

DROP TABLE IF EXISTS `Usuaris_has_Rols`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Usuaris_has_Rols` (
  `Usuaris_idUsuari` int(11) NOT NULL,
  `Rols_idRol` int(11) NOT NULL,
  PRIMARY KEY (`Usuaris_idUsuari`,`Rols_idRol`),
  KEY `fk_Usuaris_has_Rols_Rols1_idx` (`Rols_idRol`),
  KEY `fk_Usuaris_has_Rols_Usuaris1_idx` (`Usuaris_idUsuari`),
  CONSTRAINT `fk_Usuaris_has_Rols_Rols1` FOREIGN KEY (`Rols_idRol`) REFERENCES `Rols` (`idRol`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuaris_has_Rols_Usuaris1` FOREIGN KEY (`Usuaris_idUsuari`) REFERENCES `Usuaris` (`idUsuari`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Usuaris_has_Rols`
--

LOCK TABLES `Usuaris_has_Rols` WRITE;
/*!40000 ALTER TABLE `Usuaris_has_Rols` DISABLE KEYS */;
INSERT INTO `Usuaris_has_Rols` VALUES (7,10),(8,10),(4,20),(5,20),(6,20),(1,30),(2,30),(3,30),(9,30),(7,40);
/*!40000 ALTER TABLE `Usuaris_has_Rols` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'borsa'
--

--
-- Dumping routines for database 'borsa'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-05-31 17:38:28
