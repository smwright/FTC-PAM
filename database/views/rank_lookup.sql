CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `rank_lookup` AS
    SELECT 
        `rank_translation`.`real_value` AS `real_value`,
        `rank`.`name` AS `rank_name`,
        `rank`.`abreviation` AS `abreviation`,
        `rank`.`value` AS `disp_value`,
        `rank`.`faction` AS `faction`,
        `rank`.`image` AS `image`
    FROM
        (`rank`
        JOIN `rank_translation` ON ((`rank_translation`.`disp_value` = `rank`.`value`)))