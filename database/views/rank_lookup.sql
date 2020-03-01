CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `rank_lookup` AS
    SELECT 
        `rank_translation`.`real_value` AS `real_value`,
        `rank`.`id` AS `rank_id`,
        `rank`.`name` AS `rank_name`,
        `rank`.`abreviation` AS `abreviation`,
        `rank`.`value` AS `disp_value`,
        `rank`.`faction` AS `faction`,
        `rank`.`image` AS `image`
    FROM
        (`rank_translation`
        JOIN `rank` ON (((`rank`.`value` = `rank_translation`.`disp_value`)
            AND (`rank`.`faction` = `rank_translation`.`faction`))))