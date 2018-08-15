CREATE DEFINER=`root`@`localhost` PROCEDURE `asset_move_node`(
	IN asset_node_id INT,
    IN asset_parent_id INT
)
BEGIN

DECLARE number_of_childs INT;
DECLARE my_left INT;
DECLARE my_right INT;

SELECT lft, rgt INTO my_left, my_right 
FROM asset WHERE id = asset_node_id;

UPDATE asset SET rgt = 0, lft = 0 WHERE id = asset_node_id;
UPDATE asset SET rgt = rgt - 1, lft = lft - 1 WHERE lft BETWEEN my_left AND my_right;
UPDATE asset SET rgt = rgt - 2 WHERE rgt > my_right;
UPDATE asset SET lft = lft - 2 WHERE lft > my_right;

CALL `asset_get_number_of_childs`(asset_parent_id, number_of_childs);
IF number_of_childs > 0 THEN
	
	SELECT rgt INTO my_right FROM asset WHERE id = asset_parent_id;
	-- If parent has already children
	UPDATE asset SET rgt = rgt + 2 WHERE rgt > my_right;
	UPDATE asset SET lft = lft + 2 WHERE lft > my_right;
	UPDATE asset SET lft = my_right + 1, rgt = my_right + 2 WHERE id = asset_node_id;

ELSE

	SELECT lft INTO my_left FROM asset WHERE id = asset_parent_id;
	-- If parent has already children
	UPDATE asset SET rgt = rgt + 2 WHERE rgt > my_left;
	UPDATE asset SET lft = lft + 2 WHERE lft > my_left;
	UPDATE asset SET lft = my_left + 1, rgt = my_left + 2 WHERE id = asset_node_id;

END IF;

END