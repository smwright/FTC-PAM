CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `report_response_info` AS
    SELECT 
        `report_response`.`id` AS `id`,
        `report_response`.`report_id` AS `report_id`,
        `report_response`.`member_id` AS `member_id`,
        `report_info`.`member_id` AS `author_id`,
        `acg_member`.`callsign` AS `response_callsign`,
        `report_info`.`mission_id` AS `mission_id`,
        `report_info`.`campaign_id` AS `campaign_id`,
        `report_info`.`campaign_name` AS `campaign_name`,
        `report_info`.`depl_unit_id` AS `depl_unit_id`,
        `report_info`.`abreviation` AS `abreviation`,
        `report_info`.`first_name` AS `first_name`,
        `report_info`.`last_name` AS `last_name`,
        `report_info`.`callsign` AS `callsign`,
        `report_info`.`hist_unit_name` AS `hist_unit_name`,
        `report_info`.`mission_name` AS `mission_name`,
        `report_info`.`mission_real_date` AS `mission_real_date`,
        `report_info`.`hist_unit_image` AS `hist_unit_image`
    FROM
        ((`report_response`
        LEFT JOIN `report_info` ON ((`report_response`.`report_id` = `report_info`.`report_id`)))
        LEFT JOIN `acg_member` ON ((`report_response`.`member_id` = `acg_member`.`id`)))