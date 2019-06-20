INSERT INTO `acg_unit`
(`id`,
`permanent`)
SELECT `squadrons`.`id`, 1
FROM `squadrons`;

UPDATE `acg_unit` SET `name` = '501' WHERE (`id` = '2');
UPDATE `acg_unit` SET `name` = '64' WHERE (`id` = '3');
UPDATE `acg_unit` SET `name` = '615' WHERE (`id` = '4');
UPDATE `acg_unit` SET `name` = '4th' WHERE (`id` = '5');
UPDATE `acg_unit` SET `name` = '5th' WHERE (`id` = '6');
UPDATE `acg_unit` SET `name` = '6th' WHERE (`id` = '7');
UPDATE `acg_unit` SET `name` = '7th' WHERE (`id` = '8');
UPDATE `acg_unit` SET `name` = 'ZG' WHERE (`id` = '9');
UPDATE `acg_unit` SET `name` = '111' WHERE (`id` = '10');
UPDATE `acg_unit` SET `name` = 'stab' WHERE (`id` = '11');
UPDATE `acg_unit` SET `name` = '610' WHERE (`id` = '12');
UPDATE `acg_unit` SET `name` = '8th' WHERE (`id` = '13');
UPDATE `acg_unit` SET `name` = '32' WHERE (`id` = '14');
UPDATE `acg_unit` SET `name` = '302' WHERE (`id` = '15');
UPDATE `acg_unit` SET `name` = '9th' WHERE (`id` = '16');
UPDATE `acg_unit` SET `name` = '1st' WHERE (`id` = '17');