CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `mission_report_nav_list` AS
    SELECT 
        `report`.`mission_id` AS `mission_id`,
        `report`.`deployed_unit_id` AS `depl_unit_id`,
        `report`.`id` AS `report_id`,
        `report`.`date_submitted` AS `date_submitted`,
        `report`.`pilot_status` AS `pilot_status`,
        `report`.`asset_status` AS `asset_status`,
        `career_character`.`id` AS `character_id`,
        `career_character`.`first_name` AS `first_name`,
        `career_character`.`last_name` AS `last_name`,
        `acg_member`.`id` AS `member_id`,
        `acg_member`.`callsign` AS `callsign`,
        `accepting_member`.`callsign` AS `accepting_member`,
        `mission_member_rank`.`abreviation` AS `abreviation`,
        `report`.`accepted` AS `accepted`,
        `asset`.`id` AS `asset_id`,
        `asset`.`name` AS `asset_name`
    FROM
        (((((((`report`
        JOIN `career_character` ON ((`career_character`.`id` = `report`.`character_id`)))
        JOIN `acg_member` ON ((`acg_member`.`id` = `career_character`.`personified_by`)))
        LEFT JOIN `acg_member` `accepting_member` ON ((`accepting_member`.`id` = `report`.`accepted_by`)))
        JOIN `deployed_unit` ON ((`deployed_unit`.`id` = `report`.`deployed_unit_id`)))
        JOIN `hist_unit` ON ((`hist_unit`.`id` = `deployed_unit`.`hist_unit_id`)))
        JOIN `asset` ON ((`asset`.`id` = `report`.`asset_id`)))
        JOIN `mission_member_rank` ON (((`mission_member_rank`.`mission_id` = `report`.`mission_id`)
            AND (`mission_member_rank`.`member_id` = `acg_member`.`id`)
            AND (`mission_member_rank`.`faction` = `hist_unit`.`faction`))))
    ORDER BY `mission_member_rank`.`real_value` DESC , `acg_member`.`id`