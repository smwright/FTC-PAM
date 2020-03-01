CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `member_current_rank` AS
    SELECT 
        `member_info_with_last_status`.`member_id` AS `member_id`,
        `member_info_with_last_status`.`username` AS `username`,
        `member_info_with_last_status`.`member_status` AS `member_status`,
        `member_info_with_last_status`.`acg_unit_id` AS `acg_unit_id`,
        `promotion`.`rank_value` AS `rank_value`,
        (CASE
            WHEN (`member_info_with_last_status`.`acg_unit_id` = 44) THEN `r_l_raf`.`rank_id`
            WHEN (`member_info_with_last_status`.`acg_unit_id` = 45) THEN `r_l_lw`.`rank_id`
            WHEN (`member_info_with_last_status`.`acg_unit_id` = 46) THEN `r_l_raf`.`rank_id`
            WHEN (`member_info_with_last_status`.`acg_unit_id` = 47) THEN `r_l_lw`.`rank_id`
            ELSE `r_l`.`rank_id`
        END) AS `member_rank_id`
    FROM
        (((((((((`member_info_with_last_status`
        LEFT JOIN `member_max_promotion_date` ON ((`member_info_with_last_status`.`member_id` = `member_max_promotion_date`.`member_id`)))
        LEFT JOIN `promotion` ON (((`member_max_promotion_date`.`mx_promotion_date` = `promotion`.`promotion_date`)
            AND (`member_max_promotion_date`.`member_id` = `promotion`.`member_id`))))
        JOIN `campaign`)
        LEFT JOIN `deployed_unit` ON (((`deployed_unit`.`campaign_id` = `campaign`.`id`)
            AND (`deployed_unit`.`acg_unit_id` = `member_info_with_last_status`.`acg_unit_id`))))
        LEFT JOIN `hist_unit` ON ((`deployed_unit`.`hist_unit_id` = `hist_unit`.`id`)))
        LEFT JOIN `rank_lookup` `r_l` ON (((`r_l`.`real_value` = `promotion`.`rank_value`)
            AND (`r_l`.`faction` = `hist_unit`.`faction`))))
        LEFT JOIN `rank_lookup` `r_l_lw` ON (((`r_l_lw`.`real_value` = `promotion`.`rank_value`)
            AND (`r_l_lw`.`faction` = 1))))
        LEFT JOIN `rank_lookup` `r_l_raf` ON (((`r_l_raf`.`real_value` = `promotion`.`rank_value`)
            AND (`r_l_raf`.`faction` = 2))))
        LEFT JOIN `rank_lookup` `r_l_vvs` ON (((`r_l_vvs`.`real_value` = `promotion`.`rank_value`)
            AND (`r_l_vvs`.`faction` = 3))))
    WHERE
        ((`campaign`.`campaign_status` = 1)
            AND (`campaign`.`is_primary` = 1))