CREATE 
    ALGORITHM = UNDEFINED 
    SQL SECURITY DEFINER
VIEW `campaign_list` AS
    SELECT 
        `campaign`.`id` AS `id`,
        `campaign`.`name` AS `name`,
        `campaign`.`is_primary` AS `is_primary`,
        `campaign`.`platform` AS `platform`,
        `campaign`.`campaign_status` AS `campaign_status`,
        `campaign`.`time` AS `time`,
        `campaign`.`open` AS `open`,
        `campaign`.`campaign_link` AS `campaign_link`,
        `campaign`.`description` AS `description`,
        `campaign`.`image` AS `image`,
        `campaign_unit_stats`.`units` AS `units`,
        `campaign_sorties`.`sorties` AS `sorties`,
        `campaign_participants`.`participants` AS `participants`,
        `campaign_missions`.`missions` AS `missions`,
        ROUND((`campaign_sorties`.`sorties` / `campaign_missions`.`missions`),
                0) AS `avg_attendance`
    FROM
        ((((`campaign`
        LEFT JOIN campaign_unit_stats ON ((campaign_unit_stats.`campaign_id` = `campaign`.`id`)))
        LEFT JOIN campaign_sorties ON ((campaign_sorties.`id` = `campaign`.`id`)))
        LEFT JOIN campaign_participants ON ((campaign_participants.`id` = `campaign`.`id`)))
        LEFT JOIN campaign_missions ON ((`campaign_missions`.`id` = `campaign`.`id`)))