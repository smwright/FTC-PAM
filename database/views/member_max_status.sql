CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `member_max_status` AS
    SELECT 
        `member_status_log`.`id` AS `id`,
        `member_status_log`.`member_id` AS `member_id`,
        `member_status_log`.`member_status` AS `member_status`,
        `member_status_log`.`status_date_in` AS `status_date_in`,
        `member_status_log`.`status_date_out` AS `status_date_out`,
        `member_status_log`.`comment` AS `comment`
    FROM
        `member_status_log`
    WHERE
        ISNULL(`member_status_log`.`status_date_out`)