INSERT INTO `campaign`
(`id`,
`name`,
`is_primary`,
`platform`,
`campaign_status`,
`time`,
`open`)
SELECT `campaigns`.`id`,
    `campaigns`.`name`,
    TRUE,
    0,
    2,
    "1900 UTC",
    FALSE    
FROM `campaigns`;

INSERT INTO `campaign`
(`id`,
`name`,
`is_primary`,
`platform`,
`campaign_status`,
`time`,
`open`)
SELECT 10,
    `campaigns`.`name`,
    TRUE,
    0,
    2,
    "1900 UTC",
    FALSE    
FROM `campaigns` WHERE id = 9;

UPDATE `pam`.`campaign`
SET
`name` = "Operation Taifun 2"
WHERE `id` = 9;


INSERT INTO `mission`
(`id`,
`name`,
`campaign_id`,
`real_date`,
`hist_date`,
`mission_status`)
SELECT `missions`.`id`,
    `missions`.`name`,
    `missions`.`campaignID`,
    `missions`.`realDate`,
    `missions`.`histDate`,
    `missions`.`missionStatus`
FROM `missions`;

UPDATE `mission` SET `mission_status` = `mission_status` - 1;
UPDATE `briefings` SET `faction` = 1 WHERE `faction` = 'LW';
UPDATE `briefings` SET `faction` = 2 WHERE `faction` = 'RAF';
UPDATE `briefings` SET `faction` = 3 WHERE `faction` = 'VVS';

DELETE FROM `briefings`
WHERE briefings.missionID NOT IN (SELECT missions.id FROM missions);

INSERT INTO `briefing`
(`id`,
`mission_id`,
`faction`,
`text`)
SELECT 
	`briefings`.`id`,
    `briefings`.`missionID`,
    `briefings`.`faction`,
    `briefings`.`text1`
FROM `briefings`;

-- Add briefings from old missions table

-- Split TYPHOON into three parts
UPDATE `mission` SET `campaign_id` = 7 WHERE id >= 158 AND id <= 163;
UPDATE `mission` SET `campaign_id` = 9 WHERE id >= 177 AND id <= 182;
UPDATE `mission` SET `campaign_id` = campaign_id + 1 WHERE id > 182;

DROP TABLE `briefings`;
DROP TABLE `missions`;
DROP TABLE `missionstatus`;