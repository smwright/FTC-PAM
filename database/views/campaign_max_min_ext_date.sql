CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `campaign_max_min_ext_date` AS
    SELECT 
        `c`.`id` AS `id`,
        `c`.`mn_date` AS `mn_date`,
        `c`.`mx_date` AS `mx_date`,
        IF(ISNULL(MAX(`c_mn`.`mx_date`)),
            `c`.`mn_date`,
            MAX(`c_mn`.`mx_date`)) AS `mn_date_ext`,
        IF(ISNULL(MIN(`c_mx`.`mn_date`)),
            CURDATE(),
            MIN(`c_mx`.`mn_date`)) AS `mx_date_ext`
    FROM
        ((`campaign_max_min_date` `c`
        LEFT JOIN `campaign_max_min_date` `c_mx` ON (((`c`.`id` <> `c_mx`.`id`)
            AND (`c`.`mx_date` < `c_mx`.`mn_date`))))
        LEFT JOIN `campaign_max_min_date` `c_mn` ON (((`c`.`id` <> `c_mn`.`id`)
            AND (`c_mn`.`mx_date` < `c`.`mn_date`))))
    GROUP BY `c`.`id` , `c`.`mn_date` , `c`.`mx_date`