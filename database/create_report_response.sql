CREATE TABLE `pam`.`report_response` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `report_id` INT NOT NULL,
  `member_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`));
