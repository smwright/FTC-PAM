CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `member_promotion_info` AS
    SELECT DISTINCT
        `promotion`.`member_id` AS `member_id`,
        `promotion`.`rank_value` AS `rank_value`,
        `promotion`.`promotion_date` AS `promotion_date`,
        `promotion`.`comment` AS `comment`,
        `rank_lookup`.`real_value` AS `real_value`,
        `rank_lookup`.`rank_name` AS `rank_name`,
        `rank_lookup`.`abreviation` AS `abreviation`,
        `rank_lookup`.`disp_value` AS `disp_value`,
        `rank_lookup`.`faction` AS `faction`,
        `rank_lookup`.`image` AS `image`
    FROM
        (((((`promotion`
        LEFT JOIN `transfer` ON ((`promotion`.`member_id` = `transfer`.`member_id`)))
        LEFT JOIN `deployed_unit` ON ((`transfer`.`acg_unit_id` = `deployed_unit`.`acg_unit_id`)))
        LEFT JOIN `campaign_max_min_ext_date` ON ((`campaign_max_min_ext_date`.`id` = `deployed_unit`.`campaign_id`)))
        LEFT JOIN `hist_unit` ON ((`deployed_unit`.`hist_unit_id` = `hist_unit`.`id`)))
        LEFT JOIN `rank_lookup` ON (((`promotion`.`rank_value` = `rank_lookup`.`real_value`)
            AND (`hist_unit`.`faction` = `rank_lookup`.`faction`))))
    WHERE
        ((`transfer`.`transfer_date_in` <= `promotion`.`promotion_date`)
            AND ((`transfer`.`transfer_date_out` > `promotion`.`promotion_date`)
            OR ISNULL(`transfer`.`transfer_date_out`))
            AND (`campaign_max_min_ext_date`.`mn_date_ext` <= `promotion`.`promotion_date`)
            AND (`campaign_max_min_ext_date`.`mx_date` > `promotion`.`promotion_date`))