CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `character_mission_claims` AS
    SELECT 
        `report`.`id` AS `report_id`,
        `career_character`.`id` AS `character_id`,
        `career_character`.`personified_by` AS `member_id`,
        SUM(((`claim_lw_info`.`accepted` = 1)
            AND (`claim_lw_info`.`confirmed` = 1))) AS `claim_lw_conf`,
        SUM(((`claim_lw_info`.`accepted` = 1)
            AND (`claim_lw_info`.`confirmed` = 0))) AS `claim_lw_unconf`,
        SUM((((`claim_raf_info`.`accepted` = 1)
            AND (`claim_raf_info`.`enemy_status` = 0)) * (1 - (0.5 * `claim_raf_info`.`shared`)))) AS `claim_raf_destr`,
        SUM((((`claim_raf_info`.`accepted` = 1)
            AND (`claim_raf_info`.`enemy_status` = 1)) * (1 - (0.5 * `claim_raf_info`.`shared`)))) AS `claim_raf_prob`,
        SUM((`claim_raf_info`.`enemy_status` = 2)) AS `claim_raf_damaged`,
        SUM(((`claim_vvs_info`.`accepted` = 1)
            AND (`claim_vvs_info`.`confirmed` = 1)
            AND (`claim_vvs_info`.`group_claim` = 0))) AS `claim_vvs_pers_conf`,
        SUM(((`claim_vvs_info`.`accepted` = 1)
            AND (`claim_vvs_info`.`confirmed` = 0)
            AND (`claim_vvs_info`.`group_claim` = 0))) AS `claim_vvs_pers_unconf`,
        SUM(`claim_vvs_group_info`.`conf`) AS `claim_vvs_group_conf`,
        SUM(`claim_vvs_group_info`.`unconf`) AS `claim_vvs_group_unconf`
    FROM
        (((((`report`
        LEFT JOIN `career_character` ON ((`career_character`.`id` = `report`.`character_id`)))
        LEFT JOIN `claim_lw_info` ON ((`claim_lw_info`.`report_id` = `report`.`id`)))
        LEFT JOIN `claim_raf_info` ON ((`claim_raf_info`.`report_id` = `report`.`id`)))
        LEFT JOIN `claim_vvs_info` ON ((`claim_vvs_info`.`report_id` = `report`.`id`)))
        LEFT JOIN `vvs_group_claims_per_mission_unit` `claim_vvs_group_info` ON (((`claim_vvs_group_info`.`deployed_unit_id` = `report`.`deployed_unit_id`)
            AND (`claim_vvs_group_info`.`mission_id` = `report`.`mission_id`))))
    WHERE
        ((`career_character`.`personified_by` = 1)
            AND (`report`.`accepted` = 1))
    GROUP BY `report_id` , `report`.`character_id` , `member_id`