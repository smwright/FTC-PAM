CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `BoX_Latest_Walk_Update` AS
    SELECT 
        `b_wh`.`MissionStartTime` AS `MissionStartTime`,
        `b_wh`.`Name` AS `Name`,
        `b_wh`.`FlightNumber` AS `FlightNumber`,
        MAX(`b_wh`.`Time`) AS `Time`
    FROM
        (`BoX_WalkHome` `b_wh`
        LEFT JOIN `BoX_Mission_Times` `b_mt` ON ((`b_mt`.`mission_start_time` = `b_wh`.`MissionStartTime`)))
    WHERE
        (`b_wh`.`Time` <= `b_mt`.`current_game_time`)
    GROUP BY `b_wh`.`MissionStartTime` , `b_wh`.`Name` , `b_wh`.`FlightNumber`