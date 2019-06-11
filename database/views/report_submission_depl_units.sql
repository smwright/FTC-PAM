CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `report_submission_depl_units` AS
    SELECT 
        `deployed_unit`.`id` AS `depl_unit_id`,
        `deployed_unit`.`campaign_id` AS `campaign_id`,
        `deployed_unit`.`acg_unit_id` AS `acg_unit_id`,
        `hist_unit`.`name` AS `hist_unit_name`,
        `hist_unit`.`code` AS `hist_unit_code`,
        `hist_unit`.`faction` AS `faction`
    FROM
        (`deployed_unit`
        LEFT JOIN `hist_unit` ON ((`deployed_unit`.`hist_unit_id` = `hist_unit`.`id`)))