CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `character_claim_ground` AS
    SELECT 
        `report`.`character_id` AS `character_id`,
        `report`.`id` AS `report_id`,
        `mission`.`id` AS `mission_id`,
        `mission`.`campaign_id` AS `campaign_id`,
        `career_character`.`personified_by` AS `member_id`,
        `asset`.`name` AS `asset_name`,
        SUM(`claim_ground`.`amount`) AS `amount`
    FROM
        (`claim_ground`
        LEFT JOIN ((((`report`
        JOIN `mission` ON ((`report`.`mission_id` = `mission`.`id`)))
        JOIN `career_character` ON ((`career_character`.`id` = `report`.`character_id`)))
        JOIN `claim` ON ((`claim`.`report_id` = `report`.`id`)))
        JOIN `asset` ON ((`asset`.`id` = `claim`.`asset_id`))) ON ((`claim_ground`.`claim_id` = `claim`.`id`)))
    WHERE
        (`claim`.`accepted` = 1)
    GROUP BY `report`.`character_id` , `report`.`id` , `mission`.`id` , `mission`.`campaign_id` , `member_id` , `asset`.`name`