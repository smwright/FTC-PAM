DELETE FROM `reports` WHERE reports.authorID  NOT IN (SELECT career_character.id FROM career_character);
DELETE FROM reports WHERE reports.missionID NOT IN (SELECT mission.id FROM mission);
DELETE FROM reports WHERE reports.acceptedBy NOT IN (SELECT acg_member.id FROM acg_member);

-- Updating campaign_id in mission. This is needed to accomodate the unit changes during the typhoon campaign. 
UPDATE mission SET campaign_id = 7 WHERE id >= 158;
UPDATE mission SET campaign_id = 8 WHERE id >= 165;
UPDATE mission SET campaign_id = 9 WHERE id >= 177;
UPDATE mission SET campaign_id = 10 WHERE id >= 183;

-- Correction of report.squadronID because of additional BoB historical units
-- UPDATE reports SET squadronID = squadronID + 7 WHERE squadronID > 17

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
SELECT
`reports`.`id`,
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
FROM reports
LEFT JOIN mission ON reports.missionID = mission.id
LEFT JOIN deployed_unit ON reports.squadronID = deployed_unit.hist_unit_id
WHERE mission.campaign_id = deployed_unit.campaign_id;


UPDATE `report`
SET
`asset_status` = asset_status - 1,
`pilot_status` = pilot_status - 1;

-- Moving reports from 8th in campaign 10 to correct unit
UPDATE `pam`.`report`
SET
`deployed_unit_id` = 40
WHERE `mission_id` = 183 AND `deployed_unit_id` = 19;


DROP TABLE `reports`;