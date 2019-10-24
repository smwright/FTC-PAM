CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `pam`.`character_mission_frontdays` AS
    SELECT 
        `a`.`character_id` AS `character_id`,
        `a_m`.`id` AS `mission_id`,
        MAX((TO_DAYS(`a_m`.`hist_date`) - TO_DAYS(`b_m`.`hist_date`))) AS `frontdays`
    FROM
        (((`pam`.`report` `a`
        JOIN `pam`.`report` `b` ON (((`a`.`character_id` = `b`.`character_id`)
            AND (`a`.`id` > `b`.`id`))))
        LEFT JOIN `pam`.`mission` `a_m` ON ((`a_m`.`id` = `a`.`mission_id`)))
        LEFT JOIN `pam`.`mission` `b_m` ON ((`b_m`.`id` = `b`.`mission_id`)))
    WHERE
        ((`a`.`accepted` = 1)
            AND (`b`.`accepted` = 1)
            AND (`a_m`.`hist_date` >= '1941-10-15')
            AND (`a_m`.`hist_date` <= '1942-04-15')
            AND (`b_m`.`hist_date` >= '1941-10-15')
            AND (`b_m`.`hist_date` <= '1942-04-15'))
    GROUP BY `a`.`character_id` , `a_m`.`id`