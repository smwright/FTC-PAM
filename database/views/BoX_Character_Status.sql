CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `BoX_Character_Status` AS
    SELECT 
        `pam_m`.`id` AS `mission_id`,
        CAST(STR_TO_DATE(`box_m`.`MissionStartTime`, '%Y%m%d')
            AS DATE) AS `b_realDate`,
        `box_f`.`Name` AS `servername`,
        `acg_member`.`callsign` AS `username`,
        `acg_member`.`id` AS `member_id`,
        `mission_member_faction`.`depl_unit_id` AS `depl_unit_id`,
        `mission_member_faction`.`lft` AS `lft`,
        `mission_member_faction`.`rgt` AS `rgt`,
        `mission_member_faction`.`acg_unit_id` AS `acg_unit_id`,
        `box_f`.`MissionStartTime` AS `MissionStartTime`,
        `box_f`.`FlightNumber` AS `FlightNumber`,
        `box_f`.`SurvivalStatus` AS `SurvivalStatus`,
        IFNULL(`box_o`.`Outcome`,
                `box_f`.`SurvivalStatus`) AS `ch_status`,
        `box_o`.`PathPts` AS `path_points`,
        `box_o`.`LastPoint` AS `last_point`,
        `box_o`.`Status` AS `o_ch_status`,
        `box_o`.`Outcome` AS `o_outcome`
    FROM
        ((((((`mission` `pam_m`
        LEFT JOIN `BoX_Missions` `box_m` ON ((`pam_m`.`real_date` = CAST(STR_TO_DATE(`box_m`.`MissionStartTime`, '%Y%m%d')
            AS DATE))))
        LEFT JOIN `BoX_Flights` `box_f` ON ((`box_m`.`MissionStartTime` = `box_f`.`MissionStartTime`)))
        LEFT JOIN `BoX_User_Lookup` `box_u` ON ((`box_u`.`boxname` = `box_f`.`Name`)))
        LEFT JOIN `acg_member` ON ((`acg_member`.`callsign` = `box_u`.`username`)))
        LEFT JOIN `mission_member_faction` ON (((`acg_member`.`id` = `mission_member_faction`.`member_id`)
            AND (`pam_m`.`id` = `mission_member_faction`.`mission_id`))))
        LEFT JOIN `BoX_Outcome` `box_o` ON (((`box_o`.`MissionStartTime` = `box_f`.`MissionStartTime`)
            AND (`box_o`.`FlightNumber` = `box_f`.`FlightNumber`)
            AND (`box_o`.`Name` = `box_f`.`Name`))))
    WHERE
        ((`box_m`.`PublicCampaign` = 'C')
            AND (`box_f`.`Name` <> 'OBJECT')
            AND (`box_f`.`TakeOffTime` IS NOT NULL))
    ORDER BY `box_u`.`username` , `box_f`.`FlightNumber`