DELETE FROM `claimslw` WHERE `claimslw`.`reportID` NOT IN (SELECT `report`.`id` FROM `report`);
UPDATE `claimslw` SET `aeroplane` = 10 WHERE `aeroplane` = 32;

INSERT INTO `claim`
(`id`,
`report_id`,
`asset_id`,
`accepted`)
SELECT `claimslw`.`id`, 
	`claimslw`.`reportID`,
    `claimslw`.`aeroplane`,
    `claimslw`.`accepted`
FROM `claimslw`;

INSERT INTO `pam`.`claim_lw`
(`id`,
`claim_id`,
`claim_time`,
`place`,
`opponent`,
`type_of_destruction`,
`type_of_impact`,
`fate_of_crew`,
`witness`,
`confirmed`)
SELECT `claimslw`.`id`,
    `claimslw`.`id`,
    `claimslw`.`claimTime`,
    `claimslw`.`place`,
    `claimslw`.`opponent`,
    `claimslw`.`typeofDestr`,
    `claimslw`.`typeofImpact`,
    `claimslw`.`fateofCrew`,
    `claimslw`.`witness`,
    `claimslw`.`confirmed`
FROM `claimslw`;

SET @last_id = (SELECT MAX(id) FROM claim);
DELETE FROM claimsraf WHERE claimsraf.reportID NOT IN (SELECT report.id FROM report);

INSERT INTO `claim`
(`id`,
`report_id`,
`asset_id`,
`description`,
`accepted`)
SELECT `claimsraf`.`id` + @last_id,
	`claimsraf`.`reportID`,
    `claimsraf`.`aeroplane`,
    `claimsraf`.`description`,
    `claimsraf`.`accepted`
FROM `claimsraf`;

INSERT INTO `pam`.`claim_raf`
(`id`,
`claim_id`,
`enemy_status`,
`shared`)
SELECT `claimsraf`.`id` + @last_id,
	`claimsraf`.`id` + @last_id,
    `claimsraf`.`enemyStatus`,
    `claimsraf`.`shared`
FROM `claimsraf`;

UPDATE `claim_raf` SET `enemy_status` = `enemy_status` + 1;
UPDATE `claim_lw` SET `type_of_destruction` = `type_of_destruction` + 1;
UPDATE `claim_lw` SET `type_of_impact` = `type_of_impact` + 1;
UPDATE `claim_lw` SET `fate_of_crew` = `fate_of_crew` + 1;

CALL `asset_add_node`(0, 'Structure', 0, FALSE); -- 51
CALL `asset_add_node`(0, 'Vehicle', 0, FALSE); -- 52 
CALL `asset_add_node`(0, 'Ship', 0, FALSE); -- 53
CALL `asset_add_node`(51, 'Hangar', 0, FALSE); -- 54
CALL `asset_add_node`(51, 'Supplies', 0, FALSE); -- 55
CALL `asset_add_node`(51, 'Facility', 0, FALSE); -- 56
CALL `asset_add_node`(52, 'Armour', 0, FALSE); -- 57
CALL `asset_add_node`(52, 'Artillery', 0, FALSE); -- 58
CALL `asset_add_node`(52, 'Truck', 0, FALSE); -- 59
CALL `asset_add_node`(52, 'Car', 0, FALSE); -- 60
CALL `asset_add_node`(52, 'Aircraft', 0, FALSE); -- 61

SET @last_id = (SELECT MAX(id) FROM claim);

INSERT INTO `pam`.`claim`
(`id`,
`report_id`,
`asset_id`,
`description`,
`accepted`)
SELECT `claimsground`.`id` + @last_id,
	`claimsground`.`reportID`,
    `claimsground`.`object`,
    `claimsground`.`description`,
    `claimsground`.`accepted`
FROM `claimsground`;

INSERT INTO `pam`.`claim_ground`
(`id`,
`claim_id`,
`amount`)
SELECT `claimsground`.`id` + @last_id,
	`claimsground`.`id` + @last_id,
    `claimsground`.`amount`
FROM `claimsground`;

-- old-id -> new-id
-- 9 -> '53', 'Ship', '0', '0', '2', '3'
-- 2 -> '54', 'Hangar', '0', '0', '21', '22'
-- 3 -> '55', 'Supplies', '0', '0', '19', '20'
-- 4 -> '56', 'Facility', '0', '0', '17', '18'
-- 5 -> '57', 'Armour', '0', '0', '13', '14'
-- 6 -> '58', 'Artillery', '0', '0', '11', '12'
-- 7 -> '59', 'Truck', '0', '0', '9', '10'
-- 8 -> '60', 'Car', '0', '0', '7', '8'
-- 10 -> '61', 'Aircraft', '0', '0', '5', '6'

UPDATE `claim` SET `asset_id` = 53 WHERE `asset_id` = 9 AND `claim`.`id` > @last_id;
UPDATE `claim` SET `asset_id` = 54 WHERE `asset_id` = 2 AND `claim`.`id` > @last_id;
UPDATE `claim` SET `asset_id` = 55 WHERE `asset_id` = 3 AND `claim`.`id` > @last_id;
UPDATE `claim` SET `asset_id` = 56 WHERE `asset_id` = 4 AND `claim`.`id` > @last_id;
UPDATE `claim` SET `asset_id` = 57 WHERE `asset_id` = 5 AND `claim`.`id` > @last_id;
UPDATE `claim` SET `asset_id` = 58 WHERE `asset_id` = 6 AND `claim`.`id` > @last_id;
UPDATE `claim` SET `asset_id` = 59 WHERE `asset_id` = 7 AND `claim`.`id` > @last_id;
UPDATE `claim` SET `asset_id` = 60 WHERE `asset_id` = 8 AND `claim`.`id` > @last_id;
UPDATE `claim` SET `asset_id` = 61 WHERE `asset_id` = 10 AND `claim`.`id` > @last_id;