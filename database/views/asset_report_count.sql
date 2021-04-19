CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `asset_report_count` AS
    SELECT 
        `report`.`asset_id` AS `asset_id`,
        COUNT(`report`.`id`) AS `report_count`
    FROM
        `report`
    GROUP BY `report`.`asset_id`