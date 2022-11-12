-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`regime`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`regime` (
  `idregime` INT NOT NULL,
  `descricao_regime` VARCHAR(45) NULL,
  PRIMARY KEY (`idregime`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`cliente` (
  `idcliente` INT NOT NULL,
  `tipocliente` VARCHAR(45) NULL,
  `cnpj` VARCHAR(45) NULL,
  `ie` VARCHAR(45) NULL,
  `cpf` VARCHAR(45) NULL,
  `rg` VARCHAR(45) NULL,
  `nome` VARCHAR(45) NULL,
  `cep` VARCHAR(45) NULL,
  `regime_idregime` INT NOT NULL,
  PRIMARY KEY (`idcliente`, `regime_idregime`),
  INDEX `fk_cliente_regime1_idx` (`regime_idregime` ASC) VISIBLE,
  CONSTRAINT `fk_cliente_regime1`
    FOREIGN KEY (`regime_idregime`)
    REFERENCES `mydb`.`regime` (`idregime`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tributo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tributo` (
  `idtipo` INT NOT NULL,
  `tipo tributo` VARCHAR(45) NULL,
  `descricao` VARCHAR(45) NULL,
  `cliente_idcliente` INT NOT NULL,
  `regime_idregime` INT NOT NULL,
  PRIMARY KEY (`idtipo`, `cliente_idcliente`, `regime_idregime`),
  INDEX `fk_tributo_cliente_idx` (`cliente_idcliente` ASC) VISIBLE,
  INDEX `fk_tributo_regime1_idx` (`regime_idregime` ASC) VISIBLE,
  CONSTRAINT `fk_tributo_cliente`
    FOREIGN KEY (`cliente_idcliente`)
    REFERENCES `mydb`.`cliente` (`idcliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tributo_regime1`
    FOREIGN KEY (`regime_idregime`)
    REFERENCES `mydb`.`regime` (`idregime`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`recibo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`recibo` (
  `idrecibo` INT NOT NULL,
  `data_recibo` DATE NULL,
  `recibocol` VARCHAR(45) NULL,
  PRIMARY KEY (`idrecibo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`cobranca`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`cobranca` (
  `idcobranca` INT NOT NULL,
  `vencimento_cobranca` DATE NULL,
  `emissao_cobranca` DATE NULL,
  `cobrancacol` VARCHAR(45) NOT NULL,
  `tributo_idtipo` INT NOT NULL,
  `tributo_cliente_idcliente` INT NOT NULL,
  `recibo_idrecibo` INT NOT NULL,
  PRIMARY KEY (`idcobranca`, `cobrancacol`, `tributo_idtipo`, `tributo_cliente_idcliente`, `recibo_idrecibo`),
  INDEX `fk_cobranca_tributo1_idx` (`tributo_idtipo` ASC, `tributo_cliente_idcliente` ASC) VISIBLE,
  INDEX `fk_cobranca_recibo1_idx` (`recibo_idrecibo` ASC) VISIBLE,
  CONSTRAINT `fk_cobranca_tributo1`
    FOREIGN KEY (`tributo_idtipo` , `tributo_cliente_idcliente`)
    REFERENCES `mydb`.`tributo` (`idtipo` , `cliente_idcliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cobranca_recibo1`
    FOREIGN KEY (`recibo_idrecibo`)
    REFERENCES `mydb`.`recibo` (`idrecibo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
