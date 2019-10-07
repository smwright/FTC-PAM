CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `transfer_info` AS
    SELECT 
        `transfer`.`id` AS `id`,
        `transfer`.`member_id` AS `member_id`,
        `transfer`.`acg_unit_id` AS `acg_unit_id`,
        `transfer`.`transfer_date_in` AS `transfer_date_in`,
        `transfer`.`transfer_date_out` AS `transfer_date_out`
    FROM
        `transfer`
    ORDER BY `transfer`.`transfer_date_in` , `transfer`.`id`