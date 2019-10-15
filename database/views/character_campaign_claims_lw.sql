CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `character_campaign_claim_lw` AS
    SELECT 
        `report`.`character_id` AS `character_id`,
        `mission`.`campaign_id` AS `campaign_id`,
        `career_character`.`personified_by` AS `member_id`,
        SUM((`claim_lw`.`confirmed` = 1)) AS `conf`,
        SUM((`claim_lw`.`confirmed` = 0)) AS `unconf`
    FROM
        (`claim_lw`
        LEFT JOIN (((`report`
        JOIN `mission` ON ((`mission`.`id` = `report`.`mission_id`)))
        JOIN `career_character` ON ((`career_character`.`id` = `report`.`character_id`)))
        JOIN `claim` ON ((`claim`.`report_id` = `report`.`id`))) ON ((`claim_lw`.`claim_id` = `claim`.`id`)))
    WHERE
        (`claim`.`accepted` = 1)
    GROUP BY `report`.`character_id` , `mission`.`campaign_id` , `member_id`