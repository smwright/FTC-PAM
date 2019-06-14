DELETE FROM transfers WHERE transfers.memberID NOT IN (SELECT acg_member.id FROM acg_member);
DELETE FROM transfers WHERE transfers.squadronID NOT IN (SELECT acg_unit.id FROM acg_unit);
-- UPDATING transfers.squadronsIDs WITH acg_unit ID's.
UPDATE transfers SET transfers.squadronID = (SELECT squadrons.acg_unit FROM squadrons WHERE squadrons.id = transfers.squadronID) WHERE squadronID > 17;

INSERT INTO `transfer`
(`id`,
`member_id`,
`acg_unit_id`,
`transfer_date_in`)
SELECT `transfers`.`id`,
    `transfers`.`memberID`,
    `transfers`.`squadronID`,
    `transfers`.`transferDate`
FROM `transfers`;

CALL `pam`.`PAM_update_transfer_date_out`();
DROP TABLE transfers;

DROP TEMPORARY TABLE transfersUpdate;
CREATE TEMPORARY TABLE transfersUpdate
SELECT B.id AS toDelete, A.id AS toNull
FROM 
transfer AS A,
transfer AS B
WHERE A.member_id = B.member_id AND A.transfer_date_out = B.transfer_date_in AND A.acg_unit_id = B.acg_unit_id;

DELETE FROM transfer WHERE transfer.id IN (SELECT transfersUpdate.toDelete FROM transfersUpdate);
UPDATE transfer SET transfer.transfer_date_out = NULL WHERE transfer.id IN (SELECT transfersUpdate.toNull FROM transfersUpdate);

