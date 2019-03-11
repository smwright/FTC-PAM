CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `campaign_unit_member_info` AS
    SELECT 
        `Y`.`campaign_id` AS `campaign_id`,
        `Y`.`depl_unit_id` AS `depl_unit_id`,
        `Y`.`acg_unit_id` AS `acg_unit_id`,
        `acg_member`.`callsign` AS `callsign`,
        `Y`.`member_id` AS `member_id`,
        `Z`.`event_type` AS `event_type`,
        `Z`.`event_value` AS `event_value`,
        `Z`.`date_in` AS `event_date_in`,
        `Z`.`date_out` AS `event_date_out`,
        (`Z`.`date_in` BETWEEN `campaign_max_min_date`.`mn_date` AND `campaign_max_min_date`.`mx_date`) AS `show_event_start`,
        (`Z`.`date_out` BETWEEN `campaign_max_min_date`.`mn_date` AND `campaign_max_min_date`.`mx_date`) AS `show_event_stop`,
        `rank`.`name` AS `rank_name`,
        `rank`.`abreviation` AS `rank_abr`,
        `rank`.`image` AS `image`
    FROM
        ((((((((`campaign_unit_member_max_min_transfer` `Y`
        JOIN `hist_unit` ON ((`hist_unit`.`id` = `Y`.`hist_unit_id`)))
        JOIN `acg_member` ON ((`acg_member`.`id` = `Y`.`member_id`)))
        JOIN `campaign_max_min_date` ON ((`campaign_max_min_date`.`id` = `Y`.`campaign_id`)))
        LEFT JOIN `transfer_status_events` `Z` ON (((`Z`.`member_id` = `Y`.`member_id`)
            AND (((`Z`.`event_type` = 'transfer')
            AND (`Z`.`event_value` = `Y`.`acg_unit_id`))
            OR (`Z`.`event_type` = 'status'))
            AND (ISNULL(`Z`.`date_out`)
            OR (`Z`.`date_out` > `Y`.`min_transfer_date_in`))
            AND (ISNULL(`Z`.`date_out`)
            OR (`Z`.`date_out` > `campaign_max_min_date`.`mn_date`))
            AND IFNULL(1, ((`Z`.`date_in` < `Y`.`max_transfer_date_out`)
            AND (`Z`.`date_in` < `campaign_max_min_date`.`mx_date`))))))
        JOIN `campaign_unit_member_latest_promotion_date` `X` ON (((`X`.`campaign_id` = `Y`.`campaign_id`)
            AND (`X`.`depl_unit_id` = `Y`.`depl_unit_id`)
            AND (`X`.`member_id` = `Y`.`member_id`))))
        JOIN `promotion` ON (((`promotion`.`member_id` = `X`.`member_id`)
            AND (`promotion`.`promotion_date` = `X`.`mx_promotion_date`))))
        JOIN `rank_translation` ON (((`rank_translation`.`real_value` = `promotion`.`rank_value`)
            AND (`rank_translation`.`faction` = `hist_unit`.`faction`))))
        JOIN `rank` ON (((`rank`.`value` = `rank_translation`.`disp_value`)
            AND (`rank`.`faction` = `hist_unit`.`faction`))))
    ORDER BY `promotion`.`rank_value` DESC , `Y`.`member_id` , `Z`.`date_in`