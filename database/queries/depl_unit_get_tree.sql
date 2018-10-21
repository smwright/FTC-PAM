CREATE DEFINER=`root`@`localhost` PROCEDURE `depl_unit_get_tree`(IN c_id INT)
BEGIN

SELECT node.id, campaign_id, acg_unit_id, hist_unit_id, report_type, lft, rgt
FROM deployed_unit AS node,
        deployed_unit AS parent
WHERE node.lft BETWEEN parent.lft AND parent.rgt AND node.campaign_id = c_id
GROUP BY node.name
ORDER BY node.lft;

END