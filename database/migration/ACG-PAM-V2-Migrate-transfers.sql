INSERT INTO `transfer`
(`id`,
`member_id`,
`acg_unit_id`,
`transfer_date`)
SELECT `transfers`.`id`,
    `transfers`.`memberID`,
    `transfers`.`squadronID`,
    `transfers`.`transferDate`
FROM `transfers`;

DROP TABLE transfers;