-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema pam
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema pam
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pam` DEFAULT CHARACTER SET latin1 ;
USE `pam` ;

-- -----------------------------------------------------
-- Table `pam`.`acg_member`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pam`.`acg_member` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(20) NOT NULL,
  `callsign` VARCHAR(20) NOT NULL,
  `admin` TINYINT(1) NOT NULL,
  `map_viewer` TINYINT(1) NOT NULL,
  `mission_builder` TINYINT(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 408
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `pam`.`acg_unit`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pam`.`acg_unit` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `permanent` TINYINT(1) NOT NULL,
  `name` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 18
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `pam`.`asset`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pam`.`asset` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `faction` INT(11) NOT NULL,
  `controlable` TINYINT(1) NOT NULL,
  `lft` INT(11) NULL DEFAULT NULL,
  `rgt` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 77
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `pam`.`award`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pam`.`award` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(80) NOT NULL,
  `abreviation` VARCHAR(20) NOT NULL,
  `image` VARCHAR(50) NOT NULL,
  `faction` INT(11) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 25
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `pam`.`campaign`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pam`.`campaign` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `is_primary` TINYINT(1) NOT NULL,
  `platform` INT(11) NOT NULL,
  `campaign_status` INT(10) NOT NULL,
  `time` VARCHAR(45) NOT NULL,
  `open` TINYINT(1) NOT NULL,
  `campaign_link` INT(11) NULL DEFAULT NULL,
  `description` VARCHAR(45) NULL DEFAULT NULL,
  `image` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_campaigns_campaigns1_idx` (`campaign_link` ASC),
  CONSTRAINT `fk_campaigns_campaigns1`
    FOREIGN KEY (`campaign_link`)
    REFERENCES `pam`.`campaign` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `pam`.`mission`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pam`.`mission` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NULL DEFAULT NULL,
  `campaign_id` INT(11) NOT NULL,
  `real_date` DATE NOT NULL,
  `hist_date` DATETIME NOT NULL,
  `mission_status` INT(10) NOT NULL,
  PRIMARY KEY (`id`, `campaign_id`),
  INDEX `fk_missions_campaigns1_idx` (`campaign_id` ASC),
  CONSTRAINT `fk_missions_campaigns1`
    FOREIGN KEY (`campaign_id`)
    REFERENCES `pam`.`campaign` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 142
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `pam`.`briefing`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pam`.`briefing` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `mission_id` INT(11) NOT NULL,
  `faction` INT(11) NOT NULL,
  `text` VARCHAR(15000) NULL DEFAULT NULL,
  PRIMARY KEY (`id`, `mission_id`),
  INDEX `fk_briefings_missions1_idx` (`mission_id` ASC),
  CONSTRAINT `fk_briefings_missions1`
    FOREIGN KEY (`mission_id`)
    REFERENCES `pam`.`mission` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 195
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `pam`.`career_character`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pam`.`career_character` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `personified_by` INT(11) NOT NULL,
  `first_name` VARCHAR(20) NOT NULL,
  `last_name` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id`, `personified_by`),
  INDEX `fk_career_character_acg_member1_idx` (`personified_by` ASC),
  CONSTRAINT `fk_career_character_acg_member1`
    FOREIGN KEY (`personified_by`)
    REFERENCES `pam`.`acg_member` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 2426
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `pam`.`hist_unit`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pam`.`hist_unit` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `code` VARCHAR(45) NULL DEFAULT NULL,
  `faction` INT(11) NOT NULL,
  `type` INT(11) NOT NULL,
  `description` VARCHAR(45) NULL DEFAULT NULL,
  `image` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 25
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `pam`.`deployed_unit`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pam`.`deployed_unit` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `campaign_id` INT(11) NOT NULL,
  `acg_unit_id` INT(11) NULL DEFAULT NULL,
  `hist_unit_id` INT(11) NOT NULL,
  `asset_id` INT(11) NULL DEFAULT NULL,
  `report_type` INT(11) NULL DEFAULT NULL,
  `lft` INT(11) NOT NULL,
  `rgt` INT(11) NOT NULL,
  PRIMARY KEY (`id`, `campaign_id`, `hist_unit_id`),
  INDEX `fk_deployedunits_campaigns1_idx` (`campaign_id` ASC),
  INDEX `fk_deployedunits_histunits1_idx` (`hist_unit_id` ASC),
  CONSTRAINT `fk_deployedunits_campaigns1`
    FOREIGN KEY (`campaign_id`)
    REFERENCES `pam`.`campaign` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_deployedunits_histunits1`
    FOREIGN KEY (`hist_unit_id`)
    REFERENCES `pam`.`hist_unit` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 106
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `pam`.`report`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pam`.`report` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `mission_id` INT(11) NOT NULL COMMENT '		',
  `character_id` INT(11) NOT NULL,
  `deployed_unit_id` INT(11) NOT NULL,
  `base` VARCHAR(50) NOT NULL,
  `asset_id` INT(11) NOT NULL,
  `markings` VARCHAR(20) NOT NULL,
  `synopsis` VARCHAR(15000) NULL DEFAULT NULL,
  `asset_status` INT(11) NOT NULL,
  `pilot_status` INT(11) NOT NULL,
  `date_submitted` DATE NOT NULL,
  `accepted` TINYINT(1) NOT NULL,
  `accepted_by` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`, `mission_id`, `character_id`, `deployed_unit_id`, `asset_id`),
  INDEX `missionID` (`mission_id` ASC),
  INDEX `authorID` (`character_id` ASC),
  INDEX `squadronID` (`deployed_unit_id` ASC),
  INDEX `acceptedBy` (`accepted_by` ASC),
  INDEX `fk_report_asset1_idx` (`asset_id` ASC),
  CONSTRAINT `fk_report_acg_member1`
    FOREIGN KEY (`accepted_by`)
    REFERENCES `pam`.`acg_member` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_report_asset1`
    FOREIGN KEY (`asset_id`)
    REFERENCES `pam`.`asset` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reports_careercharacters1`
    FOREIGN KEY (`character_id`)
    REFERENCES `pam`.`career_character` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reports_deployedunits1`
    FOREIGN KEY (`deployed_unit_id`)
    REFERENCES `pam`.`deployed_unit` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reports_missions1`
    FOREIGN KEY (`mission_id`)
    REFERENCES `pam`.`mission` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 12078
DEFAULT CHARACTER SET = latin1;

-- -----------------------------------------------------
-- Table `pam`.`claim`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pam`.`claim` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `report_id` INT(11) NOT NULL,
  `asset_id` INT(11) NOT NULL,
  `description` VARCHAR(500) NULL DEFAULT NULL,
  `accepted` TINYINT(1) NOT NULL,
  `accepted_by` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`, `report_id`, `asset_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 144
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `pam`.`claim_ground`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pam`.`claim_ground` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `claim_id` INT(11) NOT NULL,
  `amount` INT(11) NOT NULL,
  PRIMARY KEY (`id`, `claim_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 144
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `pam`.`claim_lw`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pam`.`claim_lw` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `claim_id` INT(11) NOT NULL,
  `claim_time` VARCHAR(5) NULL DEFAULT NULL,
  `place` VARCHAR(50) NULL DEFAULT NULL,
  `opponent` VARCHAR(20) NULL DEFAULT NULL,
  `type_of_destruction` INT(11) NOT NULL,
  `type_of_impact` INT(11) NOT NULL,
  `fate_of_crew` INT(11) NOT NULL,
  `witness` INT(11) NULL DEFAULT NULL,
  `confirmed` TINYINT(1) NOT NULL,
  PRIMARY KEY (`id`, `claim_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 2108
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `pam`.`claim_raf`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pam`.`claim_raf` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `claim_id` INT(11) NOT NULL,
  `enemy_status` INT(11) NOT NULL,
  `shared` TINYINT(1) NULL DEFAULT NULL,
  PRIMARY KEY (`id`, `claim_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 6870
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `pam`.`claim_vvs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pam`.`claim_vvs` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `claim_id` INT(11) NOT NULL,
  `claim_time` VARCHAR(5) NULL DEFAULT NULL,
  `place` VARCHAR(50) NULL DEFAULT NULL,
  `witness` INT(11) NULL DEFAULT NULL,
  `confirmed` TINYINT(1) NOT NULL,
  `group_claim` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`, `claim_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 2108
DEFAULT CHARACTER SET = latin1;

-- -----------------------------------------------------
-- Table `pam`.`comment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pam`.`comment` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `report_id` INT(11) NOT NULL,
  `member_id` INT(11) NOT NULL,
  `comment_date` DATE NOT NULL,
  `comment_text` VARCHAR(500) NOT NULL,
  PRIMARY KEY (`id`, `report_id`, `member_id`),
  INDEX `fk_comments_reports1_idx` (`report_id` ASC),
  INDEX `fk_comments_acgmembers1_idx` (`member_id` ASC),
  CONSTRAINT `fk_comments_acgmembers1`
    FOREIGN KEY (`member_id`)
    REFERENCES `pam`.`acg_member` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comments_reports1`
    FOREIGN KEY (`report_id`)
    REFERENCES `pam`.`report` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 3207
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `pam`.`decoration`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pam`.`decoration` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `character_id` INT(11) NOT NULL,
  `award_id` INT(11) NOT NULL,
  `date` DATE NOT NULL,
  `comment` VARCHAR(200) NULL DEFAULT NULL,
  `awarded` TINYINT(1) NOT NULL,
  `awarded_by` INT(11) NULL DEFAULT NULL,
  `recommendation_date` DATE NOT NULL,
  PRIMARY KEY (`id`, `character_id`, `award_id`),
  UNIQUE INDEX `characterID_2` (`character_id` ASC, `award_id` ASC),
  UNIQUE INDEX `characterID_3` (`character_id` ASC, `award_id` ASC),
  INDEX `characterID` (`character_id` ASC, `award_id` ASC),
  INDEX `fk_decorations_awards1_idx` (`award_id` ASC),
  INDEX `fk_decoration_acg_member1_idx` (`awarded_by` ASC),
  CONSTRAINT `fk_decoration_acg_member1`
    FOREIGN KEY (`awarded_by`)
    REFERENCES `pam`.`acg_member` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_decorations_awards1`
    FOREIGN KEY (`award_id`)
    REFERENCES `pam`.`award` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_decorations_careercharacters1`
    FOREIGN KEY (`character_id`)
    REFERENCES `pam`.`career_character` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 69535
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `pam`.`member_status_log`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pam`.`member_status_log` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `member_id` INT(11) NOT NULL,
  `member_status` INT(11) NOT NULL,
  `status_date_in` DATE NOT NULL,
  `status_date_out` DATE NULL DEFAULT NULL,
  `comment` VARCHAR(200) NULL DEFAULT NULL,
  PRIMARY KEY (`id`, `member_id`),
  INDEX `fk_memberstatuslog_acgmembers1_idx` (`member_id` ASC),
  CONSTRAINT `fk_memberstatuslog_acgmembers1`
    FOREIGN KEY (`member_id`)
    REFERENCES `pam`.`acg_member` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1494
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `pam`.`namepool`
-- -----------------------------------------------------
-- CREATE TABLE IF NOT EXISTS `pam`.`namepool` (
--   `id` INT(11) NOT NULL AUTO_INCREMENT,
--   `name` VARCHAR(20) NOT NULL,
--   `type` VARCHAR(10) NOT NULL,
--   `faction` INT(11) NOT NULL,
--   PRIMARY KEY (`id`))
-- ENGINE = InnoDB
-- AUTO_INCREMENT = 1140
-- DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `pam`.`rank`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pam`.`rank` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(20) NULL DEFAULT NULL,
  `abreviation` VARCHAR(10) NOT NULL,
  `value` INT(11) NOT NULL,
  `faction` INT(11) NOT NULL,
  `image` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `index2` (`value` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 28
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `pam`.`promotion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pam`.`promotion` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `member_id` INT(11) NOT NULL,
  `rank_value` INT(11) NOT NULL,
  `date` DATE NOT NULL,
  `comment` VARCHAR(200) NULL DEFAULT NULL,
  PRIMARY KEY (`id`, `member_id`, `rank_value`),
  INDEX `fk_promotions_acgmembers1_idx` (`member_id` ASC),
  INDEX `fk_promotion_ranks1_idx` (`rank_value` ASC),
  CONSTRAINT `fk_promotion_ranks1`
    FOREIGN KEY (`rank_value`)
    REFERENCES `pam`.`rank` (`value`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_promotions_acgmembers1`
    FOREIGN KEY (`member_id`)
    REFERENCES `pam`.`acg_member` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1420
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `pam`.`report_detail_lw`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pam`.`report_detail_lw` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `report_id` INT(11) NOT NULL,
  `swarm` INT(11) NOT NULL,
  `swarm_pos` INT(11) NOT NULL,
  PRIMARY KEY (`id`, `report_id`),
  INDEX `fk_reportdetailslw_reports1_idx` (`report_id` ASC),
  CONSTRAINT `fk_reportdetailslw_reports1`
    FOREIGN KEY (`report_id`)
    REFERENCES `pam`.`report` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 5924
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `pam`.`report_detail_raf`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pam`.`report_detail_raf` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `report_id` INT(11) NOT NULL,
  `flight` INT(11) NOT NULL,
  `section` INT(11) NOT NULL,
  `section_pos` INT(11) NOT NULL,
  `serial_no` VARCHAR(10) NULL DEFAULT NULL,
  PRIMARY KEY (`id`, `report_id`),
  INDEX `fk_reportdetailsraf_reports1_idx` (`report_id` ASC),
  CONSTRAINT `fk_reportdetailsraf_reports1`
    FOREIGN KEY (`report_id`)
    REFERENCES `pam`.`report` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 6137
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `pam`.`roster`
-- -----------------------------------------------------
-- CREATE TABLE IF NOT EXISTS `pam`.`roster` (
--   `id` INT(11) NOT NULL AUTO_INCREMENT,
--   `member_id` INT(11) NOT NULL,
--   `deployed_unit_id` INT(11) NOT NULL,
--   `position` INT(11) NOT NULL,
--   `asset_id` INT(11) NOT NULL,
--   `designation` VARCHAR(45) NULL DEFAULT NULL,
--   `image` VARCHAR(45) NULL DEFAULT NULL,
--   PRIMARY KEY (`id`, `member_id`, `deployed_unit_id`),
--   INDEX `fk_roster_acgmembers1_idx` (`member_id` ASC),
--   INDEX `fk_roster_deployed_unit1` (`deployed_unit_id` ASC),
--   CONSTRAINT `fk_roster_acgmembers1`
--     FOREIGN KEY (`member_id`)
--     REFERENCES `pam`.`acg_member` (`id`)
--     ON DELETE NO ACTION
--     ON UPDATE NO ACTION,
--   CONSTRAINT `fk_roster_deployed_unit1`
--     FOREIGN KEY (`deployed_unit_id`)
--     REFERENCES `pam`.`deployed_unit` (`id`)
--     ON DELETE NO ACTION
--     ON UPDATE NO ACTION)
-- ENGINE = InnoDB
-- DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `pam`.`transfer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pam`.`transfer` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `member_id` INT(11) NOT NULL,
  `acg_unit_id` INT(11) NOT NULL,
  `transfer_date_in` DATE NOT NULL,
  `transfer_date_out` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`id`, `member_id`, `acg_unit_id`),
  INDEX `fk_transfers_acgunits1` (`acg_unit_id` ASC),
  INDEX `fk_transfer_acg_member1_idx` (`member_id` ASC),
  CONSTRAINT `fk_transfers_acgunits1`
    FOREIGN KEY (`acg_unit_id`)
    REFERENCES `pam`.`acg_unit` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_transfer_acg_member1`
    FOREIGN KEY (`member_id`)
    REFERENCES `pam`.`acg_member` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 650
DEFAULT CHARACTER SET = latin1;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
