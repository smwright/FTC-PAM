CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `campaign_average_participants` AS
    SELECT 
        `mission`.`campaign_id` AS `campaign_id`,
        ROUND(AVG(`mission_participants`.`participants`),
                0) AS `participants`
    FROM
        (`mission`
        LEFT JOIN `mission_participants` ON ((`mission_participants`.`id` = `mission`.`id`)))
    GROUP BY `mission`.`campaign_id`