CREATE TABLE `pam`.`report_detail_ra` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `report_id` INT(11) NOT NULL,
  `sezione` INT(11) NOT NULL,
  `sezione_pos` INT(11) NOT NULL,
  PRIMARY KEY (`id`, `report_id`));