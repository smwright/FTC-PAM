CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `asset_claim_count` AS
    SELECT 
        `claim`.`asset_id` AS `asset_id`,
        COUNT(`claim`.`id`) AS `claim_count`
    FROM
        `claim`
    GROUP BY `claim`.`asset_id`