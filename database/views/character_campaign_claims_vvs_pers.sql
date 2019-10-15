CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `character_campaign_claim_vvs_pers` AS
    SELECT 
        `report`.`character_id` AS `character_id`,
        `mission`.`campaign_id` AS `campaign_id`,
        `career_character`.`personified_by` AS `member_id`,
        SUM((`claim_vvs`.`confirmed` = 1)) AS `conf`,
        SUM((`claim_vvs`.`confirmed` = 0)) AS `unconf`
    FROM
        ((((`report`
        JOIN `mission` ON ((`mission`.`id` = `report`.`mission_id`)))
        JOIN `career_character` ON ((`career_character`.`id` = `report`.`character_id`)))
        JOIN `claim` ON ((`claim`.`report_id` = `report`.`id`)))
        JOIN `claim_vvs` ON ((`claim_vvs`.`claim_id` = `claim`.`id`)))
    WHERE
        ((`claim`.`accepted` = 1)
            AND (`claim_vvs`.`group_claim` = 0))
    GROUP BY `report`.`character_id` , `mission`.`campaign_id` , `member_id`