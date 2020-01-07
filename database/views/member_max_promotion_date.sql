CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `member_max_promotion_date` AS
    SELECT 
        `promotion`.`member_id` AS `member_id`,
        MAX(`promotion`.`promotion_date`) AS `mx_promotion_date`
    FROM
        `promotion`
    GROUP BY `promotion`.`member_id`