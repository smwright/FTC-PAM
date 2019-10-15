CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `vvs_group_claims_per_mission_unit` AS
    SELECT 
        `report`.`deployed_unit_id` AS `deployed_unit_id`,
        `report`.`mission_id` AS `mission_id`,
        SUM((`claim_vvs`.`confirmed` = 1)) AS `conf`,
        SUM((`claim_vvs`.`confirmed` = 0)) AS `unconf`
    FROM
        ((`claim`
        LEFT JOIN `claim_vvs` ON ((`claim_vvs`.`claim_id` = `claim`.`id`)))
        LEFT JOIN `report` ON ((`claim`.`report_id` = `report`.`id`)))
    WHERE
        ((`claim`.`accepted` = 1)
            AND (`claim_vvs`.`group_claim` = 1))
    GROUP BY `report`.`deployed_unit_id` , `report`.`mission_id`