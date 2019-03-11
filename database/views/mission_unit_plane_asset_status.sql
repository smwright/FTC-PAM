CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `mission_unit_plane_asset_status` AS
    SELECT 
        `report`.`deployed_unit_id` AS `depl_unit_id`,
        `report`.`mission_id` AS `mission_id`,
        COUNT(`report`.`id`) AS `sorties`,
        SUM((`report`.`pilot_status` = 0)) AS `pilot_ok`,
        SUM((`report`.`pilot_status` = 1)) AS `pilot_wounded`,
        SUM((`report`.`pilot_status` = 2)) AS `pilot_pow`,
        SUM((`report`.`pilot_status` = 3)) AS `pilot_kia`,
        SUM((`report`.`asset_status` = 0)) AS `asset_ok`,
        SUM((`report`.`asset_status` = 1)) AS `asset_damaged`,
        SUM((`report`.`asset_status` = 2)) AS `asset_lost`
    FROM
        `report`
    GROUP BY `report`.`deployed_unit_id` , `report`.`mission_id`