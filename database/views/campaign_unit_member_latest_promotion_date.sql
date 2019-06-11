CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `campaign_unit_member_latest_promotion_date` AS
    SELECT 
        `deployed_unit`.`campaign_id` AS `campaign_id`,
        `deployed_unit`.`id` AS `depl_unit_id`,
        `transfer`.`member_id` AS `member_id`,
        MAX(`promotion`.`promotion_date`) AS `mx_promotion_date`
    FROM
        (((`deployed_unit`
        JOIN `transfer` ON ((`transfer`.`acg_unit_id` = `deployed_unit`.`acg_unit_id`)))
        JOIN `campaign_max_min_date` ON ((`campaign_max_min_date`.`id` = `deployed_unit`.`campaign_id`)))
        JOIN `promotion` ON ((`promotion`.`member_id` = `transfer`.`member_id`)))
    WHERE
        ((`transfer`.`transfer_date_in` < `campaign_max_min_date`.`mx_date`)
            AND ((`transfer`.`transfer_date_out` > `campaign_max_min_date`.`mn_date`)
            OR ISNULL(`transfer`.`transfer_date_out`))
            AND (`promotion`.`promotion_date` < `campaign_max_min_date`.`mx_date`))
    GROUP BY `deployed_unit`.`campaign_id` , `depl_unit_id` , `transfer`.`member_id`