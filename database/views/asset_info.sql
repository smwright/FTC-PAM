CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `asset_info` AS
    SELECT 
        `asset`.`lft` AS `lft`,
        `asset`.`rgt` AS `rgt`,
        `asset`.`name` AS `name`,
        `asset`.`id` AS `id`,
        `asset`.`faction` AS `faction`,
        `asset`.`controlable` AS `controlable`
    FROM
        `asset`
    ORDER BY `asset`.`lft`