CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `report_tag_info` AS
    SELECT 
        `report`.`id` AS `report_id`,
        `report`.`mission_id` AS `mission_id`,
        `career_character`.`personified_by` AS `member_id`,
        CONCAT('AAR-',
                `report`.`id`,
                ' for mission ',
                `mission`.`name`,
                ' by ',
                `career_character`.`first_name`,
                ' ',
                `career_character`.`last_name`) AS `name`
    FROM
        ((`report`
        LEFT JOIN `career_character` ON ((`career_character`.`id` = `report`.`character_id`)))
        LEFT JOIN `mission` ON ((`report`.`mission_id` = `mission`.`id`)))