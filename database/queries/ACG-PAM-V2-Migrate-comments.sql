DELETE FROM comments WHERE comments.reportID NOT IN (SELECT report.id FROM report);

INSERT INTO `comment`
(`id`,
`report_id`,
`member_id`,
`comment_date`,
`comment_text`)
SELECT `comments`.`id`,
    `comments`.`reportID`,
    `comments`.`commentAuthorID`,
    `comments`.`commentDate`,
    `comments`.`commentText`
FROM `comments`;

DROP TABLE comments;

