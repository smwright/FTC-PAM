CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `BoX_User_Lookup` AS
    SELECT DISTINCT
        `A`.`boxname` AS `boxname`,
        `BoX_Users`.`username` AS `username`
    FROM
        ((`BoX_UserLogins` `A`
        LEFT JOIN `BoX_UserLogins` `B` ON ((`A`.`boxlogin` = `B`.`boxlogin`)))
        LEFT JOIN `BoX_Users` ON ((`B`.`boxname` = `BoX_Users`.`boxname`)))
    WHERE
        (`BoX_Users`.`boxname` IS NOT NULL)