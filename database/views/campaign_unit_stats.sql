CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `cl45-acg-pam-2`@`%` 
    SQL SECURITY DEFINER
VIEW `campaign_unit_stats` AS
    SELECT 
        `deployed_unit`.`campaign_id` AS `campaign_id`,
        COUNT(`deployed_unit`.`acg_unit_id`) AS `units`
    FROM
        `deployed_unit`
    WHERE
        (`deployed_unit`.`acg_unit_id` IS NOT NULL)
    GROUP BY `deployed_unit`.`campaign_id`