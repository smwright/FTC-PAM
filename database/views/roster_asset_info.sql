CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `roster_asset_info` AS
    SELECT 
        `r`.`id` AS `id`,
        `r`.`asset_id` AS `asset_id`,
        `r`.`markings` AS `markings`,
        `r`.`image` AS `image`,
        `r`.`hist_unit_id` AS `hist_unit_id`,
        `a`.`name` AS `asset_name`,
        `h`.`name` AS `hist_unit_name`,
        `h`.`code` AS `hist_unit_code`
    FROM
        ((`roster_asset` `r`
        LEFT JOIN `asset` `a` ON ((`r`.`asset_id` = `a`.`id`)))
        LEFT JOIN `hist_unit` `h` ON ((`r`.`hist_unit_id` = `h`.`id`)))