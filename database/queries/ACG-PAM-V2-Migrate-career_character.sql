INSERT INTO `career_character`
(`id`,
`personified_by`,
`first_name`,
`last_name`)
SELECT `careercharacters`.`id`,
    `careercharacters`.`personifiedBy`,
    `careercharacters`.`firstName`,
    `careercharacters`.`lastName`
FROM `careercharacters`;

DROP TABLE `careercharacters`;
DROP TABLE `characterstatus`;