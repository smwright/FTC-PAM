DELETE FROM memberstatuslog WHERE memberstatuslog.memberID NOT IN (SELECT acg_member.id FROM acg_member);

INSERT INTO `member_status_log`
(`id`,
`member_id`,
`member_status`,
`status_date_in`,
`comment`)
SELECT `memberstatuslog`.`id`,
    `memberstatuslog`.`memberID`,
    `memberstatuslog`.`statusID`,
    `memberstatuslog`.`date`,
    `memberstatuslog`.`comment`
FROM `memberstatuslog`;


CALL `PAM_update_status_date_out`();

UPDATE `member_status_log` SET `member_status` = `member_status` - 1;
DROP TABLE memberstatus;
DROP TABLE memberstatuslog;
