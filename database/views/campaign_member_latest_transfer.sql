CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `cl45-acg-pam-2`@`%` 
    SQL SECURITY DEFINER
VIEW `campaign_member_latest_transfer` AS
    SELECT 
        `deployed_unit`.`campaign_id` AS `campaign_id`,
        `transfer`.`member_id` AS `member_id`,
        MAX(`transfer`.`transfer_date_in`) AS `mx_date`
    FROM
        ((`deployed_unit`
        JOIN `transfer` ON ((`deployed_unit`.`acg_unit_id` = `transfer`.`acg_unit_id`)))
        JOIN `campaign_max_min_date` `cmmd` ON ((`cmmd`.`id` = `deployed_unit`.`campaign_id`)))
    WHERE
        ((`transfer`.`transfer_date_in` <= `cmmd`.`mx_date`)
            AND ((`transfer`.`transfer_date_out` > `cmmd`.`mn_date`)
            OR ISNULL(`transfer`.`transfer_date_out`)))
    GROUP BY `deployed_unit`.`campaign_id` , `transfer`.`member_id`