CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `report_info` AS
    SELECT 
        `report`.`id` AS `report_id`,
        `report`.`mission_id` AS `mission_id`,
        `mission`.`campaign_id` AS `campaign_id`,
        `report`.`deployed_unit_id` AS `depl_unit_id`,
        `deployed_unit`.`acg_unit_id` AS `acg_unit_id`,
        `report`.`asset_id` AS `asset_id`,
        `report`.`base` AS `base`,
        `report`.`markings` AS `markings`,
        `report`.`asset_status` AS `asset_status`,
        `report`.`pilot_status` AS `pilot_status`,
        `report`.`synopsis` AS `synopsis`,
        `report`.`date_submitted` AS `date_submitted`,
        `report`.`accepted` AS `accepted`,
        `report`.`accepted_by` AS `accepted_by`,
        `career_character`.`id` AS `character_id`,
        `career_character`.`first_name` AS `first_name`,
        `career_character`.`last_name` AS `last_name`,
        `career_character`.`portrait_seed` AS `portrait_seed`,
        `acg_member`.`id` AS `member_id`,
        `acg_member`.`callsign` AS `callsign`,
        `hist_unit`.`faction` AS `faction`,
        `hist_unit`.`name` AS `hist_unit_name`,
        `hist_unit`.`image` AS `hist_unit_image`,
        `mission`.`hist_date` AS `mission_hist_date`,
        `mission`.`real_date` AS `mission_real_date`,
        `mission`.`name` AS `mission_name`,
        `campaign`.`name` AS `campaign_name`,
        `mission_member_rank`.`real_value` AS `rank_value`,
        `mission_member_rank`.`rank_name` AS `rank_name`,
        `mission_member_rank`.`abreviation` AS `abreviation`,
        `mission_member_rank`.`image` AS `image`
    FROM
        ((((((((`report`
        LEFT JOIN `mission` ON ((`mission`.`id` = `report`.`mission_id`)))
        LEFT JOIN `campaign` ON ((`campaign`.`id` = `mission`.`campaign_id`)))
        LEFT JOIN `deployed_unit` ON ((`deployed_unit`.`id` = `report`.`deployed_unit_id`)))
        LEFT JOIN `hist_unit` ON ((`hist_unit`.`id` = `deployed_unit`.`hist_unit_id`)))
        LEFT JOIN `career_character` ON ((`career_character`.`id` = `report`.`character_id`)))
        LEFT JOIN `acg_member` ON ((`acg_member`.`id` = `career_character`.`personified_by`)))
        LEFT JOIN `asset` ON ((`asset`.`id` = `report`.`asset_id`)))
        LEFT JOIN `mission_member_rank` ON (((`mission_member_rank`.`mission_id` = `report`.`mission_id`)
            AND (`mission_member_rank`.`member_id` = `acg_member`.`id`)
            AND (`mission_member_rank`.`faction` = `hist_unit`.`faction`))))