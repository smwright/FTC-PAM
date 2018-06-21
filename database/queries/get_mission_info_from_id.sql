SELECT 
    mission.name AS m_name,
    mission.hist_date,
    mission.real_date,
    mission.mission_status,
    campaign.name AS c_name
FROM
    mission
        LEFT JOIN
    campaign ON mission.campaign_id = campaign.id
WHERE
    mission.id = 96