CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `campaign_unit_member_info` AS
    SELECT 
        `cum`.`campaign_id` AS `campaign_id`,
        `cum`.`acg_unit_id` AS `acg_unit_id`,
        `du`.`hist_unit_id` AS `hist_unit_id`,
        `cum`.`member_id` AS `member_id`,
        `cmm`.`mn_date` AS `mn_date`,
        `cmm`.`mx_date` AS `mx_date`,
        `acg_member`.`callsign` AS `callsign`,
        `t`.`event_type` AS `event_type`,
        `t`.`event_value` AS `event_value`,
        `t`.`date_in` AS `date_in`,
        `t`.`date_out` AS `date_out`,
        (`t`.`date_in` BETWEEN `cmm`.`mn_date` AND `cmm`.`mx_date`) AS `event_in_during_campaign`,
        (`t`.`date_out` BETWEEN `cmm`.`mn_date` AND `cmm`.`mx_date`) AS `event_out_during_campaign`,
        `p`.`rank_value` AS `rank_value`,
        `rai`.`markings` AS `markings`,
        `rai`.`image` AS `image`
    FROM
        ((((((((`campaign_unit_member` `cum`
        LEFT JOIN `deployed_unit` `du` ON (((`du`.`acg_unit_id` = `cum`.`acg_unit_id`)
            AND (`du`.`campaign_id` = `cum`.`campaign_id`))))
        LEFT JOIN `campaign_max_min_ext_date` `cmm` ON ((`cum`.`campaign_id` = `cmm`.`id`)))
        LEFT JOIN `transfer_status_events` `t` ON (((`t`.`member_id` = `cum`.`member_id`)
            AND (`t`.`date_in` < `cmm`.`mx_date`)
            AND ((`cmm`.`mn_date` <= `t`.`date_out`)
            OR ISNULL(`t`.`date_out`)))))
        LEFT JOIN `acg_member` ON ((`cum`.`member_id` = `acg_member`.`id`)))
        LEFT JOIN `campaign_unit_member_max_promotion_date` `cmp` ON (((`cum`.`campaign_id` = `cmp`.`campaign_id`)
            AND (`cum`.`acg_unit_id` = `cmp`.`acg_unit_id`)
            AND (`cum`.`member_id` = `cmp`.`member_id`))))
        LEFT JOIN `promotion` `p` ON (((`cmp`.`member_id` = `p`.`member_id`)
            AND (`cmp`.`mx_date` = `p`.`promotion_date`))))
        LEFT JOIN `member_roster_asset` `mra` ON (((`mra`.`member_id` = `cum`.`member_id`)
            AND (`mra`.`acg_unit_id` = `cum`.`acg_unit_id`)
            AND (`mra`.`campaign_id` = `cum`.`campaign_id`))))
        LEFT JOIN `roster_asset_info` `rai` ON ((`rai`.`id` = `mra`.`roster_asset_id`)))