CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `mission_unit_attending_members_count` AS
    SELECT 
        `x`.`mission_id` AS `mission_id`,
        `x`.`acg_unit_id` AS `acg_unit_id`,
        `x`.`campaign_id` AS `campaign_id`,
        IFNULL(COUNT(`x`.`member_id`), 0) AS `attending_members`
    FROM
        `mission_unit_attending_members` `x`
    GROUP BY `x`.`mission_id` , `x`.`acg_unit_id` , `x`.`campaign_id` 
    UNION SELECT 
        `x`.`mission_id` AS `mission_id`,
        0 AS `acg_unit_id`,
        `x`.`campaign_id` AS `campaign_id`,
        IFNULL(COUNT(`x`.`member_id`), 0) AS `attending_members`
    FROM
        `mission_unit_attending_members` `x`
    GROUP BY `x`.`mission_id` , `x`.`campaign_id`