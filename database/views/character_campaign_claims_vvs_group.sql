CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `character_campaign_claim_vvs_group` AS
    SELECT 
        `report`.`character_id` AS `character_id`,
        `mission`.`campaign_id` AS `campaign_id`,
        `career_character`.`personified_by` AS `member_id`,
        `claim_vvs_group`.`conf` AS `conf`,
        `claim_vvs_group`.`unconf` AS `unconf`
    FROM
        (`vvs_group_claims_per_mission_unit` `claim_vvs_group`
        LEFT JOIN ((`report`
        JOIN `mission` ON ((`mission`.`id` = `report`.`mission_id`)))
        JOIN `career_character` ON ((`career_character`.`id` = `report`.`character_id`))) ON (((`claim_vvs_group`.`deployed_unit_id` = `report`.`deployed_unit_id`)
            AND (`claim_vvs_group`.`mission_id` = `report`.`mission_id`))))