CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `campaign_info_unit` AS
    SELECT 
        `deployed_unit`.`lft` AS `lft`,
        `deployed_unit`.`rgt` AS `rgt`,
        `deployed_unit`.`id` AS `depl_unit_id`,
        `deployed_unit`.`campaign_id` AS `campaign_id`,
        `deployed_unit`.`acg_unit_id` AS `acg_unit_id`,
        `deployed_unit`.`hist_unit_id` AS `hist_unit_id`,
        `deployed_unit`.`asset_id` AS `asset_id`,
        `deployed_unit`.`unit_type` AS `unit_type`,
        `hist_unit`.`name` AS `hist_unit_name`,
        `acg_unit`.`name` AS `acg_unit_name`,
        `hist_unit`.`code` AS `hist_unit_code`,
        `hist_unit`.`faction` AS `faction`,
        `hist_unit`.`description` AS `description`,
        `hist_unit`.`image` AS `image`,
        `campaign`.`name` AS `campaign_name`
    FROM
        (((`deployed_unit`
        LEFT JOIN `hist_unit` ON ((`deployed_unit`.`hist_unit_id` = `hist_unit`.`id`)))
        LEFT JOIN `campaign` ON ((`deployed_unit`.`campaign_id` = `campaign`.`id`)))
        LEFT JOIN `acg_unit` ON ((`deployed_unit`.`acg_unit_id` = `acg_unit`.`id`)))
    ORDER BY `deployed_unit`.`lft`