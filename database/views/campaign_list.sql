CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `campaign_list` AS
    SELECT 
        `pam`.`campaign`.`id` AS `id`,
        `pam`.`campaign`.`name` AS `name`,
        `pam`.`campaign`.`is_primary` AS `is_primary`,
        `pam`.`campaign`.`platform` AS `platform`,
        `pam`.`campaign`.`campaign_status` AS `campaign_status`,
        `pam`.`campaign`.`time` AS `time`,
        `pam`.`campaign`.`open` AS `open`,
        `pam`.`campaign`.`campaign_link` AS `campaign_link`,
        `pam`.`campaign`.`description` AS `description`,
        `pam`.`campaign`.`image` AS `image`,
        `campaign_unit_stats`.`units` AS `units`,
        `campaign_sorties`.`sorties` AS `sorties`,
        `campaign_average_participants`.`participants` AS `avg_attendance`,
        `campaign_participants`.`participants` AS `participants`,
        `campaign_missions`.`missions` AS `missions`,
        `root_units`.`id` AS `root_unit_id`
    FROM
        ((((((`pam`.`campaign`
        LEFT JOIN `pam`.`campaign_unit_stats` ON ((`campaign_unit_stats`.`campaign_id` = `pam`.`campaign`.`id`)))
        LEFT JOIN `pam`.`campaign_sorties` ON ((`campaign_sorties`.`id` = `pam`.`campaign`.`id`)))
        LEFT JOIN `pam`.`campaign_participants` ON ((`campaign_participants`.`id` = `pam`.`campaign`.`id`)))
        LEFT JOIN `pam`.`campaign_average_participants` ON ((`campaign_average_participants`.`campaign_id` = `pam`.`campaign`.`id`)))
        LEFT JOIN `pam`.`campaign_missions` ON ((`campaign_missions`.`id` = `pam`.`campaign`.`id`)))
        LEFT JOIN (SELECT 
            `pam`.`deployed_unit`.`id` AS `id`,
                `pam`.`deployed_unit`.`campaign_id` AS `campaign_id`
        FROM
            `pam`.`deployed_unit`
        WHERE
            (`pam`.`deployed_unit`.`lft` = 1)) `root_units` ON ((`root_units`.`campaign_id` = `pam`.`campaign`.`id`)))
    ORDER BY `pam`.`campaign`.`id` DESC