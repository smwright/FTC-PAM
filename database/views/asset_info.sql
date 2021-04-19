CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `asset_info` AS
    SELECT 
        `asset`.`lft` AS `lft`,
        `asset`.`rgt` AS `rgt`,
        `asset`.`name` AS `name`,
        `asset`.`id` AS `id`,
        `asset`.`faction` AS `faction`,
        `asset`.`controlable` AS `controlable`,
        `asset`.`claimable` AS `claimable`,
        `acc`.`claim_count` AS `claim_count`,
        `arc`.`report_count` AS `report_count`
    FROM
        ((`asset`
        LEFT JOIN `asset_report_count` `arc` ON ((`asset`.`id` = `arc`.`asset_id`)))
        LEFT JOIN `asset_claim_count` `acc` ON ((`asset`.`id` = `acc`.`asset_id`)))
    ORDER BY `asset`.`lft`