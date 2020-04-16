CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `campaign_unit_member_max_min_date` AS
    SELECT 
        `c`.`id` AS `campaign_id`,
        `c`.`mn_date` AS `c_mn_date`,
        `c`.`mx_date` AS `c_mx_date`,
        `t`.`acg_unit_id` AS `acg_unit_id`,
        `s`.`member_id` AS `member_id`,
        GREATEST(MIN(`t`.`transfer_date_in`),
                MIN(`s`.`status_date_in`)) AS `mn_date`,
        LEAST(IF(ISNULL(MAX(`t`.`transfer_date_out`)),
                    `c`.`mx_date`,
                    MAX(`t`.`transfer_date_out`)),
                IF(ISNULL(MAX(`s`.`status_date_out`)),
                    `c`.`mx_date`,
                    MAX(`s`.`status_date_out`))) AS `mx_date`
    FROM
        ((`campaign_max_min_ext_date` `c`
        JOIN `transfer` `t` ON (((`t`.`transfer_date_in` <= `c`.`mx_date`)
            AND ((`c`.`mn_date` < `t`.`transfer_date_out`)
            OR ISNULL(`t`.`transfer_date_out`)))))
        JOIN `member_status_log` `s` ON (((`s`.`member_id` = `t`.`member_id`)
            AND (`s`.`member_status` <> 1)
            AND ((`s`.`status_date_in` <= `t`.`transfer_date_out`)
            OR ISNULL(`t`.`transfer_date_out`))
            AND ((`t`.`transfer_date_in` < `s`.`status_date_out`)
            OR ISNULL(`s`.`status_date_out`))
            AND (((`s`.`status_date_in` <= `c`.`mx_date`)
            AND (`c`.`mn_date` < `s`.`status_date_out`))
            OR ISNULL(`s`.`status_date_out`)))))
    GROUP BY `c`.`id` , `t`.`acg_unit_id` , `c`.`mn_date` , `c`.`mx_date` , `s`.`member_id`