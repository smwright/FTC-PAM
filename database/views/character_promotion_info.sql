CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `character_promotion_info` AS
    SELECT 
        `career_character`.`id` AS `character_id`,
        `career_character`.`personified_by` AS `member_id`,
        DATE_FORMAT(MIN(`mission`.`hist_date`), '%Y-%m-%d') AS `hist_date`,
        `rank`.`name` AS `name`
    FROM
        (((((((`report`
        LEFT JOIN `mission` ON ((`mission`.`id` = `report`.`mission_id`)))
        LEFT JOIN `career_character` ON ((`career_character`.`id` = `report`.`character_id`)))
        LEFT JOIN `transfer` ON ((`transfer`.`member_id` = `career_character`.`personified_by`)))
        LEFT JOIN `deployed_unit` ON (((`deployed_unit`.`acg_unit_id` = `transfer`.`acg_unit_id`)
            AND (`mission`.`campaign_id` = `deployed_unit`.`campaign_id`))))
        LEFT JOIN `hist_unit` ON ((`hist_unit`.`id` = `deployed_unit`.`hist_unit_id`)))
        LEFT JOIN `promotion` ON (((`promotion`.`member_id` = `career_character`.`personified_by`)
            AND (`promotion`.`promotion_date` >= `mission`.`real_date`))))
        LEFT JOIN `rank` ON (((`rank`.`faction` = `hist_unit`.`faction`)
            AND (`rank`.`value` = `promotion`.`rank_value`))))
    WHERE
        ((`transfer`.`transfer_date_in` <= `mission`.`real_date`)
            AND ((`transfer`.`transfer_date_out` >= `mission`.`real_date`)
            OR ISNULL(`transfer`.`transfer_date_out`))
            AND (`transfer`.`transfer_date_in` <= `promotion`.`promotion_date`)
            AND ((`transfer`.`transfer_date_out` >= `promotion`.`promotion_date`)
            OR ISNULL(`transfer`.`transfer_date_out`)))
    GROUP BY `report`.`character_id` , `career_character`.`personified_by` , `rank`.`name`