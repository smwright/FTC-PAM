CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `campaign_member_status` AS
    SELECT 
        `member_status_log`.`id` AS `status_id`,
        `member_status_log`.`member_id` AS `member_id`,
        `member_status_log`.`member_status` AS `member_status`,
        `cd`.`id` AS `campaign_id`,
        `member_status_log`.`status_date_in` AS `event_date_in`,
        `member_status_log`.`status_date_out` AS `event_date_out`,
        `member_status_log`.`comment` AS `comment`,
        `acg_member`.`callsign` AS `callsign`,
        (`member_status_log`.`status_date_in` BETWEEN `cd`.`mn_date` AND `cd`.`mx_date`) AS `date_in_during_campaign`,
        (`member_status_log`.`status_date_out` BETWEEN `cd`.`mn_date` AND `cd`.`mx_date`) AS `date_out_during_campaign`
    FROM
        ((`member_status_log`
        LEFT JOIN `acg_member` ON ((`member_status_log`.`member_id` = `acg_member`.`id`)))
        JOIN `campaign_max_min_ext_date` `cd` ON (((`member_status_log`.`status_date_in` <= `cd`.`mx_date`)
            AND ((`cd`.`mn_date` <= `member_status_log`.`status_date_out`)
            OR ISNULL(`member_status_log`.`status_date_out`)))))