CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `briefing_info` AS
    SELECT 
        `briefing`.`id` AS `id`,
        `briefing`.`mission_id` AS `mission_id`,
        `briefing`.`faction` AS `faction`,
        `briefing`.`text` AS `text`,
        `mission`.`campaign_id` AS `campaign_id`
    FROM
        (`briefing`
        LEFT JOIN `mission` ON ((`mission`.`id` = `briefing`.`mission_id`)))