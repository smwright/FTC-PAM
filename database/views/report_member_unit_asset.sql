CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `report_member_unit_asset` AS
    SELECT 
        `report`.`id` AS `report_id`,
        `report`.`mission_id` AS `mission_id`,
        `cc`.`personified_by` AS `member_id`,
        `report`.`deployed_unit_id` AS `depl_unit_id`,
        `du`.`acg_unit_id` AS `acg_unit_id`,
        `hu`.`id` AS `hist_unit_id`,
        `hu`.`name` AS `hist_unit_name`,
        `hu`.`faction` AS `faction`,
        `a`.`id` AS `asset_id`,
        `a`.`name` AS `asset_name`
    FROM
        ((((`report`
        LEFT JOIN `career_character` `cc` ON ((`cc`.`id` = `report`.`character_id`)))
        LEFT JOIN `deployed_unit` `du` ON ((`du`.`id` = `report`.`deployed_unit_id`)))
        LEFT JOIN `asset` `a` ON ((`a`.`id` = `report`.`asset_id`)))
        LEFT JOIN `hist_unit` `hu` ON ((`hu`.`id` = `du`.`hist_unit_id`)))
    WHERE
        (`report`.`accepted` = 1)