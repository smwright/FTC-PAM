CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `claim_ground_info` AS
    SELECT 
        `claim`.`id` AS `claim_id`,
        `claim`.`report_id` AS `report_id`,
        `claim`.`description` AS `description`,
        `claim`.`accepted` AS `accepted`,
        `asset`.`name` AS `asset_name`,
        `claim_ground`.`amount` AS `amount`
    FROM
        ((`claim`
        JOIN `claim_ground` ON ((`claim_ground`.`claim_id` = `claim`.`id`)))
        JOIN `asset` ON ((`asset`.`id` = `claim`.`asset_id`)))