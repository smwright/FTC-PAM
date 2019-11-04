CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `character_campaign_max_min_hist_mission_date` AS
    SELECT 
        `career_character`.`id` AS `character_id`,
        `career_character`.`personified_by` AS `member_id`,
        `mission`.`campaign_id` AS `campaign_id`,
        MIN(`mission`.`hist_date`) AS `mn_hist_mission_date`,
        MAX(`mission`.`hist_date`) AS `mx_hist_mission_date`
    FROM
        ((`career_character`
        LEFT JOIN `report` ON ((`report`.`character_id` = `career_character`.`id`)))
        LEFT JOIN `mission` ON ((`report`.`mission_id` = `mission`.`id`)))
    GROUP BY `career_character`.`id` , `career_character`.`personified_by` , `mission`.`campaign_id`