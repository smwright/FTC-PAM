CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `campaign_max_min_date` AS
    SELECT 
        `campaign`.`id` AS `id`,
        MAX(`mission`.`real_date`) AS `mx_date`,
        MIN(`mission`.`real_date`) AS `mn_date`
    FROM
        (`campaign`
        LEFT JOIN `mission` ON ((`mission`.`campaign_id` = `campaign`.`id`)))
    GROUP BY `campaign`.`id`