CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `rank_translation` AS
    SELECT 
        `rank`.`value` AS `real_value`,
        MIN(`x`.`value`) AS `disp_value`,
        `x`.`faction` AS `faction`
    FROM
        (`rank`
        LEFT JOIN `rank` `x` ON ((`x`.`value` >= `rank`.`value`)))
    GROUP BY `rank`.`value` , `x`.`faction`