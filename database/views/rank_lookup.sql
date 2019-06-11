CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `pam`.`rank_lookup` AS
    SELECT 
        `rank_translation`.`real_value` AS `real_value`,
        `pam`.`rank`.`name` AS `rank_name`,
        `pam`.`rank`.`abreviation` AS `abreviation`,
        `pam`.`rank`.`value` AS `disp_value`,
        `pam`.`rank`.`faction` AS `faction`,
        `pam`.`rank`.`image` AS `image`
    FROM
        (`pam`.`rank_translation`
        JOIN `pam`.`rank` ON (((`pam`.`rank`.`value` = `rank_translation`.`disp_value`)
            AND (`pam`.`rank`.`faction` = `rank_translation`.`faction`))))