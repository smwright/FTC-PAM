CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `decoration_info` AS
    SELECT 
        `decoration`.`id` AS `decoration_id`,
        `decoration`.`character_id` AS `character_id`,
        `career_character`.`personified_by` AS `member_id`,
        `decoration`.`award_id` AS `award_id`,
        `decoration`.`date` AS `decoration_date`,
        `decoration`.`comment` AS `decoration_comment`,
        `decoration`.`awarded` AS `awarded`,
        `decoration`.`awarded_by` AS `awarded_by_id`,
        `acg_member`.`callsign` AS `awarded_by_callsign`,
        `decoration`.`recommendation_date` AS `recommendation_date`,
        `award`.`name` AS `award_name`,
        `award`.`abreviation` AS `award_abr`,
        `award`.`image` AS `award_image`,
        `award`.`faction` AS `faction`
    FROM
        (((`decoration`
        LEFT JOIN `award` ON ((`decoration`.`award_id` = `award`.`id`)))
        LEFT JOIN `career_character` ON ((`decoration`.`character_id` = `career_character`.`id`)))
        LEFT JOIN `acg_member` ON ((`decoration`.`awarded_by` = `acg_member`.`id`)))