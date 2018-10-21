DELETE FROM memberstatuslog WHERE memberstatuslog.memberID NOT IN (SELECT acg_member.id FROM acg_member);
ALTER TABLE `pam`.`memberstatuslog` 
ADD COLUMN `dateOut` DATE NULL AFTER `comment`;

CALL `pam`.`PAM_update_status_date_out`();

INSERT INTO `pam`.`member_status_log`
(`id`,
`member_id`,
`member_status`,
`status_date_in`,
`status_date_out`,
`comment`)
SELECT `memberstatuslog`.`id`,
    `memberstatuslog`.`memberID`,
    `memberstatuslog`.`statusID`,
    `memberstatuslog`.`date`,
    `memberstatuslog`.`dateOut`,
    `memberstatuslog`.`comment`
FROM `pam`.`memberstatuslog`;


UPDATE `member_status_log` SET `member_status` = `member_status` - 1;
DROP TABLE memberstatus;
DROP TABLE memberstatuslog;
