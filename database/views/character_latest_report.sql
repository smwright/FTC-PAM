CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `character_latest_report` AS
    SELECT 
        `character_latest_report_date`.`character_id` AS `character_id`,
        `career_character`.`personified_by` AS `member_id`,
        `career_character`.`first_name` AS `first_name`,
        `career_character`.`last_name` AS `last_name`,
        `report`.`deployed_unit_id` AS `deployed_unit_id`,
        `report`.`pilot_status` AS `character_status`,
        `hist_unit`.`faction` AS `faction`,
        `hist_unit`.`name` AS `hist_unit_name`,
        `mission`.`hist_date` AS `last_mission_hist_date`,
        `mission_member_rank`.`rank_name` AS `rank_name`,
        `mission_member_rank`.`abreviation` AS `rank_abreviation`,
        `mission_member_rank`.`image` AS `rank_image`
    FROM
        ((`character_latest_report_date`
        JOIN (`career_character`
        LEFT JOIN (((`report`
        LEFT JOIN `mission` ON ((`mission`.`id` = `report`.`mission_id`)))
        LEFT JOIN `deployed_unit` ON ((`deployed_unit`.`id` = `report`.`deployed_unit_id`)))
        LEFT JOIN `hist_unit` ON ((`hist_unit`.`id` = `deployed_unit`.`hist_unit_id`))) ON ((`career_character`.`id` = `report`.`character_id`))))
        LEFT JOIN `mission_member_rank` ON (((`mission_member_rank`.`mission_id` = `mission`.`id`)
            AND (`mission_member_rank`.`member_id` = `career_character`.`personified_by`)
            AND (`mission_member_rank`.`faction` = `hist_unit`.`faction`))))
    WHERE
        (`character_latest_report_date`.`max_report_timestamp` = (UNIX_TIMESTAMP(`mission`.`real_date`) + `report`.`id`))