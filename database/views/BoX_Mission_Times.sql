CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `BoX_Mission_Times` AS
    SELECT 
        `pam_m`.`id` AS `id`,
        STR_TO_DATE(`box_m`.`MissionStartTime`,
                '%Y%m%d%H%i%s') AS `mission_start_time`,
        STR_TO_DATE(CONCAT(`box_m`.`GameDate`,
                        ' ',
                        `box_m`.`GameTime`),
                '%Y.%c.%e %k:%i:%s') AS `game_start_time`,
        ADDTIME(STR_TO_DATE(CONCAT(`box_m`.`GameDate`,
                                ' ',
                                `box_m`.`GameTime`),
                        '%Y.%c.%e %k:%i:%s'),
                TIMEDIFF(NOW(),
                        STR_TO_DATE(`box_m`.`MissionStartTime`,
                                '%Y%m%d%H%i%s'))) AS `current_game_time`
    FROM
        (`mission` `pam_m`
        LEFT JOIN `BoX_Missions` `box_m` ON ((`pam_m`.`real_date` = CAST(STR_TO_DATE(`box_m`.`MissionStartTime`, '%Y%m%d')
            AS DATE))))
    WHERE
        (`box_m`.`PublicCampaign` = 'C')