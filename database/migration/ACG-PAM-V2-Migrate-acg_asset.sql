SET @position := 0;
ALTER TABLE asset  AUTO_INCREMENT = 1;
INSERT INTO `asset`
(id, name, faction, controlable, lft, rgt)
SELECT id, name, IF(faction='LW',1,IF(faction='RAF',2,3)), IF(type=1,1,0), (@position := @position + 1), (@position := @position + 1)  FROM aeroplanes

