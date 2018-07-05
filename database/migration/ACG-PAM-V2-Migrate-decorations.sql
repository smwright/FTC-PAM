DELETE FROM decorations WHERE decorations.characterID NOT IN (SELECT career_character.id FROM career_character);

INSERT INTO `decoration`
(`id`,
`character_id`,
`award_id`,
`date`,
`comment`,
`awarded`,
`awarded_by`,
`recommendation_date`)
SELECT `decorations`.`id`,
    `decorations`.`characterID`,
    `decorations`.`awardID`,
    `decorations`.`date`,
    `decorations`.`comment`,
    `decorations`.`awarded`,
    `decorations`.`awardedBy`,
    `decorations`.`availableSince`
FROM `decorations`;

DROP TABLE decorations;