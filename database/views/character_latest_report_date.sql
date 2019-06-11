CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `character_latest_report_date` AS
    SELECT 
        `report`.`character_id` AS `character_id`,
        MAX((UNIX_TIMESTAMP(`mission`.`real_date`) + `report`.`id`)) AS `max_report_timestamp`
    FROM
        (`report`
        LEFT JOIN `mission` ON ((`mission`.`id` = `report`.`mission_id`)))
    GROUP BY `report`.`character_id`