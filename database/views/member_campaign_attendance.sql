CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `member_campaign_attendance` AS
    SELECT 
        `member_status_log`.`member_id` AS `member_id`,
        `campaign`.`id` AS `campaign_id`,
        `campaign`.`name` AS `campaign_name`,
        `transfer`.`acg_unit_id` AS `acg_unit_id`,
        `acg_unit`.`name` AS `acg_unit_name`,
        `hist_unit`.`id` AS `hist_unit_id`,
        `hist_unit`.`name` AS `hist_unit_name`
    FROM
        ((((((`member_status_log`
        JOIN `campaign_max_min_date`)
        JOIN `transfer` ON ((`member_status_log`.`member_id` = `transfer`.`member_id`)))
        LEFT JOIN `deployed_unit` ON (((`deployed_unit`.`acg_unit_id` = `transfer`.`acg_unit_id`)
            AND (`deployed_unit`.`campaign_id` = `campaign_max_min_date`.`id`))))
        LEFT JOIN `campaign` ON ((`campaign`.`id` = `deployed_unit`.`campaign_id`)))
        LEFT JOIN `hist_unit` ON ((`hist_unit`.`id` = `deployed_unit`.`hist_unit_id`)))
        LEFT JOIN `acg_unit` ON ((`deployed_unit`.`acg_unit_id` = `acg_unit`.`id`)))
    WHERE
        (((`member_status_log`.`member_status` = 0)
            OR (`member_status_log`.`member_status` = 2))
            AND (`campaign_max_min_date`.`mx_date` >= `member_status_log`.`status_date_in`)
            AND ((`campaign_max_min_date`.`mn_date` < `member_status_log`.`status_date_out`)
            OR ISNULL(`member_status_log`.`status_date_out`))
            AND (`campaign_max_min_date`.`mx_date` >= `transfer`.`transfer_date_in`)
            AND ((`campaign_max_min_date`.`mn_date` < `transfer`.`transfer_date_out`)
            OR ISNULL(`transfer`.`transfer_date_out`)))