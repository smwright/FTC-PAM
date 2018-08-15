SELECT 
    COUNT(report.id) campaigns, career_character.personified_by
FROM
    report
        LEFT JOIN
    career_character ON report.character_id = career_character.id
WHERE
    report.accepted = 1
GROUP BY career_character.personified_by