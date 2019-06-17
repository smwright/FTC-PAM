CREATE 
    ALGORITHM = UNDEFINED 
    SQL SECURITY DEFINER
VIEW `transfer_status_events` AS
    SELECT 
        'transfer' AS `event_type`,
        `transfer`.`member_id` AS `member_id`,
        `transfer`.`acg_unit_id` AS `event_value`,
        `transfer`.`transfer_date_in` AS `date_in`,
        `transfer`.`transfer_date_out` AS `date_out`
    FROM
        `transfer` 
    UNION SELECT 
        'status' AS `1`,
        `member_status_log`.`member_id` AS `member_id`,
        `member_status_log`.`member_status` AS `member_status`,
        `member_status_log`.`status_date_in` AS `status_date_in`,
        `member_status_log`.`status_date_out` AS `status_date_out`
    FROM
        `member_status_log`