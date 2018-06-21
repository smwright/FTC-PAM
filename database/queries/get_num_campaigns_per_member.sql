SELECT 
    COUNT(DISTINCT (campaign_id)) AS campaigns,
    career_character.personified_by
FROM
    report
        LEFT JOIN
    career_character ON report.character_id = career_character.id
        LEFT JOIN
    mission ON mission.id = report.mission_id
WHERE
    report.accepted = 1
GROUP BY career_character.personified_by