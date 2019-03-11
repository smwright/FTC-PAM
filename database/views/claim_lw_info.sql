CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `claim_lw_info` AS
    SELECT 
        `claim`.`id` AS `claim_id`,
        `claim`.`report_id` AS `report_id`,
        `claim`.`description` AS `description`,
        `claim`.`accepted` AS `accepted`,
        `asset`.`name` AS `asset_name`,
        `claim_lw`.`claim_time` AS `claim_time`,
        `claim_lw`.`place` AS `place`,
        `claim_lw`.`opponent` AS `opponent`,
        `claim_lw`.`fate_of_crew` AS `fate_of_crew`,
        `claim_lw`.`type_of_destruction` AS `type_of_destruction`,
        `claim_lw`.`type_of_impact` AS `type_of_impact`,
        `claim_lw`.`confirmed` AS `confirmed`,
        `claim_lw`.`witness` AS `witness_id`,
        `acg_member`.`callsign` AS `witness_callsign`
    FROM
        (((`claim`
        JOIN `asset` ON ((`asset`.`id` = `claim`.`asset_id`)))
        JOIN `claim_lw` ON ((`claim_lw`.`claim_id` = `claim`.`id`)))
        JOIN `acg_member` ON ((`acg_member`.`id` = `claim_lw`.`witness`)))