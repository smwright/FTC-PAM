CREATE VIEW `current_unit_members` AS
    SELECT 
        `member_max_transfer`.`member_id` AS `member_id`,
        `member_max_transfer`.`acg_unit_id` AS `acg_unit_id`,
        `acg_member`.`id` AS `id`,
        `acg_member`.`callsign` AS `callsign`,
        `member_max_status`.`member_status` AS `member_status`
    FROM
        ((`member_max_transfer`
        LEFT JOIN `member_max_status` ON ((`member_max_status`.`member_id` = `member_max_transfer`.`member_id`)))
        LEFT JOIN `acg_member` ON ((`acg_member`.`id` = `member_max_transfer`.`member_id`)))
    WHERE
        ((`member_max_status`.`member_status` = 0)
            OR (`member_max_status`.`member_status` = 3))