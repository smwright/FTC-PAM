CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `cl45-acg-pam-2`@`%` 
    SQL SECURITY DEFINER
VIEW `campaign_participants` AS
    SELECT 
        `campaign`.`id` AS `id`,
        COUNT(DISTINCT `career_character`.`personified_by`) AS `participants`
    FROM
        (((`campaign`
        LEFT JOIN `mission` ON ((`mission`.`campaign_id` = `campaign`.`id`)))
        LEFT JOIN `report` ON ((`report`.`mission_id` = `mission`.`id`)))
        LEFT JOIN `career_character` ON ((`career_character`.`id` = `report`.`character_id`)))
    WHERE
        (`report`.`accepted` = 1)
    GROUP BY `campaign`.`id`