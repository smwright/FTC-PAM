UPDATE `squadrons`
SET
`faction` = 1
WHERE `faction` = "LW";

UPDATE `squadrons`
SET
`faction` = 2
WHERE `faction` = "RAF";

UPDATE `squadrons`
SET
`faction` = 3
WHERE `faction` = "VVS";

INSERT INTO `hist_unit`
(`id`,
`name`,
`code`,
`faction`,
`type`)
SELECT `squadrons`.`id`,
    `squadrons`.`name`,
    `squadrons`.`code`,
    `squadrons`.`faction`,
    1
FROM `squadrons` WHERE squadrons.id < 18;

INSERT INTO `hist_unit`
(`id`,
`name`,
`code`,
`faction`,
`type`)
SELECT `squadrons`.`id` + 7,
    `squadrons`.`name`,
    `squadrons`.`code`,
    `squadrons`.`faction`,
    1
FROM `squadrons` WHERE squadrons.id >= 18;


INSERT INTO `hist_unit`(`id`, `name`, `faction`,  `type`)
VALUES (18, "Kenley Wing", 2, 1);
INSERT INTO `hist_unit`(`id`, `name`, `faction`,  `type`)
VALUES (19, "Biggin Hill Wing", 2, 1);
INSERT INTO `hist_unit`(`id`, `name`, `faction`,  `type`)
VALUES (20, "No.11 Group", 2, 1);

INSERT INTO `hist_unit`(`id`, `name`, `faction`,  `type`)
VALUES (21, "I./JG26", 1, 1);
INSERT INTO `hist_unit`(`id`, `name`, `faction`,  `type`)
VALUES (22, "II./JG26", 1, 1);
INSERT INTO `hist_unit`(`id`, `name`, `faction`,  `type`)
VALUES (23, "III./JG26", 1, 1);
INSERT INTO `hist_unit`(`id`, `name`, `faction`,  `type`)
VALUES (24, "JG26", 1, 1);

INSERT INTO `hist_unit`(`id`, `name`, `faction`,  `type`)
VALUES (1, "Campaign Units", 0, 0);

-- ALTER TABLE tmp AUTO_INCREMENT = 41;
