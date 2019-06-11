CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `asset_subtree` AS
    SELECT 
        `node`.`id` AS `id`,
        `node`.`name` AS `name`,
        `node`.`faction` AS `faction`,
        `node`.`controlable` AS `controlable`,
        `parent`.`name` AS `parent_name`
    FROM
        (`asset` `node`
        LEFT JOIN `asset` `parent` ON (((`node`.`lft` > `parent`.`lft`)
            AND (`node`.`rgt` < `parent`.`rgt`))))
    ORDER BY `node`.`lft`