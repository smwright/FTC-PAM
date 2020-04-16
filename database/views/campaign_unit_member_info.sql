CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `campaign_unit_member_info` AS
    SELECT 
        `c`.`campaign_id` AS `campaign_id`,
        `c`.`c_mn_date` AS `c_mn_date`,
        `c`.`c_mx_date` AS `c_mx_date`,
        `c`.`acg_unit_id` AS `acg_unit_id`,
        `c`.`member_id` AS `member_id`,
        `acg_member`.`callsign` AS `callsign`,
        `tse`.`event_type` AS `event_type`,
        `tse`.`event_value` AS `event_value`,
        `tse`.`date_in` AS `date_in`,
        `tse`.`date_out` AS `date_out`,
        (`tse`.`date_in` BETWEEN `c`.`c_mn_date` AND `c`.`c_mx_date`) AS `event_in_during_campaign`,
        (`tse`.`date_out` BETWEEN `c`.`c_mn_date` AND `c`.`c_mx_date`) AS `event_out_during_campaign`,
        `p`.`rank_value` AS `rank_value`
    FROM
        ((((`campaign_unit_member_max_min_date` `c`
        JOIN `transfer_status_events` `tse` ON (((`c`.`member_id` = `tse`.`member_id`)
            AND (`tse`.`date_in` <= `c`.`mn_date`)
            AND ((`c`.`mx_date` <= `tse`.`date_out`)
            OR ISNULL(`tse`.`date_out`)))))
        JOIN `acg_member` ON ((`c`.`member_id` = `acg_member`.`id`)))
        JOIN `campaign_unit_member_max_promotion_date` `cmp` ON (((`c`.`campaign_id` = `cmp`.`campaign_id`)
            AND (`c`.`acg_unit_id` = `cmp`.`acg_unit_id`)
            AND (`c`.`member_id` = `cmp`.`member_id`))))
        JOIN `promotion` `p` ON (((`cmp`.`member_id` = `p`.`member_id`)
            AND (`cmp`.`mx_date` = `p`.`promotion_date`))))