CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `career_character_info` AS
    SELECT 
        `career_character`.`id` AS `character_id`,
        `acg_member`.`id` AS `member_id`,
        CONCAT(`career_character`.`first_name`,
                ' "',
                `acg_member`.`callsign`,
                '" ',
                `career_character`.`last_name`) AS `name`
    FROM
        (`career_character`
        LEFT JOIN `acg_member` ON ((`acg_member`.`id` = `career_character`.`personified_by`)))
    ORDER BY CONCAT(`career_character`.`first_name`,
            ' "',
            `acg_member`.`callsign`,
            '" ',
            `career_character`.`last_name`)