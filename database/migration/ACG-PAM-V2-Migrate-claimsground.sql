
CALL `asset_add_node`(0, 'Structure', 0, FALSE);
CALL `asset_add_node`(0, 'Vehicle', 0, FALSE);
-- '9', 'Ship'
CALL `asset_add_node`(0, 'Ship', 0, FALSE);

-- '55', 'Structure', '0', '0', '6', '7'
-- '56', 'Vehicle', '0', '0', '4', '5'
-- '57', 'Ship', '0', '0', '2', '3'

-- '2', 'Hangar'
CALL `asset_add_node`(55, 'Hangar', 0, FALSE);
-- '3', 'Supplies'
CALL `asset_add_node`(55, 'Supplies', 0, FALSE);
-- '4', 'Facility'
CALL `asset_add_node`(55, 'Facility', 0, FALSE);
-- '5', 'Armour'
CALL `asset_add_node`(56, 'Armour', 0, FALSE);
-- '6', 'Artillery'
CALL `asset_add_node`(56, 'Artillery', 0, FALSE);
-- '7', 'Truck'
CALL `asset_add_node`(56, 'Truck', 0, FALSE);
-- '8', 'Car'
CALL `asset_add_node`(56, 'Car', 0, FALSE);
-- '10', 'Aircraft'
CALL `asset_add_node`(56, 'Aircraft', 0, FALSE);


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

-- old-id -> new-id
-- 9 -> '57', 'Ship', '0', '0', '2', '3'
-- 2 -> '58', 'Hangar', '0', '0', '21', '22'
-- 3 -> '59', 'Supplies', '0', '0', '19', '20'
-- 4 -> '60', 'Facility', '0', '0', '17', '18'
-- 5 -> '61', 'Armour', '0', '0', '13', '14'
-- 6 -> '62', 'Artillery', '0', '0', '11', '12'
-- 7 -> '63', 'Truck', '0', '0', '9', '10'
-- 8 -> '64', 'Car', '0', '0', '7', '8'
-- 10 -> '65', 'Aircraft', '0', '0', '5', '6'

UPDATE `claim_ground` SET `asset_id` = 57 WHERE `asset_id` = 9;
UPDATE `claim_ground` SET `asset_id` = 58 WHERE `asset_id` = 2;
UPDATE `claim_ground` SET `asset_id` = 59 WHERE `asset_id` = 3;
UPDATE `claim_ground` SET `asset_id` = 60 WHERE `asset_id` = 4;
UPDATE `claim_ground` SET `asset_id` = 61 WHERE `asset_id` = 5;
UPDATE `claim_ground` SET `asset_id` = 62 WHERE `asset_id` = 6;
UPDATE `claim_ground` SET `asset_id` = 63 WHERE `asset_id` = 7;
UPDATE `claim_ground` SET `asset_id` = 64 WHERE `asset_id` = 8;
UPDATE `claim_ground` SET `asset_id` = 65 WHERE `asset_id` = 10;

DROP TABLE `claimsground`;
DROP TABLE `groundtargets`;