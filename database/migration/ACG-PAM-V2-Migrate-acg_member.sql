
INSERT INTO `acg_member`
(`id`,
`username`,
`callsign`,
`admin`,
`map_viewer`,
`mission_builder`)
SELECT `acgmembers`.`id`,
    `acgmembers`.`username`,
    `acgmembers`.`callsign`,
    `acgmembers`.`admin`,
    `acgmembers`.`mapViewer`,
    `acgmembers`.`missionBuilder`
FROM `acgmembers`;