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