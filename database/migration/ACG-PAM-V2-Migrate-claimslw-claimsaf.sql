DELETE FROM claimslw WHERE claimslw.reportID NOT IN (SELECT report.id FROM report);
UPDATE `claimslw` SET `aeroplane` = 11 WHERE `aeroplane` = 32;

INSERT INTO `claim_lw`
(`id`,
`report_id`,
`asset_id`,
`claim_time`,
`place`,
`opponent`,
`type_of_destruction`,
`type_of_impact`,
`fate_of_crew`,
`witness`,
`confirmed`,
`accepted`)
SELECT `claimslw`.`id`,
    `claimslw`.`reportID`,
    `claimslw`.`aeroplane`,
    `claimslw`.`claimTime`,
    `claimslw`.`place`,
    `claimslw`.`opponent`,
    `claimslw`.`typeofDestr`,
    `claimslw`.`typeofImpact`,
    `claimslw`.`fateofCrew`,
    `claimslw`.`witness`,
    `claimslw`.`confirmed`,
    `claimslw`.`accepted`
FROM `claimslw`;

DROP TABLE `claimslw`;

DELETE FROM claimsraf WHERE claimsraf.reportID NOT IN (SELECT report.id FROM report);

INSERT INTO `claim_raf`
(`id`,
`report_id`,
`asset_id`,
`enemy_status`,
`shared`,
`description`,
`accepted`)
SELECT `claimsraf`.`id`,
	`claimsraf`.`reportID`,
    `claimsraf`.`aeroplane`,
    `claimsraf`.`enemyStatus`,
    `claimsraf`.`shared`,
    `claimsraf`.`description`,
    `claimsraf`.`accepted`
FROM `claimsraf`;

DROP TABLE `claimsraf`;

UPDATE `claim_raf` SET `enemy_status` = `enemy_status` + 1;
UPDATE `claim_lw` SET `type_of_destruction` = `type_of_destruction` + 1;
UPDATE `claim_lw` SET `type_of_impact` = `type_of_impact` + 1;
UPDATE `claim_lw` SET `fate_of_crew` = `fate_of_crew` + 1;

DROP TABLE claimstatusraf;
DROP TABLE fateofcrew;
DROP TABLE typeofdestr;
DROP TABLE typeofimpact;