INSERT INTO `acg_unit`
(`id`,
`permanent`)
SELECT `squadrons`.`id`, 1
FROM `pam`.`squadrons`;