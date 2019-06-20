#------------------------------------------------------
# Migrate claims 
DELETE FROM `claimslw` WHERE `claimslw`.`reportID` NOT IN (SELECT `report`.`id` FROM `report`);
-- Rasigning id's from second Tiger Moth to first Tiger Moth
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

INSERT INTO `claim_lw`
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

INSERT INTO `claim_raf`
(`id`,
`claim_id`,
`enemy_status`,
`shared`)
SELECT `claimsraf`.`id`,
	`claimsraf`.`id` + @last_id,
    `claimsraf`.`enemyStatus`,
    `claimsraf`.`shared`
FROM `claimsraf`;

SET @last_id = (SELECT MAX(id) FROM claim);
DELETE FROM claimsvvs WHERE claimsvvs.reportID NOT IN (SELECT report.id FROM report);
UPDATE claimsvvs SET accepted = 0 WHERE accepted IS NULL;

INSERT INTO `claim`
(`id`,
`report_id`,
`asset_id`,
`description`,
`accepted`)
SELECT `claimsvvs`.`id` + @last_id, 
	`claimsvvs`.`reportID`,
    `claimsvvs`.`aeroplane`,
    `claimsvvs`.`description`,
    `claimsvvs`.`accepted`
FROM `claimsvvs`;

INSERT INTO `claim_vvs`
(`id`,
`claim_id`,
`claim_time`,
`place`,
`group_claim`,
`witness`,
`confirmed`)
SELECT `claimsvvs`.`id`,
    `claimsvvs`.`id` + @last_id,
    `claimsvvs`.`claimTime`,
    `claimsvvs`.`place`,
    `claimsvvs`.`groupClaim`,
    `claimsvvs`.`witness`,
    `claimsvvs`.`confirmed`
FROM `claimsvvs`;

UPDATE `claim_raf` SET `enemy_status` = `enemy_status` - 1;
UPDATE `claim_lw` SET `type_of_destruction` = `type_of_destruction` - 1;
UPDATE `claim_lw` SET `type_of_impact` = `type_of_impact` - 1;
UPDATE `claim_lw` SET `fate_of_crew` = `fate_of_crew` - 1;

-- '2', 'Hangar'
-- '3', 'Supplies'
-- '4', 'Facility'
-- '5', 'Armour'
-- '6', 'Artillery'
-- '7', 'Truck'
-- '8', 'Car'
-- '9', 'Ship'
-- '10', 'Aircraft'
-- '11', 'Train Carriage'
-- '12', 'Enplacement'

SELECT MAX(id) INTO @max_id FROM asset;
SELECT MAX(rgt) INTO @position FROM asset;
INSERT INTO `asset`
(id, name, faction, controlable, lft, rgt)
SELECT id + @max_id, name, 0, 0, (@position := @position + 1), (@position := @position + 1)  FROM groundtargets;

SET @last_id = (SELECT MAX(id) FROM claim);
DELETE FROM claimsground WHERE claimsground.reportID NOT IN (SELECT id FROM report);

UPDATE `claimsground` SET `object` = 2 + @max_id WHERE `object` = 2;
UPDATE `claimsground` SET `object` = 3 + @max_id WHERE `object` = 3;
UPDATE `claimsground` SET `object` = 4 + @max_id WHERE `object` = 4;
UPDATE `claimsground` SET `object` = 5 + @max_id WHERE `object` = 5;
UPDATE `claimsground` SET `object` = 6 + @max_id WHERE `object` = 6;
UPDATE `claimsground` SET `object` = 7 + @max_id WHERE `object` = 7;
UPDATE `claimsground` SET `object` = 8 + @max_id WHERE `object` = 8;
UPDATE `claimsground` SET `object` = 9 + @max_id WHERE `object` = 9;
UPDATE `claimsground` SET `object` = 10 + @max_id WHERE `object` = 10;
UPDATE `claimsground` SET `object` = 11 + @max_id WHERE `object` = 11;
UPDATE `claimsground` SET `object` = 12 + @max_id WHERE `object` = 12;

INSERT INTO `claim`
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

INSERT INTO `claim_ground`
(`id`,
`claim_id`,
`amount`)
SELECT `claimsground`.`id` + @last_id,
	`claimsground`.`id` + @last_id,
    `claimsground`.`amount`
FROM `claimsground`;

DROP TABLE `claimsground`;
DROP TABLE `groundtargets`;
