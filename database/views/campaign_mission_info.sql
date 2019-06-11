CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `campaign_mission_info` AS
    SELECT 
        `mission`.`id` AS `id`,
        `mission`.`name` AS `name`,
        `mission`.`campaign_id` AS `campaign_id`,
        `mission`.`real_date` AS `real_date`,
        `mission`.`hist_date` AS `hist_date`,
        `mission`.`mission_status` AS `mission_status`
    FROM
        `mission`