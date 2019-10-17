DELETE FROM transfers WHERE transfers.memberID NOT IN (SELECT acg_member.id FROM acg_member);
-- DELETE FROM transfers WHERE transfers.squadronID NOT IN (SELECT acg_unit.id FROM acg_unit);
-- UPDATING transfers.squadronsIDs WITH acg_unit ID's.
-- UPDATE transfers SET transfers.squadronID = (SELECT squadrons.acg_unit FROM squadrons WHERE squadrons.id = transfers.squadronID) WHERE squadronID > 17;

-- '2', 'No.501', 'SD', 'RAF', '5', NULL
-- '3', 'No.64', 'SH', 'RAF', '2', '0'
-- '4', 'No.615', 'KW', 'RAF', '7', NULL
-- '5', '4./JG26', '---  white', 'LW', '2', NULL
-- '6', '5./JG26', '---  black', 'LW', '3', NULL
-- '7', '6./JG26', '--- brown', 'LW', '4', '0'
-- '8', '7./JG26', '|  white', 'LW', '5', NULL
-- '9', '6./ZG76', 'M8 _P', 'LW', '7', NULL
-- '10', 'No.111', 'JU', 'RAF', '3', NULL
-- '11', 'Stab/JG26', '< A O ---', 'LW', '1', NULL
-- '12', 'No.610', 'DW', 'RAF', '6', NULL
-- '13', '8./JG26', '| black', 'LW', '6', NULL
-- '14', 'No.32', 'GZ', 'RAF', '1', NULL
-- '15', 'No.302', 'WX', 'RAF', '4', NULL
-- '16', '9./JG26', '| yellow', 'LW', '0', NULL
-- '17', '1./JG26', 'white', 'LW', '0', NULL

-- '176', '2019-02-17'
-- '177', '2019-03-10'

-- '182', '2019-04-14'
-- '183', '2019-05-05'

-- '188', '2019-06-09'
-- '190', '2019-06-30'

-- '195', '2019-08-11'
-- '196', '2019-09-01'

-- '201', '2019-10-06'



-- unit 18 -> 610
UPDATE transfers SET transfers.squadronID = 12 WHERE squadronID = 18;
-- unit 19 -> 8th
UPDATE transfers SET transfers.squadronID = 13 WHERE squadronID = 19;
-- unit 20 -> 6th
UPDATE transfers SET transfers.squadronID = 7 WHERE squadronID = 20;
-- unit 21 -> ZG
UPDATE transfers SET transfers.squadronID = 9 WHERE squadronID = 21;
-- unit 22 -> 111
UPDATE transfers SET transfers.squadronID = 10 WHERE squadronID = 22;
-- unit 23 -> stab
UPDATE transfers SET transfers.squadronID = 11 WHERE squadronID = 23;
-- unit 24 -> 615
UPDATE transfers SET transfers.squadronID = 4 WHERE squadronID = 24;
-- unit 25 -> 501
UPDATE transfers SET transfers.squadronID = 2 WHERE squadronID = 25;
-- unit 26 -> 5th
UPDATE transfers SET transfers.squadronID = 6 WHERE squadronID = 26;
-- unit 27 -> 7th
UPDATE transfers SET transfers.squadronID = 8 WHERE squadronID = 27;
-- unit 28 -> 32
UPDATE transfers SET transfers.squadronID = 14 WHERE squadronID = 28;
-- unit 29 -> 64
UPDATE transfers SET transfers.squadronID = 3 WHERE squadronID = 29;
-- unit 30 -> 4th
UPDATE transfers SET transfers.squadronID = 5 WHERE squadronID = 30;
-- unit 32 -> 1st
UPDATE transfers SET transfers.squadronID = 17 WHERE squadronID = 32;
-- unit 33 -> 9th
UPDATE transfers SET transfers.squadronID = 16 WHERE squadronID = 33;
-- unit 34 -> 8th
UPDATE transfers SET transfers.squadronID = 13 WHERE squadronID = 34;
-- unit 35 -> 7th
UPDATE transfers SET transfers.squadronID = 8 WHERE squadronID = 35;

-- '176', '2019-02-17'
-- '177', '2019-03-10'

-- '182', '2019-04-14'
-- '183', '2019-05-05'

-- '188', '2019-06-09'
-- '190', '2019-06-30'

-- '195', '2019-08-11'
-- '196', '2019-09-01'

-- '201', '2019-10-06'

-- unit 36 -> 1st (Mission 177 to 182) 
UPDATE transfers SET transfers.squadronID = 17 WHERE squadronID = 36 AND transfers.transferDate >= '2019-02-17' AND transfers.transferDate < '2019-04-14';
--         -> 6th (Mission 183 to 188) 
UPDATE transfers SET transfers.squadronID = 7 WHERE squadronID = 36 AND transfers.transferDate >= '2019-04-14' AND transfers.transferDate < '2019-06-09';
--         -> 9th (Mission 190 to 195) 
UPDATE transfers SET transfers.squadronID = 16 WHERE squadronID = 36 AND transfers.transferDate >= '2019-06-09' AND transfers.transferDate < '2019-08-11';
--         -> 5th (Mission 196 to 201)
UPDATE transfers SET transfers.squadronID = 6 WHERE squadronID = 36 AND transfers.transferDate >= '2019-08-11';




-- unit 37 -> stab
UPDATE transfers SET transfers.squadronID = 11 WHERE squadronID = 37;




-- unit 38 -> 64th (Mission 183 to 188) 
UPDATE transfers SET transfers.squadronID = 3 WHERE squadronID = 38 AND transfers.transferDate < '2019-06-09';
--         -> 32th (Mission 190 to 195) 
UPDATE transfers SET transfers.squadronID = 14 WHERE squadronID = 38 AND transfers.transferDate >= '2019-06-09' AND transfers.transferDate < '2019-08-11';
--         -> 5th (Mission 196 to 201)
UPDATE transfers SET transfers.squadronID = 12 WHERE squadronID = 38 AND transfers.transferDate >= '2019-08-11';



-- unit 39 -> 1st
UPDATE transfers SET transfers.squadronID = 17 WHERE squadronID = 39;
-- unit 40 -> 8th
UPDATE transfers SET transfers.squadronID = 13 WHERE squadronID = 40;
-- unit 41 -> 6th
UPDATE transfers SET transfers.squadronID = 7 WHERE squadronID = 41;
-- unit 42 -> 5th
UPDATE transfers SET transfers.squadronID = 6 WHERE squadronID = 42;
-- unit 43 -> 4th
UPDATE transfers SET transfers.squadronID = 5 WHERE squadronID = 43;


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

CALL `PAM_update_transfer_date_out`();
-- DROP TABLE transfers;

DROP TEMPORARY TABLE transfersUpdate;
CREATE TEMPORARY TABLE transfersUpdate
SELECT B.id AS toDelete, A.id AS toNull
FROM 
transfer AS A,
transfer AS B
WHERE A.member_id = B.member_id AND A.transfer_date_out = B.transfer_date_in AND A.acg_unit_id = B.acg_unit_id;

DELETE FROM transfer WHERE transfer.id IN (SELECT transfersUpdate.toDelete FROM transfersUpdate);
UPDATE transfer SET transfer.transfer_date_out = NULL WHERE transfer.id IN (SELECT transfersUpdate.toNull FROM transfersUpdate);

