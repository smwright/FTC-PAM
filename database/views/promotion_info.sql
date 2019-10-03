CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `promotion_info` AS
    SELECT 
        `promotion`.`id` AS `id`,
        `promotion`.`member_id` AS `member_id`,
        `promotion`.`rank_value` AS `rank_value`,
        `promotion`.`promotion_date` AS `promotion_date`,
        `promotion`.`comment` AS `comment`
    FROM
        `promotion`
    ORDER BY `promotion`.`promotion_date` , `promotion`.`id`