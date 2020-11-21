CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `mission_participants` AS
    SELECT 
        `mission`.`id` AS `id`,
        COUNT(DISTINCT `career_character`.`personified_by`) AS `participants`
    FROM
        ((`mission`
        LEFT JOIN `report` ON ((`report`.`mission_id` = `mission`.`id`)))
        LEFT JOIN `career_character` ON ((`career_character`.`id` = `report`.`character_id`)))
    WHERE
        (`report`.`accepted` = 1)
    GROUP BY `mission`.`id`