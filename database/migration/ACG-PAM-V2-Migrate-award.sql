UPDATE `awards` SET `faction` = 1 WHERE `faction` = 'LW';
UPDATE `awards` SET `faction` = 2 WHERE `faction` = 'RAF';
UPDATE `awards` SET `faction` = 3 WHERE `faction` = 'VVS';

INSERT INTO `award`(`id`,`name`,`abreviation`,`image`,`faction`)
SELECT `awards`.`id`, `awards`.`name`, `awards`.`abreviation`, `awards`.`image`, `awards`.`faction` FROM `awards`;

DROP TABLE `awards`;