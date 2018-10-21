CREATE DEFINER=`root`@`localhost` PROCEDURE `depl_unit_add_node`(
	IN depl_unit_parent_id INT,
    IN depl_unit_campaign_id INT,
    IN depl_acg_unit_id INT,
    IN depl_hist_unit_id INT,
    IN depl_asset_id INT,
    IN depl_report_type INT
)
BEGIN

DECLARE my_left INT;
DECLARE my_right INT;

SELECT IFNULL((SELECT lft FROM deployed_unit WHERE id = depl_unit_parent_id AND campaign_id = depl_unit_campaign_id), 0) INTO my_left;
   
UPDATE deployed_unit SET rgt = rgt + 2 WHERE rgt > my_left AND campaign_id = depl_unit_campaign_id;
UPDATE deployed_unit SET lft = lft + 2 WHERE lft > my_left AND campaign_id = depl_unit_campaign_id;

INSERT INTO deployed_unit(`campaign_id`, `acg_unit_id`, `hist_unit_id`, `asset_id`, `report_type`, `lft`, `rgt`)
VALUES (depl_unit_campaign_id, depl_acg_unit_id, depl_hist_unit_id, depl_asset_id, depl_report_type,  my_left + 1, my_left + 2);

END