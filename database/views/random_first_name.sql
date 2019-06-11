CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `random_first_name` AS
    SELECT 
        `namepool`.`name` AS `name`,
        `namepool`.`faction` AS `faction`
    FROM
        `namepool`
    WHERE
        (`namepool`.`type` = 'FirstName')
    ORDER BY RAND()