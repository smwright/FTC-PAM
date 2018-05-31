UPDATE `squadrons`
SET
`faction` = 1
WHERE `faction` = "LW";

UPDATE `squadrons`
SET
`faction` = 2
WHERE `faction` = "RAF";

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
FROM `squadrons`;

INSERT INTO `hist_unit`(`name`, `faction`,  `type`)
VALUES ("Kenley Wing", 2, 1);
INSERT INTO `hist_unit`(`name`, `faction`,  `type`)
VALUES ("Biggin Hill Wing", 2, 1);
INSERT INTO `hist_unit`(`name`, `faction`,  `type`)
VALUES ("No.11 Group", 2, 1);

INSERT INTO `hist_unit`(`name`, `faction`,  `type`)
VALUES ("I./JG26", 1, 1);
INSERT INTO `hist_unit`(`name`, `faction`,  `type`)
VALUES ("II./JG26", 1, 1);
INSERT INTO `hist_unit`(`name`, `faction`,  `type`)
VALUES ("III./JG26", 1, 1);
INSERT INTO `hist_unit`(`name`, `faction`,  `type`)
VALUES ("JG26", 1, 1);

INSERT INTO `hist_unit`(`id`, `name`, `faction`,  `type`)
VALUES (1, "Campaign Units", 0, 0);
