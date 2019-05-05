CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `member_max_transfer` AS
    SELECT 
        `transfer`.`id` AS `id`,
        `transfer`.`member_id` AS `member_id`,
        `transfer`.`acg_unit_id` AS `acg_unit_id`,
        `transfer`.`transfer_date_in` AS `transfer_date_in`,
        `transfer`.`transfer_date_out` AS `transfer_date_out`
    FROM
        `transfer`
    WHERE
        ISNULL(`transfer`.`transfer_date_out`)