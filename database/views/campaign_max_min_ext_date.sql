CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `campaign_max_min_ext_date` AS
    SELECT 
        `c_mx`.`id` AS `id`,
        IF(ISNULL(MAX(`c_mn`.`mx_date`)),
            `c_mx`.`mn_date`,
            MAX(`c_mn`.`mx_date`)) AS `mn_date_ext`,
        `c_mx`.`mn_date` AS `mn_date`,
        `c_mx`.`mx_date` AS `mx_date`
    FROM
        (`campaign_max_min_date` `c_mx`
        LEFT JOIN `campaign_max_min_date` `c_mn` ON (((`c_mn`.`id` <> `c_mx`.`id`)
            AND (`c_mn`.`mx_date` < `c_mx`.`mn_date`))))
    GROUP BY `c_mx`.`id` , `c_mx`.`mx_date` , `c_mx`.`mn_date`