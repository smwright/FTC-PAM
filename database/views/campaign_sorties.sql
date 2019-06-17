CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `cl45-acg-pam-2`@`%` 
    SQL SECURITY DEFINER
VIEW `campaign_sorties` AS
    SELECT 
        `campaign`.`id` AS `id`, COUNT(`report`.`id`) AS `sorties`
    FROM
        ((`campaign`
        LEFT JOIN `mission` ON ((`mission`.`campaign_id` = `campaign`.`id`)))
        LEFT JOIN `report` ON ((`report`.`mission_id` = `mission`.`id`)))
    WHERE
        (`report`.`accepted` = 1)
    GROUP BY `campaign`.`id`