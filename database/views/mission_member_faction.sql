CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `mission_member_faction` AS
    SELECT 
        `transfer`.`member_id` AS `member_id`,
        `mission`.`id` AS `mission_id`,
        `deployed_unit`.`id` AS `depl_unit_id`,
        `deployed_unit`.`acg_unit_id` AS `acg_unit_id`,
        `deployed_unit`.`lft` AS `lft`,
        `deployed_unit`.`rgt` AS `rgt`,
        `hist_unit`.`faction` AS `faction`
    FROM
        (((`transfer`
        LEFT JOIN `deployed_unit` ON ((`deployed_unit`.`acg_unit_id` = `transfer`.`acg_unit_id`)))
        LEFT JOIN `mission` ON ((`mission`.`campaign_id` = `deployed_unit`.`campaign_id`)))
        LEFT JOIN `hist_unit` ON ((`deployed_unit`.`hist_unit_id` = `hist_unit`.`id`)))
    WHERE
        ((`transfer`.`transfer_date_in` <= `mission`.`real_date`)
            AND ((`mission`.`real_date` < `transfer`.`transfer_date_out`)
            OR ISNULL(`transfer`.`transfer_date_out`)))