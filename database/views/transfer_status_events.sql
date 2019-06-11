CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `pam`.`transfer_status_events` AS
    SELECT 
        'transfer' AS `event_type`,
        `pam`.`transfer`.`member_id` AS `member_id`,
        `pam`.`transfer`.`acg_unit_id` AS `event_value`,
        `pam`.`transfer`.`transfer_date_in` AS `date_in`,
        `pam`.`transfer`.`transfer_date_out` AS `date_out`
    FROM
        `pam`.`transfer` 
    UNION SELECT 
        'status' AS `1`,
        `pam`.`member_status_log`.`member_id` AS `member_id`,
        `pam`.`member_status_log`.`member_status` AS `member_status`,
        `pam`.`member_status_log`.`status_date_in` AS `status_date_in`,
        `pam`.`member_status_log`.`status_date_out` AS `status_date_out`
    FROM
        `pam`.`member_status_log`