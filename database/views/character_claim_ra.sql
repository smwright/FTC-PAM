CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `character_claim_ra` AS
    SELECT 
        `report`.`character_id` AS `character_id`,
        `report`.`id` AS `report_id`,
        `mission`.`id` AS `mission_id`,
        `mission`.`campaign_id` AS `campaign_id`,
        `career_character`.`personified_by` AS `member_id`,
        SUM(((1 - (`claim_ra`.`shared` * 0.5)) * (`claim_ra`.`enemy_status` = 0))) AS `destroyed`,
        SUM(((1 - (`claim_ra`.`shared` * 0.5)) * (`claim_ra`.`enemy_status` = 1))) AS `probables`,
        SUM((`claim_ra`.`enemy_status` = 2)) AS `damaged`
    FROM
        (`claim_ra`
        LEFT JOIN (((`report`
        JOIN `mission` ON ((`mission`.`id` = `report`.`mission_id`)))
        JOIN `career_character` ON ((`career_character`.`id` = `report`.`character_id`)))
        JOIN `claim` ON ((`claim`.`report_id` = `report`.`id`))) ON ((`claim_ra`.`claim_id` = `claim`.`id`)))
    WHERE
        (`claim`.`accepted` = 1)
    GROUP BY `report`.`character_id` , `report`.`id` , `mission`.`id` , `mission`.`campaign_id` , `career_character`.`personified_by`