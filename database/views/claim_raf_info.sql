CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `claim_raf_info` AS
    SELECT 
        `claim`.`id` AS `claim_id`,
        `claim`.`report_id` AS `report_id`,
        `claim`.`description` AS `description`,
        `claim`.`accepted` AS `accepted`,
        `claim`.`accepted_by` AS `accepted_by`,
        `asset`.`name` AS `asset_name`,
        `claim_raf`.`id` AS `claim_detail_id`,
        `claim_raf`.`enemy_status` AS `enemy_status`,
        `claim_raf`.`shared` AS `shared`
    FROM
        (`claim_raf`
        LEFT JOIN (`claim`
        JOIN `asset` ON ((`asset`.`id` = `claim`.`asset_id`))) ON ((`claim_raf`.`claim_id` = `claim`.`id`)))