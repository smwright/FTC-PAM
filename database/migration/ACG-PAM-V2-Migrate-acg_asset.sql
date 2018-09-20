-- Restart table count 
ALTER TABLE asset  AUTO_INCREMENT = 1;

-- Insert asset root and update id to 0
INSERT INTO `asset`(`id`,`name`,`faction`,`controlable`,`lft`,`rgt`)
VALUES(0,'acg-assets',0,0,1,2);
UPDATE asset SET id = 0 WHERE id = 1;

-- Reset table count again
ALTER TABLE asset  AUTO_INCREMENT = 1;


-- faction status: 0-None, 1-LW, 2-RAF 
CALL `asset_add_node`(0, 'Hawker Hurricane I DH5-20', 2, TRUE);
CALL `asset_add_node`(0, 'Hawker Hurricane I DH5-20 100 OCT', 2, TRUE);
CALL `asset_add_node`(0, 'Hawker Hurricane IA Rotol', 2, TRUE);
CALL `asset_add_node`(0, 'Hawker Hurricane IA Rotol 100 OCT', 2, TRUE);
CALL `asset_add_node`(0, 'Hawker Hurricane IA Rotol 100 OCT', 2, TRUE);
CALL `asset_add_node`(0, 'Supermarine Spitfire MK I', 2, TRUE);
CALL `asset_add_node`(0, 'Supermarine Spitfire MK I 100 OCT', 2, TRUE);
CALL `asset_add_node`(0, 'Supermarine Spitfire IA', 2, TRUE);
CALL `asset_add_node`(0, 'Supermarine Spitfire IA 100 OCT', 2, TRUE);
CALL `asset_add_node`(0, 'Supermarine Spitfire IIA', 2, TRUE);
CALL `asset_add_node`(0, 'Tiger Moth', 2, TRUE);
CALL `asset_add_node`(0, 'BF 109 E-1', 1, TRUE);
CALL `asset_add_node`(0, 'BF 109 E-3', 1, TRUE);
CALL `asset_add_node`(0, 'BF 109 E-3/B', 1, TRUE);
CALL `asset_add_node`(0, 'BF 109 E-4', 1, TRUE);
CALL `asset_add_node`(0, 'BF 109 E-4/B', 1, TRUE);
CALL `asset_add_node`(0, 'BF 109 E-4/N', 1, TRUE);
CALL `asset_add_node`(0, 'BF 110 C-4', 1, TRUE);
CALL `asset_add_node`(0, 'BF 110 C-7', 1, TRUE);
CALL `asset_add_node`(0, 'JU 87 B-2', 1, TRUE);
CALL `asset_add_node`(0, 'JU 88 A-1', 1, TRUE);
CALL `asset_add_node`(0, 'HE 111 H-2', 1, TRUE);
CALL `asset_add_node`(0, 'HE 111 P-2', 1, TRUE);
CALL `asset_add_node`(0, 'Avro Anson', 2, FALSE);
CALL `asset_add_node`(0, 'Bristol Beaufighter', 2, FALSE);
CALL `asset_add_node`(0, 'Bristol Blenheim', 2, FALSE);
CALL `asset_add_node`(0, 'Boulton Paul Defiant', 2, FALSE);
CALL `asset_add_node`(0, 'Gloster Gladiator', 2, FALSE);
CALL `asset_add_node`(0, 'Hawker Hurricane', 2, FALSE);
CALL `asset_add_node`(0, 'Supermarine Spitfire', 2, FALSE);
CALL `asset_add_node`(0, 'Short Sunderland', 2, FALSE);
CALL `asset_add_node`(0, 'Tiger Moth', 2, FALSE);
CALL `asset_add_node`(0, 'Supermarine Walrus', 2, FALSE);
CALL `asset_add_node`(0, 'Vickers Wellington', 2, FALSE);
CALL `asset_add_node`(0, 'BF-108', 1, FALSE);
CALL `asset_add_node`(0, 'BF-109', 1, FALSE);
CALL `asset_add_node`(0, 'BF-110', 1, FALSE);
CALL `asset_add_node`(0, 'BR.20', 1, FALSE);
CALL `asset_add_node`(0, 'CR.42', 1, FALSE);
CALL `asset_add_node`(0, 'DO-17', 1, FALSE);
CALL `asset_add_node`(0, 'DO-215', 1, FALSE);
CALL `asset_add_node`(0, 'FW 200', 1, FALSE);
CALL `asset_add_node`(0, 'G.50', 1, FALSE);
CALL `asset_add_node`(0, 'HE-111', 1, FALSE);
CALL `asset_add_node`(0, 'HE-115', 1, FALSE);
CALL `asset_add_node`(0, 'JU-87', 1, FALSE);
CALL `asset_add_node`(0, 'JU-88', 1, FALSE);
CALL `asset_add_node`(0, 'BF 110 C-2', 1, TRUE);

CALL `asset_add_node`(0, 'Aircraft', 0, FALSE);
CALL `asset_add_node`(49, 'Fighter', 0, FALSE);
CALL `asset_add_node`(49, 'Bomber', 0, FALSE);
CALL `asset_add_node`(49, 'Ground Attack', 0, FALSE);
CALL `asset_add_node`(49, 'Support', 0, FALSE);
CALL `asset_add_node`(49, 'Recon', 0, FALSE);

-- Delete additional Tiger Moth
CALL `asset_delete_node`(32);



-- Rearanging assets

-- '0', 'acg-assets', '0', '0', '1', '96'
-- '49', 'Aircraft', '0', '0', '2', '11'
-- '50', 'Fighter', '0', '0', '9', '10'
-- '51', 'Bomber', '0', '0', '7', '8'
-- '52', 'Ground Attack', '0', '0', '5', '6'
-- '53', 'Support', '0', '0', '3', '4'
-- '54', 'Recon', '0', '0', '3', '4'


-- '29', 'Hawker Hurricane', '2', '0', '38', '39'
-- '1', 'Hawker Hurricane I DH5-20', '2', '1', '94', '95'
-- '2', 'Hawker Hurricane I DH5-20 100 OCT', '2', '1', '92', '93'
-- '3', 'Hawker Hurricane IA Rotol', '2', '1', '90', '91'
-- '4', 'Hawker Hurricane IA Rotol 100 OCT', '2', '1', '88', '89'
-- '5', 'Hawker Hurricane IA Rotol 100 OCT', '2', '1', '86', '87'
CALL `asset_move_node`(29, 50);
CALL `asset_move_node`(1, 29);
CALL `asset_move_node`(2, 29);
CALL `asset_move_node`(3, 29);
CALL `asset_move_node`(4, 29);
CALL `asset_move_node`(5, 29);

-- '30', 'Supermarine Spitfire', '2', '0', '36', '37'
-- '6', 'Supermarine Spitfire MK I', '2', '1', '84', '85'
-- '7', 'Supermarine Spitfire MK I 100 OCT', '2', '1', '82', '83'
-- '8', 'Supermarine Spitfire IA', '2', '1', '80', '81'
-- '9', 'Supermarine Spitfire IA 100 OCT', '2', '1', '78', '79'
-- '10', 'Supermarine Spitfire IIA', '2', '1', '76', '77'
CALL `asset_move_node`(30, 50);
CALL `asset_move_node`(6, 30);
CALL `asset_move_node`(7, 30);
CALL `asset_move_node`(8, 30);
CALL `asset_move_node`(9, 30);
CALL `asset_move_node`(10, 30);

-- '11', 'Tiger Moth', '2', '1', '74', '75'
CALL `asset_move_node`(11, 54);

-- '36', 'BF-109', '1', '0', '26', '27'
-- '12', 'BF 109 E-1', '1', '1', '72', '73'
-- '13', 'BF 109 E-3', '1', '1', '70', '71'
-- '14', 'BF 109 E-3/B', '1', '1', '68', '69'
-- '15', 'BF 109 E-4', '1', '1', '66', '67'
-- '16', 'BF 109 E-4/B', '1', '1', '64', '65'
-- '17', 'BF 109 E-4/N', '1', '1', '62', '63'
CALL `asset_move_node`(36, 50);
CALL `asset_move_node`(12, 36);
CALL `asset_move_node`(13, 36);
CALL `asset_move_node`(14, 36);
CALL `asset_move_node`(15, 36);
CALL `asset_move_node`(16, 36);
CALL `asset_move_node`(17, 36);

-- '37', 'BF-110', '1', '0', '24', '25'
-- '18', 'BF 110 C-4', '1', '1', '60', '61'
-- '19', 'BF 110 C-7', '1', '1', '58', '59'
-- '48', 'BF 110 C-2', '1', '1', '2', '3'
CALL `asset_move_node`(37, 52);
CALL `asset_move_node`(18, 37);
CALL `asset_move_node`(19, 37);
CALL `asset_move_node`(48, 37);

-- '46', 'JU-87', '1', '0', '6', '7'
-- '20', 'JU 87 B-2', '1', '1', '56', '57'
CALL `asset_move_node`(46, 52);
CALL `asset_move_node`(20, 46);

-- '47', 'JU-88', '1', '0', '4', '5'
-- '21', 'JU 88 A-1', '1', '1', '54', '55'
CALL `asset_move_node`(47, 51);
CALL `asset_move_node`(21, 47);

-- '44', 'HE-111', '1', '0', '10', '11'
-- '22', 'HE 111 H-2', '1', '1', '52', '53'
-- '23', 'HE 111 P-2', '1', '1', '50', '51'
CALL `asset_move_node`(44, 51);
CALL `asset_move_node`(22, 44);
CALL `asset_move_node`(23, 44);

-- '24', 'Avro Anson', '2', '0', '48', '49'
CALL `asset_move_node`(24, 54);

-- '25', 'Bristol Beaufighter', '2', '0', '46', '47'
CALL `asset_move_node`(25, 52);

-- '26', 'Bristol Blenheim', '2', '0', '44', '45'
CALL `asset_move_node`(26, 51);

-- '27', 'Boulton Paul Defiant', '2', '0', '42', '43'
CALL `asset_move_node`(27, 50);

-- '28', 'Gloster Gladiator', '2', '0', '40', '41'
CALL `asset_move_node`(28, 50);

-- '31', 'Short Sunderland', '2', '0', '34', '35'
CALL `asset_move_node`(31, 53);

-- '33', 'Supermarine Walrus', '2', '0', '32', '33'
CALL `asset_move_node`(33, 53);

-- '34', 'Vickers Wellington', '2', '0', '30', '31'
CALL `asset_move_node`(34, 51);

-- '35', 'BF-108', '1', '0', '28', '29'
CALL `asset_move_node`(35, 54);

-- '38', 'BR.20', '1', '0', '22', '23'
CALL `asset_move_node`(38, 51);

-- '39', 'CR.42', '1', '0', '20', '21'
CALL `asset_move_node`(39, 50);

-- '40', 'DO-17', '1', '0', '18', '19'
CALL `asset_move_node`(40, 51);

-- '41', 'DO-215', '1', '0', '16', '17'
CALL `asset_move_node`(41, 51);

-- '42', 'FW 200', '1', '0', '14', '15'
CALL `asset_move_node`(42, 51);

-- '43', 'G.50', '1', '0', '12', '13'
CALL `asset_move_node`(43, 50);

-- '45', 'HE-115', '1', '0', '8', '9'
CALL `asset_move_node`(45, 51);

DROP TABLE `pam`.`aeroplanes`;

