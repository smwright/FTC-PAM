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

DELETE FROM claimsground WHERE claimsground.reportID NOT IN (SELECT id FROM report);

INSERT INTO `claim_ground`
(`id`,
`report_id`,
`asset_id`,
`amount`,
`description`,
`accepted`)
SELECT `claimsground`.`id`,
	`claimsground`.`reportID`,
    `claimsground`.`object`,
    `claimsground`.`amount`,
    `claimsground`.`description`,
    `claimsground`.`accepted`
FROM `claimsground`;

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

UPDATE `claim_ground` SET `asset_id` = 2 + @max_id WHERE `asset_id` = 2;
UPDATE `claim_ground` SET `asset_id` = 3 + @max_id WHERE `asset_id` = 3;
UPDATE `claim_ground` SET `asset_id` = 4 + @max_id WHERE `asset_id` = 4;
UPDATE `claim_ground` SET `asset_id` = 5 + @max_id WHERE `asset_id` = 5;
UPDATE `claim_ground` SET `asset_id` = 6 + @max_id WHERE `asset_id` = 6;
UPDATE `claim_ground` SET `asset_id` = 7 + @max_id WHERE `asset_id` = 7;
UPDATE `claim_ground` SET `asset_id` = 8 + @max_id WHERE `asset_id` = 8;
UPDATE `claim_ground` SET `asset_id` = 9 + @max_id WHERE `asset_id` = 9;
UPDATE `claim_ground` SET `asset_id` = 10 + @max_id WHERE `asset_id` = 10;
UPDATE `claim_ground` SET `asset_id` = 11 + @max_id WHERE `asset_id` = 11;
UPDATE `claim_ground` SET `asset_id` = 12 + @max_id WHERE `asset_id` = 12;

DROP TABLE `claimsground`;
DROP TABLE `groundtargets`;