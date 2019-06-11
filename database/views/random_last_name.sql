CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `random_last_name` AS
    SELECT 
        `namepool`.`name` AS `name`,
        `namepool`.`faction` AS `faction`
    FROM
        `namepool`
    WHERE
        (`namepool`.`type` = 'LastName')
    ORDER BY RAND()