CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `character_max_min_hist_mission_timestamp` AS
    SELECT 
        `report`.`character_id` AS `character_id`,
        `career_character`.`personified_by` AS `member_id`,
        MIN((`mission`.`hist_date` + (`mission`.`id` / 1000))) AS `mn_hist_date`,
        MAX((`mission`.`hist_date` + (`mission`.`id` / 1000))) AS `mx_hist_date`
    FROM
        ((`report`
        LEFT JOIN `mission` ON ((`report`.`mission_id` = `mission`.`id`)))
        LEFT JOIN `career_character` ON ((`report`.`character_id` = `career_character`.`id`)))
    GROUP BY `report`.`character_id` , `member_id`