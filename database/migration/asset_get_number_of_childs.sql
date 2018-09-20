CREATE DEFINER=`root`@`localhost` PROCEDURE `asset_get_number_of_childs`(
	IN asset_parent INT,
    OUT number_of_children INT
)
BEGIN

SELECT COUNT(result_table.childs) INTO number_of_children FROM
(
	SELECT node.id AS childs, (COUNT(parent.id) - (sub_tree.depth + 1)) AS depth
	FROM asset AS node, asset AS parent, asset AS sub_parent,
	(
		SELECT node.id, (COUNT(parent.id) - 1) AS depth
		FROM asset AS node, asset AS parent
		WHERE node.lft BETWEEN parent.lft AND parent.rgt
		AND node.id = asset_parent
		GROUP BY node.id
	)AS sub_tree

	WHERE node.lft BETWEEN parent.lft AND parent.rgt
	AND node.lft BETWEEN sub_parent.lft AND sub_parent.rgt
	AND sub_parent.id = sub_tree.id
	GROUP BY node.id, sub_tree.depth
	HAVING (COUNT(parent.id) - (sub_tree.depth + 1)) = 1
)AS result_table;
END