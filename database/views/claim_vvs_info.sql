CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `claim_vvs_info` AS
    SELECT 
        `claim`.`id` AS `claim_id`,
        `claim`.`report_id` AS `report_id`,
        `claim`.`description` AS `description`,
        `claim`.`accepted` AS `accepted`,
        `claim`.`asset_id` AS `asset_id`,
        `claim`.`accepted_by` AS `accepted_by`,
        `claim_vvs`.`id` AS `claim_detail_id`,
        `claim_vvs`.`claim_time` AS `claim_time`,
        `claim_vvs`.`place` AS `place`,
        `claim_vvs`.`group_claim` AS `group_claim`,
        `claim_vvs`.`confirmed` AS `confirmed`,
        `claim_vvs`.`witness` AS `witness_id`,
        `acg_member`.`callsign` AS `witness_callsign`
    FROM
        ((`claim`
        JOIN `claim_vvs` ON ((`claim_vvs`.`claim_id` = `claim`.`id`)))
        LEFT JOIN `acg_member` ON ((`acg_member`.`id` = `claim_vvs`.`witness`)))