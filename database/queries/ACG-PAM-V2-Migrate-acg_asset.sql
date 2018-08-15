-- Restart table count 
ALTER TABLE asset  AUTO_INCREMENT = 1;

-- Insert asset root and update id to 0
INSERT INTO `asset`(`id`,`name`,`faction`,`controlable`,`lft`,`rgt`)
VALUES(0,'acg-assets',0,0,1,2);
UPDATE asset SET id = 0 WHERE id = 1;

-- Reset table count again
ALTER TABLE asset  AUTO_INCREMENT = 1;

-- faction status: 0-None, 1-LW, 2-RAF 
CALL `asset_add_node`(0, 'Hawker Hurricane I DH5-20', 2, TRUE); #1
CALL `asset_add_node`(0, 'Hawker Hurricane I DH5-20 100 OCT', 2, TRUE); #2
CALL `asset_add_node`(0, 'Hawker Hurricane IA Rotol', 2, TRUE); #3
CALL `asset_add_node`(0, 'Hawker Hurricane IA Rotol 100 OCT', 2, TRUE); #4
CALL `asset_add_node`(0, 'Supermarine Spitfire MK I', 2, TRUE); #5
CALL `asset_add_node`(0, 'Supermarine Spitfire MK I 100 OCT', 2, TRUE); #6
CALL `asset_add_node`(0, 'Supermarine Spitfire IA', 2, TRUE); #7
CALL `asset_add_node`(0, 'Supermarine Spitfire IA 100 OCT', 2, TRUE); #8
CALL `asset_add_node`(0, 'Supermarine Spitfire IIA', 2, TRUE); #9
CALL `asset_add_node`(0, 'Tiger Moth', 2, TRUE); #10
CALL `asset_add_node`(0, 'BF 109 E-1', 1, TRUE); #11
CALL `asset_add_node`(0, 'BF 109 E-3', 1, TRUE); #12
CALL `asset_add_node`(0, 'BF 109 E-3/B', 1, TRUE); #13
CALL `asset_add_node`(0, 'BF 109 E-4', 1, TRUE); #14
CALL `asset_add_node`(0, 'BF 109 E-4/B', 1, TRUE); #15
CALL `asset_add_node`(0, 'BF 109 E-4/N', 1, TRUE); #16
CALL `asset_add_node`(0, 'BF 110 C-4', 1, TRUE); #17
CALL `asset_add_node`(0, 'BF 110 C-7', 1, TRUE); #18
CALL `asset_add_node`(0, 'JU 87 B-2', 1, TRUE); #19
CALL `asset_add_node`(0, 'JU 88 A-1', 1, TRUE); #20
CALL `asset_add_node`(0, 'HE 111 H-2', 1, TRUE); #21
CALL `asset_add_node`(0, 'HE 111 P-2', 1, TRUE); #22
CALL `asset_add_node`(0, 'Avro Anson', 2, FALSE); #23
CALL `asset_add_node`(0, 'Bristol Beaufighter', 2, FALSE); #24
CALL `asset_add_node`(0, 'Bristol Blenheim', 2, FALSE); #25
CALL `asset_add_node`(0, 'Boulton Paul Defiant', 2, FALSE); #26
CALL `asset_add_node`(0, 'Gloster Gladiator', 2, FALSE); #27
CALL `asset_add_node`(0, 'Hawker Hurricane', 2, FALSE); #28
CALL `asset_add_node`(0, 'Supermarine Spitfire', 2, FALSE); #29
CALL `asset_add_node`(0, 'Short Sunderland', 2, FALSE); #30
CALL `asset_add_node`(0, 'Aircraft', 0, FALSE); #31
CALL `asset_add_node`(31, 'Fighter', 0, FALSE); #32
CALL `asset_add_node`(0, 'Supermarine Walrus', 2, FALSE); #33
CALL `asset_add_node`(0, 'Vickers Wellington', 2, FALSE); #34
CALL `asset_add_node`(0, 'BF-108', 1, FALSE); #35
CALL `asset_add_node`(0, 'BF-109', 1, FALSE); #36
CALL `asset_add_node`(0, 'BF-110', 1, FALSE); #37
CALL `asset_add_node`(0, 'BR.20', 1, FALSE); #38
CALL `asset_add_node`(0, 'CR.42', 1, FALSE); #39
CALL `asset_add_node`(0, 'DO-17', 1, FALSE); #40
CALL `asset_add_node`(0, 'DO-215', 1, FALSE); #41
CALL `asset_add_node`(0, 'FW 200', 1, FALSE); #42
CALL `asset_add_node`(0, 'G.50', 1, FALSE); #43
CALL `asset_add_node`(0, 'HE-111', 1, FALSE); #44
CALL `asset_add_node`(0, 'HE-115', 1, FALSE); #45
CALL `asset_add_node`(0, 'JU-87', 1, FALSE); #46
CALL `asset_add_node`(0, 'JU-88', 1, FALSE); #47
CALL `asset_add_node`(0, 'BF 110 C-2', 1, TRUE); #48

CALL `asset_add_node`(31, 'Bomber', 0, FALSE); #49
CALL `asset_add_node`(31, 'Ground Attack', 0, FALSE); #50
CALL `asset_add_node`(31, 'Support', 0, FALSE); #51
CALL `asset_add_node`(31, 'Recon', 0, FALSE); #52

-- Rearanging assets
-- `asset_move_node`(IN asset_node_id INT, IN asset_parent_id INT)

-- id	name	faction	controlable	lft	rgt
-- 0	acg-assets	0	0	1	106
-- 31	Aircraft	0	0	34	45
-- 32	Fighter	0	0	43	44
-- 49	Bomber	0	0	41	42
-- 50	"Ground Attack"	0	0	39	40
-- 51	Support	0	0	37	38
-- 52	Recon	0	0	35	36

-- 28	"Hawker Hurricane"	2	0	50	51
-- 1	"Hawker Hurricane I DH5-20"	2	1	104	105
-- 2	"Hawker Hurricane I DH5-20 100 OCT"	2	1	102	103
-- 3	"Hawker Hurricane IA Rotol"	2	1	100	101
-- 4	"Hawker Hurricane IA Rotol 100 OCT"	2	1	98	99
CALL `asset_move_node`(28, 32);
CALL `asset_move_node`(1, 28);
CALL `asset_move_node`(2, 28);
CALL `asset_move_node`(3, 28);
CALL `asset_move_node`(4, 28);

-- 29	"Supermarine Spitfire"	2	0	48	49
-- 5	"Supermarine Spitfire MK I"	2	1	96	97
-- 6	"Supermarine Spitfire MK I 100 OCT"	2	1	94	95
-- 7	"Supermarine Spitfire IA"	2	1	92	93
-- 8	"Supermarine Spitfire IA 100 OCT"	2	1	90	91
-- 9	"Supermarine Spitfire IIA"	2	1	88	89
CALL `asset_move_node`(29, 32);
CALL `asset_move_node`(5, 29);
CALL `asset_move_node`(6, 29);
CALL `asset_move_node`(7, 29);
CALL `asset_move_node`(8, 29);
CALL `asset_move_node`(9, 29);

-- 10	"Tiger Moth"	2	1	86	87
CALL `asset_move_node`(11, 52);

-- 36	BF-109	1	0	26	27
-- 11	"BF 109 E-1"	1	1	84	85
-- 12	"BF 109 E-3"	1	1	82	83
-- 13	"BF 109 E-3/B"	1	1	80	81
-- 14	"BF 109 E-4"	1	1	78	79
-- 15	"BF 109 E-4/B"	1	1	76	77
-- 16	"BF 109 E-4/N"	1	1	74	75
CALL `asset_move_node`(36, 32);
CALL `asset_move_node`(11, 36);
CALL `asset_move_node`(12, 36);
CALL `asset_move_node`(13, 36);
CALL `asset_move_node`(14, 36);
CALL `asset_move_node`(15, 36);
CALL `asset_move_node`(16, 36);

-- 37	BF-110	1	0	24	25
-- 17	"BF 110 C-4"	1	1	72	73
-- 18	"BF 110 C-7"	1	1	70	71
-- 48	"BF 110 C-2"	1	1	2	3
CALL `asset_move_node`(37, 32);
CALL `asset_move_node`(17, 37);
CALL `asset_move_node`(18, 37);
CALL `asset_move_node`(48, 37);

-- 46	JU-87	1	0	6	7
-- 19	"JU 87 B-2"	1	1	68	69
CALL `asset_move_node`(46, 50);
CALL `asset_move_node`(20, 46);

-- 20	"JU 88 A-1"	1	1	66	67
-- 47	JU-88	1	0	4	5
CALL `asset_move_node`(47, 49);
CALL `asset_move_node`(21, 47);

-- 44	HE-111	1	0	10	11
-- 21	"HE 111 H-2"	1	1	64	65
-- 22	"HE 111 P-2"	1	1	62	63
CALL `asset_move_node`(44, 49);
CALL `asset_move_node`(22, 44);
CALL `asset_move_node`(23, 44);

-- 23	"Avro Anson"	2	0	60	61
CALL `asset_move_node`(23, 52);
-- 24	"Bristol Beaufighter"	2	0	58	59
CALL `asset_move_node`(24, 50);
-- 25	"Bristol Blenheim"	2	0	56	57
CALL `asset_move_node`(25, 49);
-- 26	"Boulton Paul Defiant"	2	0	54	55
CALL `asset_move_node`(26, 32);
-- 27	"Gloster Gladiator"	2	0	52	53
CALL `asset_move_node`(27, 32);
-- 30	"Short Sunderland"	2	0	46	47
CALL `asset_move_node`(30, 51);
-- 33	"Supermarine Walrus"	2	0	32	33
CALL `asset_move_node`(33, 51);
-- 34	"Vickers Wellington"	2	0	30	31
CALL `asset_move_node`(34, 49);
-- 35	BF-108	1	0	28	29
CALL `asset_move_node`(35, 52);
-- 38	BR.20	1	0	22	23
CALL `asset_move_node`(38, 49);
-- 39	CR.42	1	0	20	21
CALL `asset_move_node`(39, 32);
-- 40	DO-17	1	0	18	19
CALL `asset_move_node`(40, 49);
-- 41	DO-215	1	0	16	17
CALL `asset_move_node`(41, 49);
-- 42	"FW 200"	1	0	14	15
CALL `asset_move_node`(42, 49);
-- 43	G.50	1	0	12	13
CALL `asset_move_node`(43, 32);
-- 45	HE-115	1	0	8	9
CALL `asset_move_node`(45, 49);
