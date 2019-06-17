CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `cl45-acg-pam-2`@`%` 
    SQL SECURITY DEFINER
VIEW `campaign_missions` AS
    SELECT 
        `campaign`.`id` AS `id`, COUNT(`mission`.`id`) AS `missions`
    FROM
        (`campaign`
        LEFT JOIN `mission` ON ((`mission`.`campaign_id` = `campaign`.`id`)))
    GROUP BY `campaign`.`id`