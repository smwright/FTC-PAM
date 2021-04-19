CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `claim_ra_info` AS
    SELECT 
        `claim`.`id` AS `claim_id`,
        `claim`.`report_id` AS `report_id`,
        `claim`.`description` AS `description`,
        `claim`.`accepted` AS `accepted`,
        `claim`.`accepted_by` AS `accepted_by`,
        `claim`.`asset_id` AS `asset_id`,
        `asset`.`name` AS `asset_name`,
        `claim_ra`.`id` AS `claim_detail_id`,
        `claim_ra`.`enemy_status` AS `enemy_status`,
        `claim_ra`.`shared` AS `shared`
    FROM
        (`claim_ra`
        LEFT JOIN (`claim`
        JOIN `asset` ON ((`asset`.`id` = `claim`.`asset_id`))) ON ((`claim_ra`.`claim_id` = `claim`.`id`)))