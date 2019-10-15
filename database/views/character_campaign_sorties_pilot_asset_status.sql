CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `character_campaign_sorties_pilot_asset_status` AS
    SELECT 
        `career_character`.`id` AS `character_id`,
        `mission`.`campaign_id` AS `campaign_id`,
        `career_character`.`personified_by` AS `member_id`,
        COUNT(`report`.`id`) AS `sorties`,
        SUM((`report`.`pilot_status` = 0)) AS `pilot_ok`,
        SUM((`report`.`pilot_status` = 1)) AS `pilot_wounded`,
        SUM((`report`.`pilot_status` = 2)) AS `pilot_pow`,
        SUM((`report`.`pilot_status` = 3)) AS `pilot_kia`,
        SUM((`report`.`asset_status` = 0)) AS `asset_ok`,
        SUM((`report`.`asset_status` = 1)) AS `asset_damaged`,
        SUM((`report`.`asset_status` = 2)) AS `asset_lost`
    FROM
        ((`report`
        LEFT JOIN `career_character` ON ((`report`.`character_id` = `career_character`.`id`)))
        LEFT JOIN `mission` ON ((`report`.`mission_id` = `mission`.`id`)))
    WHERE
        (`report`.`accepted` = 1)
    GROUP BY `report`.`character_id` , `career_character`.`personified_by` , `mission`.`campaign_id`