
DELETE FROM `reports` WHERE reports.authorID  NOT IN (SELECT career_character.id FROM career_character);
DELETE FROM reports WHERE reports.missionID NOT IN (SELECT mission.id FROM mission);
DELETE FROM reports WHERE reports.acceptedBy NOT IN (SELECT acg_member.id FROM acg_member);

INSERT INTO `report`
(`id`,
`mission_id`,
`character_id`,
`deployed_unit_id`,
`base`,
`asset_id`,
`markings`,
`synopsis`,
`asset_status`,
`pilot_status`,
`date_submitted`,
`accepted`,
`accepted_by`)
SELECT `reports`.`id`,
    `reports`.`missionID`,
    `reports`.`authorID`,
    deployed_unit.id,
    `reports`.`aerodrome`,
    `reports`.`aeroplane`,
    `reports`.`markings`,
    `reports`.`synopsis`,
    `reports`.`aeroplaneStatus`,
    `reports`.`pilotStatus`,
    `reports`.`dateSubmitted`,
    `reports`.`accepted`,
    `reports`.`acceptedBy`
FROM `reports`
LEFT JOIN deployed_unit ON deployed_unit.acg_unit_id = reports.squadronID
LEFT JOIN mission ON mission.id = reports.missionID;

UPDATE `report`
SET
`asset_status` = asset_status - 1,
`pilot_status` = pilot_status - 1;

DROP TABLE `reports`;
