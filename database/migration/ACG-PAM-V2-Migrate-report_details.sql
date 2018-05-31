DELETE FROM reportdetailslw WHERE reportdetailslw.reportID NOT IN (SELECT report.id FROM report);

INSERT INTO `report_detail_lw`
(`id`,
`report_id`,
`swarm`,
`swarm_pos`)
SELECT `reportdetailslw`.`id`,
    `reportdetailslw`.`reportID`,
    `reportdetailslw`.`swarm`,
    `reportdetailslw`.`swarmPos`
FROM `reportdetailslw`;


DELETE FROM reportdetailsraf WHERE reportdetailsraf.reportID NOT IN (SELECT report.id FROM report);

INSERT INTO `report_detail_raf`
(`id`,
`report_id`,
`flight`,
`section`,
`section_pos`,
`serial_no`)
SELECT `reportdetailsraf`.`id`,
    `reportdetailsraf`.`reportID`,
    `reportdetailsraf`.`flight`,
    `reportdetailsraf`.`section`,
    `reportdetailsraf`.`sectionPos`,
    `reportdetailsraf`.`serialNo`
FROM `reportdetailsraf`;

UPDATE `report_detail_lw` SET `swarm` = `swarm` - 1;
UPDATE `report_detail_lw` SET `swarm_pos` = `swarm_pos` - 1;

UPDATE `report_detail_raf` SET `section` = `section` - 1;
UPDATE `report_detail_raf` SET `section_pos` = `section_pos` - 1;
UPDATE `report_detail_raf` SET `flight` = `flight` - 1;

DROP TABLE reportdetailslw;
DROP TABLE reportdetailsraf;
DROP TABLE sectionpos;
DROP TABLE sectionraf;
DROP TABLE swarmpos;
DROP TABLE swarmslw;
DROP TABLE flightsraf;