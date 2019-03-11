CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `campaign_unit_plane_asset_status` AS
    SELECT 
        `parent`.`id` AS `depl_unit_id`,
        `node`.`campaign_id` AS `campaign_id`,
        SUM(`X`.`sorties`) AS `sorties`,
        SUM(`X`.`pilot_ok`) AS `pilot_ok`,
        SUM(`X`.`pilot_wounded`) AS `pilot_wounded`,
        SUM(`X`.`pilot_pow`) AS `pilot_pow`,
        SUM(`X`.`pilot_kia`) AS `pilot_kia`,
        SUM(`X`.`asset_ok`) AS `asset_ok`,
        SUM(`X`.`asset_damaged`) AS `asset_damaged`,
        SUM(`X`.`asset_lost`) AS `asset_lost`
    FROM
        (`deployed_unit` `parent`
        JOIN ((`deployed_unit` `node`
        LEFT JOIN `mission` ON ((`mission`.`campaign_id` = `node`.`campaign_id`)))
        LEFT JOIN `mission_unit_plane_asset_status` `X` ON (((`X`.`mission_id` = `mission`.`id`)
            AND (`X`.`depl_unit_id` = `node`.`id`)))))
    WHERE
        ((`parent`.`campaign_id` = `node`.`campaign_id`)
            AND (`node`.`lft` BETWEEN `parent`.`lft` AND `parent`.`rgt`))
    GROUP BY `parent`.`id` , `node`.`campaign_id`