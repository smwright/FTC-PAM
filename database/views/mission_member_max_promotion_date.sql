CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `mission_member_max_promotion_date` AS
    SELECT 
        `mission`.`id` AS `mission_id`,
        `promotion`.`member_id` AS `member_id`,
        MAX(`promotion`.`promotion_date`) AS `mx_promotion_date`
    FROM
        (`promotion`
        LEFT JOIN `mission` ON ((`promotion`.`promotion_date` <= `mission`.`real_date`)))
    WHERE
        (`mission`.`id` IS NOT NULL)
    GROUP BY `mission_id` , `promotion`.`member_id`