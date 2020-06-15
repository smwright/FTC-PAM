CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `mission_unit_attending_members` AS
    SELECT DISTINCT
        `report`.`mission_id` AS `mission_id`,
        `mission`.`campaign_id` AS `campaign_id`,
        `cc`.`personified_by` AS `member_id`,
        `report`.`deployed_unit_id` AS `depl_unit_id`,
        `du`.`acg_unit_id` AS `acg_unit_id`,
        `hu`.`id` AS `hist_unit_id`,
        `hu`.`name` AS `hist_unit_name`,
        `hu`.`faction` AS `faction`
    FROM
        ((((`report`
        LEFT JOIN `mission` ON ((`report`.`mission_id` = `mission`.`id`)))
        LEFT JOIN `career_character` `cc` ON ((`cc`.`id` = `report`.`character_id`)))
        LEFT JOIN `deployed_unit` `du` ON ((`du`.`id` = `report`.`deployed_unit_id`)))
        LEFT JOIN `hist_unit` `hu` ON ((`hu`.`id` = `du`.`hist_unit_id`)))
    WHERE
        (`report`.`accepted` = 1)