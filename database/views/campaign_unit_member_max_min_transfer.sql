CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `campaign_unit_member_max_min_transfer` AS
    SELECT 
        `transfer`.`member_id` AS `member_id`,
        `transfer`.`acg_unit_id` AS `acg_unit_id`,
        MIN(`transfer`.`transfer_date_in`) AS `min_transfer_date_in`,
        MAX(`transfer`.`transfer_date_out`) AS `max_transfer_date_out`,
        `deployed_unit`.`campaign_id` AS `campaign_id`,
        `deployed_unit`.`id` AS `depl_unit_id`,
        `deployed_unit`.`hist_unit_id` AS `hist_unit_id`
    FROM
        ((`deployed_unit`
        JOIN `transfer` ON ((`deployed_unit`.`acg_unit_id` = `transfer`.`acg_unit_id`)))
        JOIN `campaign_max_min_date` ON ((`campaign_max_min_date`.`id` = `deployed_unit`.`campaign_id`)))
    WHERE
        ((`transfer`.`transfer_date_in` < `campaign_max_min_date`.`mx_date`)
            AND ((`transfer`.`transfer_date_out` > `campaign_max_min_date`.`mn_date`)
            OR ISNULL(`transfer`.`transfer_date_out`)))
    GROUP BY `transfer`.`member_id` , `transfer`.`acg_unit_id` , `deployed_unit`.`campaign_id` , `deployed_unit`.`id` , `deployed_unit`.`hist_unit_id`