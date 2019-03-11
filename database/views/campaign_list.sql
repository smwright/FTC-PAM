CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `campaign_list` AS
    SELECT 
        `pam`.`campaign`.`id` AS `id`,
        `pam`.`campaign`.`name` AS `name`,
        `pam`.`campaign`.`primary` AS `primary`,
        `pam`.`campaign`.`platform` AS `platform`,
        `pam`.`campaign`.`campaign_status` AS `campaign_status`,
        `pam`.`campaign`.`time` AS `time`,
        `pam`.`campaign`.`open` AS `open`,
        `pam`.`campaign`.`campaign_link` AS `campaign_link`,
        `pam`.`campaign`.`description` AS `description`,
        `pam`.`campaign`.`image` AS `image`,
        `unit_table`.`units` AS `units`,
        `sortie_table`.`sorties` AS `sorties`,
        `participant_table`.`participants` AS `participants`,
        `mission_table`.`missions` AS `missions`,
        ROUND((`sortie_table`.`sorties` / `mission_table`.`missions`),
                0) AS `avg_attendance`
    FROM
        ((((`pam`.`campaign`
        LEFT JOIN (SELECT 
            `pam`.`deployed_unit`.`campaign_id` AS `campaign_id`,
                COUNT(`pam`.`deployed_unit`.`acg_unit_id`) AS `units`
        FROM
            `pam`.`deployed_unit`
        WHERE
            (`pam`.`deployed_unit`.`acg_unit_id` IS NOT NULL)
        GROUP BY `pam`.`deployed_unit`.`campaign_id`) `unit_table` ON ((`unit_table`.`campaign_id` = `pam`.`campaign`.`id`)))
        LEFT JOIN (SELECT 
            `pam`.`campaign`.`id` AS `id`,
                COUNT(`pam`.`report`.`id`) AS `sorties`
        FROM
            ((`pam`.`campaign`
        LEFT JOIN `pam`.`mission` ON ((`pam`.`mission`.`campaign_id` = `pam`.`campaign`.`id`)))
        LEFT JOIN `pam`.`report` ON ((`pam`.`report`.`mission_id` = `pam`.`mission`.`id`)))
        WHERE
            (`pam`.`report`.`accepted` = 1)
        GROUP BY `pam`.`campaign`.`id`) `sortie_table` ON ((`sortie_table`.`id` = `pam`.`campaign`.`id`)))
        LEFT JOIN (SELECT 
            `pam`.`campaign`.`id` AS `id`,
                COUNT(DISTINCT `pam`.`career_character`.`personified_by`) AS `participants`
        FROM
            (((`pam`.`campaign`
        LEFT JOIN `pam`.`mission` ON ((`pam`.`mission`.`campaign_id` = `pam`.`campaign`.`id`)))
        LEFT JOIN `pam`.`report` ON ((`pam`.`report`.`mission_id` = `pam`.`mission`.`id`)))
        LEFT JOIN `pam`.`career_character` ON ((`pam`.`career_character`.`id` = `pam`.`report`.`character_id`)))
        WHERE
            (`pam`.`report`.`accepted` = 1)
        GROUP BY `pam`.`campaign`.`id`) `participant_table` ON ((`participant_table`.`id` = `pam`.`campaign`.`id`)))
        LEFT JOIN (SELECT 
            `pam`.`campaign`.`id` AS `id`,
                COUNT(`pam`.`mission`.`id`) AS `missions`
        FROM
            (`pam`.`campaign`
        LEFT JOIN `pam`.`mission` ON ((`pam`.`mission`.`campaign_id` = `pam`.`campaign`.`id`)))
        GROUP BY `pam`.`campaign`.`id`) `mission_table` ON ((`mission_table`.`id` = `pam`.`campaign`.`id`)))