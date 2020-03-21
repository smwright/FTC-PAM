CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `decoration_info` AS
    SELECT 
        `decoration`.`id` AS `decoration_id`,
        `decoration`.`character_id` AS `character_id`,
        `career_character`.`first_name` AS `first_name`,
        `career_character`.`last_name` AS `last_name`,
        `career_character`.`personified_by` AS `member_id`,
        `decoration`.`award_id` AS `award_id`,
        `decoration`.`date` AS `decoration_date`,
        `decoration`.`comment` AS `decoration_comment`,
        `decoration`.`awarded` AS `awarded`,
        `decoration`.`awarded_by` AS `awarded_by_id`,
        `acg_member`.`callsign` AS `awarded_by_callsign`,
        `acg_m_2`.`callsign` AS `callsign`,
        `decoration`.`recommendation_date` AS `recommendation_date`,
        `award`.`name` AS `award_name`,
        `award`.`abreviation` AS `award_abr`,
        `award`.`image` AS `award_image`,
        `award`.`faction` AS `faction`,
        `mission_member_rank`.`abreviation` AS `abreviation`,
        `mission_member_rank`.`disp_value` AS `rank_disp_value`,
        `mission_member_faction`.`acg_unit_id` AS `acg_unit_id`
    FROM
        ((((((((`decoration`
        LEFT JOIN `award` ON ((`decoration`.`award_id` = `award`.`id`)))
        LEFT JOIN `career_character` ON ((`decoration`.`character_id` = `career_character`.`id`)))
        LEFT JOIN `acg_member` ON ((`decoration`.`awarded_by` = `acg_member`.`id`)))
        LEFT JOIN `acg_member` `acg_m_2` ON ((`career_character`.`personified_by` = `acg_m_2`.`id`)))
        LEFT JOIN `character_latest_mission_date` ON ((`character_latest_mission_date`.`character_id` = `career_character`.`id`)))
        LEFT JOIN `mission` ON ((`mission`.`real_date` = `character_latest_mission_date`.`max_mission_date`)))
        LEFT JOIN `mission_member_faction` ON (((`mission_member_faction`.`mission_id` = `mission`.`id`)
            AND (`mission_member_faction`.`member_id` = `acg_m_2`.`id`))))
        LEFT JOIN `mission_member_rank` ON (((`mission_member_rank`.`mission_id` = `mission`.`id`)
            AND (`mission_member_rank`.`member_id` = `acg_m_2`.`id`)
            AND (`mission_member_rank`.`faction` = `mission_member_faction`.`faction`))))