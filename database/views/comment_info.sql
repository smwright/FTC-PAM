CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `comment_info` AS
    SELECT 
        `comment`.`id` AS `comment_id`,
        `comment`.`report_id` AS `report_id`,
        `acg_member`.`callsign` AS `commentator`,
        `comment`.`comment_date` AS `comment_date`,
        `comment`.`comment_text` AS `comment_text`
    FROM
        (`comment`
        JOIN `acg_member` ON ((`acg_member`.`id` = `comment`.`member_id`)))