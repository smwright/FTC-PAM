CREATE DEFINER=`root`@`localhost` PROCEDURE `asset_add_node`(
	IN asset_parent_id INT,
    IN asset_name VARCHAR(45),
    IN asset_faction INT,
    IN asset_controlable BOOLEAN
)
BEGIN

DECLARE my_left INT;
DECLARE my_right INT;

SELECT lft INTO my_left FROM asset WHERE id = asset_parent_id;
    
UPDATE asset SET rgt = rgt + 2 WHERE rgt > my_left;
UPDATE asset SET lft = lft + 2 WHERE lft > my_left;

INSERT INTO asset(`name`, `faction`, `controlable`, `lft`, `rgt`)
VALUES (asset_name, asset_faction, asset_controlable, my_left + 1, my_left + 2);

END