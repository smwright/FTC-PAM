CREATE DEFINER=`root`@`localhost` PROCEDURE `asset_delete_node`(
	IN asset_node_id INT
)
BEGIN

DECLARE my_left INT;
DECLARE my_right INT;

SELECT lft, rgt INTO my_left, my_right
FROM asset WHERE id = asset_node_id;

DELETE FROM asset WHERE lft = my_left;

UPDATE asset SET rgt = rgt - 1, lft = lft - 1 WHERE lft BETWEEN my_left AND my_right;
UPDATE asset SET rgt = rgt - 2 WHERE rgt > my_right;
UPDATE asset SET lft = lft - 2 WHERE lft > my_right;

END