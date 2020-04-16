CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `campaign_unit_member_info_current` AS
    SELECT 
        `msl`.`member_id` AS `member_id`,
        `acg_member`.`callsign` AS `callsign`,
        IF((`msl`.`member_status` = 4),
            0,
            `msl`.`member_status`) AS `member_status`,
        `msl`.`status_date_in` AS `status_date_in`,
        `msl`.`status_date_out` AS `status_date_out`,
        `msl`.`comment` AS `comment`,
        `t`.`acg_unit_id` AS `acg_unit_id`,
        `t`.`transfer_date_in` AS `transfer_date_in`,
        `t`.`transfer_date_out` AS `transfer_date_out`,
        `p`.`rank_value` AS `rank_value`
    FROM
        ((((`member_status_log` `msl`
        JOIN `acg_member` ON ((`msl`.`member_id` = `acg_member`.`id`)))
        JOIN `transfer` `t` ON ((`msl`.`member_id` = `t`.`member_id`)))
        JOIN `member_max_promotion_date` `pm` ON ((`msl`.`member_id` = `pm`.`member_id`)))
        JOIN `promotion` `p` ON (((`pm`.`member_id` = `p`.`member_id`)
            AND (`pm`.`mx_promotion_date` = `p`.`promotion_date`))))
    WHERE
        (ISNULL(`msl`.`status_date_out`)
            AND ISNULL(`t`.`transfer_date_out`))