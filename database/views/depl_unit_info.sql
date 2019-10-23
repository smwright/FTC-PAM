CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `depl_unit_info` AS
    SELECT 
        `deployed_unit`.`id` AS `id`,
        `deployed_unit`.`campaign_id` AS `campaign_id`,
        `deployed_unit`.`acg_unit_id` AS `acg_unit_id`,
        `deployed_unit`.`hist_unit_id` AS `hist_unit_id`,
        `deployed_unit`.`asset_id` AS `asset_id`,
        `deployed_unit`.`unit_type` AS `unit_type`,
        `deployed_unit`.`lft` AS `lft`,
        `deployed_unit`.`rgt` AS `rgt`
    FROM
        `deployed_unit`
    ORDER BY `deployed_unit`.`campaign_id` , `deployed_unit`.`lft`
