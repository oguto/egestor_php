-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema neloseduc
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema neloseduc
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `neloseduc` DEFAULT CHARACTER SET utf8 ;
USE `neloseduc` ;

-- -----------------------------------------------------
-- Table `PERIODO_LANCAMENTO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PERIODO_LANCAMENTO` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` TEXT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TIPO_LANCAMENTO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TIPO_LANCAMENTO` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` TEXT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LANCAMENTO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LANCAMENTO` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `tipo` INT NOT NULL,
  `inicio` INT NOT NULL,
  `fim` INT NOT NULL,
  `valor` DECIMAL NOT NULL,
  `id_periodo_lancamento` INT NOT NULL,
  `descricao` TEXT NULL,
  `associar_matricula` INT NOT NULL,
  `admin` INT(11) NOT NULL,
  `exclusao` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DESCONTO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DESCONTO` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_fatura` INT NOT NULL,
  `exclusao_vencimento` INT NULL,
  `data_validade` DATE NOT NULL,
  `porcentagem` DECIMAL NOT NULL,
  `admin` INT(11) NOT NULL,
  `exclusao` VARCHAR(10) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FATURA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FATURA` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_lancamento` INT NOT NULL,
  `mes` INT NOT NULL,
  `ano` INT NOT NULL,
  `dia_vencimento` DATE NULL,
  `data_pagamento` DATE NULL,
  `valor_bruto` DECIMAL NULL,
  `valor_liquido` DECIMAL NULL,
  `valor_pago` DECIMAL NULL,
  `id_responsavel_financeiro` INT NULL,
  `nfe` TEXT NULL,
  `admin` INT NOT NULL,
  `exclusao` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `RESPONSAVEL_FINANCEIRO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `RESPONSAVEL_FINANCEIRO` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_aluno` INT NOT NULL,
  `id_responsavel` INT NOT NULL,
  `dia_vencimento` INT NOT NULL,
  `admin` INT NOT NULL,
  `exclusao` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TIPO_BOLETO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TIPO_BOLETO` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BOLETO_ADMIN`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BOLETO_ADMIN` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_plataforma` INT NOT NULL,
  `login` TEXT NULL,
  `senha` TEXT NULL,
  `multa` DECIMAL NULL,
  `juros` DECIMAL NULL,
  `status` INT NOT NULL,
  `admin` INT(11) NOT NULL,
  `exclusao` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CARNE_BOLETO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CARNE_BOLETO` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_carne` TEXT NOT NULL,
  `id_plataforma` INT NOT NULL,
  `url` TEXT NOT NULL,
  `admin` INT(11) NOT NULL,
  `exclusao` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FATURA_BOLETO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FATURA_BOLETO` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_fatura` INT NOT NULL,
  `id_documento` TEXT NULL,
  `id_boleto` TEXT NOT NULL,
  `id_carne` INT NULL,
  `url_boleto` TEXT NULL,
  `id_plataforma` INT NOT NULL,
  `admin` INT NOT NULL,
  `exclusao` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Data for table `PERIODO_LANCAMENTO`
-- -----------------------------------------------------
START TRANSACTION;
USE `neloseduc`;
INSERT INTO `PERIODO_LANCAMENTO` (`id`, `nome`) VALUES (3, 'Mensal');
INSERT INTO `PERIODO_LANCAMENTO` (`id`, `nome`) VALUES (2, 'Anual');
INSERT INTO `PERIODO_LANCAMENTO` (`id`, `nome`) VALUES (1, 'Ùnico');

COMMIT;


-- -----------------------------------------------------
-- Data for table `TIPO_LANCAMENTO`
-- -----------------------------------------------------
START TRANSACTION;
USE `neloseduc`;
INSERT INTO `TIPO_LANCAMENTO` (`id`, `nome`) VALUES (1, 'ENTRADA');
INSERT INTO `TIPO_LANCAMENTO` (`id`, `nome`) VALUES (2, 'SAÌDA');

COMMIT;


-- -----------------------------------------------------
-- Data for table `TIPO_BOLETO`
-- -----------------------------------------------------
START TRANSACTION;
USE `neloseduc`;
INSERT INTO `TIPO_BOLETO` (`id`, `nome`) VALUES (1, 'ASAAS');
INSERT INTO `TIPO_BOLETO` (`id`, `nome`) VALUES (2, 'GERENCIANET');

COMMIT;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
