ALTER TABLE `pam`.`transfers` 
ADD COLUMN `transferDateOut` DATE NULL AFTER `transferDate`;

CALL `pam`.`PAM_update_transfers_date_out`();

INSERT INTO `pam`.`transfer`
(`id`,
`member_id`,
`acg_unit_id`,
`transfer_date_in`,
`transfer_date_out`)
SELECT `transfers`.`id`,
    `transfers`.`memberID`,
    `transfers`.`squadronID`,
    `transfers`.`transferDate`,
    `transfers`.`transferDateOut`
FROM `pam`.`transfers`;




DROP TABLE transfers;