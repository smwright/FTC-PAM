SELECT 
    acg_member.id,
    acg_member.callsign,
    acg_member.admin,
    acg_member.map_viewer,
    acg_member.mission_builder,
    first_sts.jdate,
    current_sts.cstatus,
    'X years, Y month, Z days' AS length_of_service,
    current_rank.rank_value,
    sortie_table.sorties,
    campaign_table.campaigns
FROM
    pam.acg_member
        LEFT JOIN
    (SELECT 
        member_status_log.member_id, member_status_log.date AS jdate
    FROM
        member_status_log
    JOIN (SELECT 
        member_status_log.member_id,
            MIN(UNIX_TIMESTAMP(member_status_log.date)) AS jdate
    FROM
        member_status_log
    GROUP BY member_id) AS first_sts_tmp ON (first_sts_tmp.member_id , first_sts_tmp.jdate) = (member_status_log.member_id , UNIX_TIMESTAMP(member_status_log.date))) AS first_sts ON first_sts.member_id = acg_member.id
        LEFT JOIN
    (SELECT 
        member_status_log.member_id,
            member_status_log.member_status AS cstatus
    FROM
        member_status_log
    JOIN (SELECT 
        member_status_log.member_id,
            MAX(UNIX_TIMESTAMP(member_status_log.date)) AS sdate
    FROM
        member_status_log
    GROUP BY member_id) AS current_sts_tmp ON (current_sts_tmp.member_id , current_sts_tmp.sdate) = (member_status_log.member_id , UNIX_TIMESTAMP(member_status_log.date))) AS current_sts ON current_sts.member_id = acg_member.id
        LEFT JOIN
    (SELECT 
        promotion.member_id, promotion.rank_value
    FROM
        promotion
    JOIN (SELECT 
        promotion.member_id,
            MAX(UNIX_TIMESTAMP(promotion.date)) AS sdate
    FROM
        promotion
    GROUP BY member_id) AS current_rnk_tmp ON (current_rnk_tmp.member_id , current_rnk_tmp.sdate) = (promotion.member_id , UNIX_TIMESTAMP(promotion.date))) AS current_rank ON current_rank.member_id = acg_member.id
        RIGHT JOIN
    (SELECT 
        COUNT(report.id) sorties, career_character.personified_by
    FROM
        report
    LEFT JOIN career_character ON report.character_id = career_character.id
    WHERE
        report.accepted = 1
    GROUP BY career_character.personified_by) AS sortie_table ON sortie_table.personified_by = acg_member.id
        RIGHT JOIN
    (SELECT 
        COUNT(DISTINCT (campaign_id)) AS campaigns,
            career_character.personified_by
    FROM
        report
    LEFT JOIN career_character ON report.character_id = career_character.id
    LEFT JOIN mission ON mission.id = report.mission_id
    WHERE
        report.accepted = 1
    GROUP BY career_character.personified_by) AS campaign_table ON campaign_table.personified_by = acg_member.id