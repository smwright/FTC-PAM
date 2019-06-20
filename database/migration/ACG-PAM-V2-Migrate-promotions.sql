UPDATE `ranks`
SET
`faction` = 1
WHERE `faction` = "LW";

UPDATE `ranks`
SET
`faction` = 2
WHERE `faction` = "RAF";

UPDATE `ranks`
SET
`faction` = 3
WHERE `faction` = "VVS";

INSERT INTO rank
(id, name, abreviation, value, faction, image)
SELECT ranks.id, ranks.name, ranks.abreviation, ranks.value, ranks.faction, ranks.image FROM ranks;


INSERT INTO `promotion`
(`id`,
`member_id`,
`rank_value`,
`promotion_date`,
`comment`)
SELECT `promotions`.`id`,
    `promotions`.`memberID`,
    `promotions`.`value`,
    `promotions`.`date`,
    `promotions`.`comment`
FROM `promotions`;

DROP TABLE promotions;