CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `mission_member_rank` AS
    SELECT 
        `mission_member_max_promotion_date`.`mission_id` AS `mission_id`,
        `mission_member_max_promotion_date`.`member_id` AS `member_id`,
        `rank_lookup`.`real_value` AS `real_value`,
        `rank_lookup`.`rank_name` AS `rank_name`,
        `rank_lookup`.`abreviation` AS `abreviation`,
        `rank_lookup`.`disp_value` AS `disp_value`,
        `rank_lookup`.`faction` AS `faction`,
        `rank_lookup`.`image` AS `image`
    FROM
        ((`mission_member_max_promotion_date`
        JOIN `promotion` ON (((`promotion`.`member_id` = `mission_member_max_promotion_date`.`member_id`)
            AND (`promotion`.`promotion_date` = `mission_member_max_promotion_date`.`mx_promotion_date`))))
        JOIN `rank_lookup` ON ((`rank_lookup`.`real_value` = `promotion`.`rank_value`)))