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
-- Table `mydb`.`log`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`log` (
  `idlog` INT NOT NULL,
  `FK idusuario` VARCHAR(45) NULL,
  `FK idpermissoes` VARCHAR(45) NULL,
  `datahora_acesso` DATETIME NULL,
  PRIMARY KEY (`idlog`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`usuario` (
  `idusuario` INT NOT NULL,
  `nome_user` VARCHAR(45) NULL,
  `pswd_user` VARCHAR(45) NULL,
  `tipo_user` VARCHAR(45) NULL,
  `log_idlog` INT NOT NULL,
  PRIMARY KEY (`idusuario`, `log_idlog`),
  INDEX `fk_usuario_log1_idx` (`log_idlog` ASC) VISIBLE,
  CONSTRAINT `fk_usuario_log1`
    FOREIGN KEY (`log_idlog`)
    REFERENCES `mydb`.`log` (`idlog`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`permissoes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`permissoes` (
  `idpermissoes` INT NOT NULL,
  `usuario_idusuario` INT NOT NULL,
  `descricao` VARCHAR(45) NULL,
  `tipo_permissao` VARCHAR(45) NULL,
  PRIMARY KEY (`idpermissoes`, `usuario_idusuario`),
  INDEX `fk_permissoes_usuario_idx` (`usuario_idusuario` ASC) VISIBLE,
  CONSTRAINT `fk_permissoes_usuario`
    FOREIGN KEY (`usuario_idusuario`)
    REFERENCES `mydb`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
