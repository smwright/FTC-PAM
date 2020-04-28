CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `campaign_unit_member` AS
    SELECT DISTINCT
        `c`.`id` AS `campaign_id`,
        `t`.`acg_unit_id` AS `acg_unit_id`,
        `s`.`member_id` AS `member_id`
    FROM
        ((`campaign_max_min_date` `c`
        LEFT JOIN `member_status_log` `s` ON (((`s`.`member_status` <> 1)
            AND (`s`.`status_date_in` <= `c`.`mx_date`)
            AND ((`c`.`mn_date` < `s`.`status_date_out`)
            OR ISNULL(`s`.`status_date_out`)))))
        LEFT JOIN `transfer` `t` ON (((`s`.`member_id` = `t`.`member_id`)
            AND ((`t`.`transfer_date_in` <= `s`.`status_date_out`)
            OR ISNULL(`s`.`status_date_out`))
            AND ((`s`.`status_date_in` <= `t`.`transfer_date_out`)
            OR ISNULL(`t`.`transfer_date_out`))
            AND (`t`.`transfer_date_in` <= `c`.`mx_date`)
            AND ((`c`.`mn_date` < `t`.`transfer_date_out`)
            OR ISNULL(`t`.`transfer_date_out`)))))