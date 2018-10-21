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
  `primary` TINYINT(1) NOT NULL,
  `platform` INT(11) NOT NULL,
  `campaign_status` INT(10) NOT NULL,
  `time` VARCHAR(45) NOT NULL,
  `open` TINYINT(1) NOT NULL,
  `campaign_link` INT(11) NULL DEFAULT NULL,
  `description` VARCHAR(45) NULL DEFAULT NULL,
  `image` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
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
  PRIMARY KEY (`id`, `campaign_id`))
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
  PRIMARY KEY (`id`, `mission_id`))
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
  PRIMARY KEY (`id`, `personified_by`))
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
  `acg_unit_id` INT(11) NULL,
  `hist_unit_id` INT(11) NOT NULL,
  `asset_id` INT(11) NULL DEFAULT NULL,
  `report_type` INT(11) NULL DEFAULT NULL,
  `lft` INT(11) NOT NULL,
  `rgt` INT(11) NOT NULL,
  PRIMARY KEY (`id`, `campaign_id`, `hist_unit_id`),
  INDEX `fk_deployedunits_acgunits1_idx` (`acg_unit_id` ASC),
  INDEX `fk_deployed_unit_asset1_idx` (`asset_id` ASC))
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
  PRIMARY KEY (`id`, `mission_id`, `character_id`, `deployed_unit_id`, `asset_id`))
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
-- Table `pam`.`comment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pam`.`comment` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `report_id` INT(11) NOT NULL,
  `member_id` INT(11) NOT NULL,
  `comment_date` DATE NOT NULL,
  `comment_text` VARCHAR(500) NOT NULL,
  PRIMARY KEY (`id`, `report_id`, `member_id`))
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
  `award_date` DATE NOT NULL,
  `comment` VARCHAR(200) NULL DEFAULT NULL,
  `awarded` TINYINT(1) NOT NULL,
  `awarded_by` INT(11) NULL DEFAULT NULL,
  `recommendation_date` DATE NOT NULL,
  PRIMARY KEY (`id`, `character_id`, `award_id`),
  UNIQUE INDEX `characterID_3` (`character_id` ASC, `award_id` ASC),
  INDEX `characterID` (`character_id` ASC, `award_id` ASC))
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
  `status_date_out` DATE NULL,
  `comment` VARCHAR(200) NULL DEFAULT NULL,
  PRIMARY KEY (`id`, `member_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 1494
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `pam`.`namepool`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pam`.`namepool` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(20) NOT NULL,
  `type` VARCHAR(10) NOT NULL,
  `faction` INT(11) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 1140
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `pam`.`promotion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pam`.`promotion` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `member_id` INT(11) NOT NULL,
  `promotion_date` DATE NOT NULL,
  `rank_value` INT(11) NOT NULL,
  `comment` VARCHAR(200) NULL DEFAULT NULL,
  PRIMARY KEY (`id`, `member_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 1420
DEFAULT CHARACTER SET = latin1;


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
-- Table `pam`.`report_lw`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pam`.`report_lw` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `report_id` INT(11) NOT NULL,
  `swarm` INT(11) NOT NULL,
  `swarm_pos` INT(11) NOT NULL,
  PRIMARY KEY (`id`, `report_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 5924
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `pam`.`report_raf`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pam`.`report_raf` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `report_id` INT(11) NOT NULL,
  `flight` INT(11) NOT NULL,
  `section` INT(11) NOT NULL,
  `section_pos` INT(11) NOT NULL,
  `serial_no` VARCHAR(10) NULL DEFAULT NULL,
  PRIMARY KEY (`id`, `report_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 6137
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `pam`.`roster`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pam`.`roster` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `member_id` INT(11) NOT NULL,
  `deployed_unit_id` INT(11) NOT NULL,
  `position` INT(11) NOT NULL,
  `asset_id` INT(11) NOT NULL,
  `designation` VARCHAR(45) NULL DEFAULT NULL,
  `image` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`, `member_id`, `deployed_unit_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `pam`.`transfer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pam`.`transfer` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `member_id` INT(11) NOT NULL,
  `acg_unit_id` INT(11) NOT NULL,
  `transfer_date_in` DATE NOT NULL,
  `transfer_date_out` DATE NULL,
  PRIMARY KEY (`id`, `member_id`, `acg_unit_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 650
DEFAULT CHARACTER SET = latin1;

USE `pam` ;

-- -----------------------------------------------------
-- function PS_dateFromMission
-- -----------------------------------------------------

DELIMITER $$
USE `pam`$$
CREATE DEFINER=`cl45-acg-pam`@`%` FUNCTION `PS_dateFromMission`(`MissionStartTime` VARCHAR(14)) RETURNS date
    NO SQL
BEGIN

	RETURN CAST(MIN(STR_TO_DATE(MissionStartTime,'%Y%m%d%H%i%S')) AS DATE);

END$$

DELIMITER ;

-- -----------------------------------------------------
-- function PS_getCharacterStatus
-- -----------------------------------------------------

DELIMITER $$
USE `pam`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `PS_getCharacterStatus`(`cID` INT) RETURNS int(11)
    READS SQL DATA
BEGIN

DECLARE status TINYINT(1);

SELECT PAMStatus
INTO status
FROM RP_Flight
WHERE characterID = cID
ORDER BY PS_missionStamp(MissionStartTime, Flight) 
DESC LIMIT 1;

RETURN status;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- function PS_missionStamp
-- -----------------------------------------------------

DELIMITER $$
USE `pam`$$
CREATE DEFINER=`cl45-acg-pam`@`%` FUNCTION `PS_missionStamp`(`mission` VARCHAR(14), `flight` SMALLINT(6)) RETURNS double
    NO SQL
BEGIN
 
IF (mission IS NULL) THEN

  RETURN 0;

ELSE

  RETURN CAST(mission AS DECIMAL(16,2)) + flight/100;

END IF;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure asset_add_node
-- -----------------------------------------------------

DELIMITER $$
USE `pam`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `asset_add_node`(
	IN asset_parent_id INT,
    IN asset_name VARCHAR(45),
    IN asset_faction INT,
    IN asset_controlable BOOLEAN
)
BEGIN

DECLARE my_left INT;
DECLARE my_right INT;

SELECT lft INTO my_left FROM asset WHERE id = asset_parent_id;
    
UPDATE asset SET rgt = rgt + 2 WHERE rgt > my_left;
UPDATE asset SET lft = lft + 2 WHERE lft > my_left;

INSERT INTO asset(`name`, `faction`, `controlable`, `lft`, `rgt`)
VALUES (asset_name, asset_faction, asset_controlable, my_left + 1, my_left + 2);

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure asset_delete_node
-- -----------------------------------------------------

DELIMITER $$
USE `pam`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `asset_delete_node`(
	IN asset_node_id INT
)
BEGIN

DECLARE my_left INT;
DECLARE my_right INT;

SELECT lft, rgt INTO my_left, my_right
FROM asset WHERE id = asset_node_id;

DELETE FROM asset WHERE lft = my_left;

UPDATE asset SET rgt = rgt - 1, lft = lft - 1 WHERE lft BETWEEN my_left AND my_right;
UPDATE asset SET rgt = rgt - 2 WHERE rgt > my_right;
UPDATE asset SET lft = lft - 2 WHERE lft > my_right;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure asset_get_number_of_childs
-- -----------------------------------------------------

DELIMITER $$
USE `pam`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `asset_get_number_of_childs`(
	IN asset_parent INT,
    OUT number_of_children INT
)
BEGIN

SELECT COUNT(result_table.childs) INTO number_of_children FROM
(
	SELECT node.id AS childs, (COUNT(parent.id) - (sub_tree.depth + 1)) AS depth
	FROM asset AS node, asset AS parent, asset AS sub_parent,
	(
		SELECT node.id, (COUNT(parent.id) - 1) AS depth
		FROM asset AS node, asset AS parent
		WHERE node.lft BETWEEN parent.lft AND parent.rgt
		AND node.id = asset_parent
		GROUP BY node.id
	)AS sub_tree

	WHERE node.lft BETWEEN parent.lft AND parent.rgt
	AND node.lft BETWEEN sub_parent.lft AND sub_parent.rgt
	AND sub_parent.id = sub_tree.id
	GROUP BY node.id, sub_tree.depth
	HAVING (COUNT(parent.id) - (sub_tree.depth + 1)) = 1
)AS result_table;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure asset_get_tree
-- -----------------------------------------------------

DELIMITER $$
USE `pam`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `asset_get_tree`(IN nsm_parent VARCHAR(100))
BEGIN

SELECT node.name
FROM asset AS node, asset AS parent
WHERE node.lft BETWEEN parent.lft AND parent.rgt
AND parent.name = nsm_parent
ORDER BY node.lft;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure asset_move_node
-- -----------------------------------------------------

DELIMITER $$
USE `pam`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `asset_move_node`(
	IN asset_node_id INT,
    IN asset_parent_id INT
)
BEGIN

DECLARE number_of_childs INT;
DECLARE my_left INT;
DECLARE my_right INT;

SELECT lft, rgt INTO my_left, my_right 
FROM asset WHERE id = asset_node_id;

UPDATE asset SET rgt = 0, lft = 0 WHERE id = asset_node_id;
UPDATE asset SET rgt = rgt - 1, lft = lft - 1 WHERE lft BETWEEN my_left AND my_right;
UPDATE asset SET rgt = rgt - 2 WHERE rgt > my_right;
UPDATE asset SET lft = lft - 2 WHERE lft > my_right;

CALL `asset_get_number_of_childs`(asset_parent_id, number_of_childs);
IF number_of_childs > 0 THEN
	
	SELECT rgt INTO my_right FROM asset WHERE id = asset_parent_id;
	-- If parent has already children
	UPDATE asset SET rgt = rgt + 2 WHERE rgt > my_right;
	UPDATE asset SET lft = lft + 2 WHERE lft > my_right;
	UPDATE asset SET lft = my_right + 1, rgt = my_right + 2 WHERE id = asset_node_id;

ELSE

	SELECT lft INTO my_left FROM asset WHERE id = asset_parent_id;
	-- If parent has already children
	UPDATE asset SET rgt = rgt + 2 WHERE rgt > my_left;
	UPDATE asset SET lft = lft + 2 WHERE lft > my_left;
	UPDATE asset SET lft = my_left + 1, rgt = my_left + 2 WHERE id = asset_node_id;

END IF;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure depl_unit_add_node
-- -----------------------------------------------------

DELIMITER $$
USE `pam`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `depl_unit_add_node`(
	IN depl_unit_parent_id INT,
    IN depl_unit_campaign_id INT,
    IN depl_acg_unit_id INT,
    IN depl_hist_unit_id INT,
    IN depl_asset_id INT,
    IN depl_report_type INT
)
BEGIN

DECLARE my_left INT;
DECLARE my_right INT;

SELECT IFNULL((SELECT lft FROM deployed_unit WHERE id = depl_unit_parent_id AND campaign_id = depl_unit_campaign_id), 0) INTO my_left;
   
UPDATE deployed_unit SET rgt = rgt + 2 WHERE rgt > my_left AND campaign_id = depl_unit_campaign_id;
UPDATE deployed_unit SET lft = lft + 2 WHERE lft > my_left AND campaign_id = depl_unit_campaign_id;

INSERT INTO deployed_unit(`campaign_id`, `acg_unit_id`, `hist_unit_id`, `asset_id`, `report_type`, `lft`, `rgt`)
VALUES (depl_unit_campaign_id, depl_acg_unit_id, depl_hist_unit_id, depl_asset_id, depl_report_type,  my_left + 1, my_left + 2);

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure depl_unit_get_number_of_childs
-- -----------------------------------------------------

DELIMITER $$
USE `pam`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `depl_unit_get_number_of_childs`(
	IN depl_campaign_id INT,
    IN unit_parent INT,
    OUT number_of_children INT
)
BEGIN

SELECT COUNT(result_table.childs) INTO number_of_children FROM
(
	SELECT node.id AS childs, (COUNT(parent.id) - (sub_tree.depth + 1)) AS depth
	FROM deployed_unit AS node, deployed_unit AS parent, deployed_unit AS sub_parent,
	(
		SELECT node.id, (COUNT(parent.id) - 1) AS depth
		FROM deployed_unit AS node, deployed_unit AS parent
		WHERE node.lft BETWEEN parent.lft AND parent.rgt
		AND node.id = unit_parent AND node.campaign_id = depl_campaign_id
		GROUP BY node.id
	)AS sub_tree

	WHERE node.lft BETWEEN parent.lft AND parent.rgt
	AND node.lft BETWEEN sub_parent.lft AND sub_parent.rgt
	AND sub_parent.id = sub_tree.id
	GROUP BY node.id, sub_tree.depth
	HAVING (COUNT(parent.id) - (sub_tree.depth + 1)) = 1
)AS result_table;
END$$

DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
