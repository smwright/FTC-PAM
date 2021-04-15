CREATE TABLE `pam`.`claim_ra` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `claim_id` INT(11) NOT NULL,
  `enemy_status` INT(11) NOT NULL,
  `shared` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`, `claim_id`));