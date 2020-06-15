CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `mission_unit_active_members` AS
    SELECT 
        `mission`.`id` AS `mission_id`,
        `mission`.`campaign_id` AS `campaign_id`,
        `t`.`acg_unit_id` AS `acg_unit_id`,
        COUNT(`t`.`member_id`) AS `active_members`
    FROM
        ((`mission`
        JOIN `member_status_log` `msl` ON (((`msl`.`member_status` = 0)
            AND (`msl`.`status_date_in` <= `mission`.`real_date`)
            AND ((`msl`.`status_date_out` > `mission`.`real_date`)
            OR ISNULL(`msl`.`status_date_out`)))))
        JOIN `transfer` `t` ON (((`msl`.`member_id` = `t`.`member_id`)
            AND (`t`.`transfer_date_in` <= `mission`.`real_date`)
            AND ((`t`.`transfer_date_out` > `mission`.`real_date`)
            OR ISNULL(`t`.`transfer_date_out`)))))
    GROUP BY `mission`.`id` , `mission`.`campaign_id` , `t`.`acg_unit_id` 
    UNION SELECT 
        `mission`.`id` AS `mission_id`,
        `mission`.`campaign_id` AS `campaign_id`,
        0 AS `acg_unit_id`,
        COUNT(`msl`.`member_id`) AS `active_members`
    FROM
        (`mission`
        JOIN `member_status_log` `msl` ON (((`msl`.`member_status` = 0)
            AND (`msl`.`status_date_in` <= `mission`.`real_date`)
            AND ((`msl`.`status_date_out` > `mission`.`real_date`)
            OR ISNULL(`msl`.`status_date_out`)))))
    GROUP BY `mission`.`id` , `mission`.`campaign_id`