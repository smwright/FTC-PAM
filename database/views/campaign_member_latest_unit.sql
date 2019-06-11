CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `campaign_member_latest_unit` AS
    SELECT 
        `transfer`.`member_id` AS `member_id`,
        `deployed_unit`.`id` AS `depl_unit_id`,
        `deployed_unit`.`campaign_id` AS `campaign_id`,
        `deployed_unit`.`acg_unit_id` AS `acg_unit_id`,
        `deployed_unit`.`hist_unit_id` AS `hist_unit_id`,
        `hist_unit`.`faction` AS `faction`
    FROM
        (((`campaign_member_latest_transfer`
        LEFT JOIN `transfer` ON (((`transfer`.`member_id` = `campaign_member_latest_transfer`.`member_id`)
            AND (`transfer`.`transfer_date_in` = `campaign_member_latest_transfer`.`mx_date`))))
        LEFT JOIN `deployed_unit` ON (((`deployed_unit`.`campaign_id` = `campaign_member_latest_transfer`.`campaign_id`)
            AND (`deployed_unit`.`acg_unit_id` = `transfer`.`acg_unit_id`))))
        LEFT JOIN `hist_unit` ON ((`hist_unit`.`id` = `deployed_unit`.`hist_unit_id`)))