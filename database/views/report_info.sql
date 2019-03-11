CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `report_info` AS
    SELECT 
        `report`.`id` AS `report_id`,
        `report`.`mission_id` AS `mission_id`,
        `report`.`deployed_unit_id` AS `depl_unit_id`,
        `report`.`base` AS `base`,
        `report`.`markings` AS `markings`,
        `report`.`asset_status` AS `asset_status`,
        `report`.`pilot_status` AS `pilot_status`,
        `report`.`synopsis` AS `synopsis`,
        `report`.`date_submitted` AS `date_submitted`,
        `report`.`accepted` AS `accepted`,
        `examiner`.`callsign` AS `examiner_callsign`,
        `career_character`.`id` AS `character_id`,
        `career_character`.`first_name` AS `first_name`,
        `career_character`.`last_name` AS `last_name`,
        `acg_member`.`id` AS `member_id`,
        `acg_member`.`callsign` AS `callsign`,
        `hist_unit`.`id` AS `hist_unit_id`,
        `hist_unit`.`name` AS `unit_name`,
        `hist_unit`.`code` AS `unit_code`,
        `hist_unit`.`faction` AS `faction`,
        `asset`.`id` AS `asset_id`,
        `asset`.`name` AS `asset_name`,
        `mission_member_rank`.`real_value` AS `rank_value`,
        `mission_member_rank`.`rank_name` AS `rank_name`,
        `mission_member_rank`.`abreviation` AS `abreviation`,
        `mission_member_rank`.`image` AS `image`
    FROM
        (((((((`report`
        JOIN `deployed_unit` ON ((`deployed_unit`.`id` = `report`.`deployed_unit_id`)))
        JOIN `hist_unit` ON ((`hist_unit`.`id` = `deployed_unit`.`hist_unit_id`)))
        JOIN `career_character` ON ((`career_character`.`id` = `report`.`character_id`)))
        JOIN `acg_member` ON ((`acg_member`.`id` = `career_character`.`personified_by`)))
        JOIN `acg_member` `examiner` ON ((`report`.`accepted_by` = `examiner`.`id`)))
        JOIN `asset` ON ((`asset`.`id` = `report`.`asset_id`)))
        JOIN `mission_member_rank` ON (((`mission_member_rank`.`mission_id` = `report`.`mission_id`)
            AND (`mission_member_rank`.`member_id` = `acg_member`.`id`)
            AND (`mission_member_rank`.`faction` = `hist_unit`.`faction`))))