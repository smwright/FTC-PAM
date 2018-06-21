SELECT 
    COUNT(acg_member.id) AS sorties,
    acg_member.id AS m_id,
#    acg_member.callsign,
    campaign.id AS c_id,
    campaign.name
FROM
    acg_member
        LEFT JOIN
    career_character ON career_character.personified_by = acg_member.id
        LEFT JOIN
    report ON report.character_id = career_character.id
        LEFT JOIN
    mission ON mission.id = report.mission_id
        LEFT JOIN
    campaign ON campaign.id = mission.campaign_id
WHERE
    mission.id IS NOT NULL AND acg_member.id = 1
GROUP BY acg_member.id , campaign.id