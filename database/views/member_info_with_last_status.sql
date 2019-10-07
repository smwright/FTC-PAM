CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `member_info_with_last_status` AS
    SELECT 
        `acg_member`.`id` AS `member_id`,
        `acg_member`.`username` AS `username`,
        `acg_member`.`callsign` AS `callsign`,
        `acg_member`.`admin` AS `admin`,
        `member_max_status`.`member_status` AS `member_status`,
        `member_max_transfer`.`acg_unit_id` AS `acg_unit_id`
    FROM
        ((`acg_member`
        LEFT JOIN `member_max_status` ON ((`member_max_status`.`member_id` = `acg_member`.`id`)))
        LEFT JOIN `member_max_transfer` ON ((`member_max_transfer`.`member_id` = `acg_member`.`id`)))