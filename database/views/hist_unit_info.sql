CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `hist_unit_info` AS
    SELECT 
        `hist_unit`.`id` AS `id`,
        `hist_unit`.`name` AS `name`,
        `hist_unit`.`code` AS `code`,
        `hist_unit`.`faction` AS `faction`,
        `hist_unit`.`type` AS `type`,
        `hist_unit`.`description` AS `description`,
        `hist_unit`.`image` AS `image`
    FROM
        `hist_unit`
    WHERE
        (`hist_unit`.`id` <> 1)
    ORDER BY `hist_unit`.`faction` , `hist_unit`.`name`