CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `campaign_unit_member_max_promotion_date` AS
    SELECT 
        `c`.`campaign_id` AS `campaign_id`,
        `c`.`acg_unit_id` AS `acg_unit_id`,
        `c`.`member_id` AS `member_id`,
        MAX(`p`.`promotion_date`) AS `mx_date`
    FROM
        (`campaign_unit_member_max_min_date` `c`
        JOIN `promotion` `p` ON (((`c`.`member_id` = `p`.`member_id`)
            AND (`p`.`promotion_date` < LEAST(`c`.`c_mx_date`, `c`.`mx_date`)))))
    GROUP BY `c`.`campaign_id` , `c`.`acg_unit_id` , `c`.`member_id`