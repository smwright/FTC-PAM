SELECT 
    report.id AS report_id,
    report.deployed_unit_id,
    deployed_unit.acg_unit_id,
    hist_unit.name AS hist_unit_name,
    hist_unit.faction,
    deployed_unit.report_type,
    report.date_submitted,
    rank.abreviation,
    rank.value,
    career_character.first_name,
    career_character.last_name,
    acg_member.callsign,
    adjutant.accepted,
    adjutant.callsign AS adjutant
FROM
    report
        LEFT JOIN
    career_character ON report.character_id = career_character.id
        LEFT JOIN
    acg_member ON career_character.personified_by = acg_member.id
        LEFT JOIN
    deployed_unit ON report.deployed_unit_id = deployed_unit.id
        LEFT JOIN
    hist_unit ON hist_unit.id = deployed_unit.hist_unit_id
        LEFT JOIN
    (SELECT 
        promotion.member_id, promotion.rank_value
    FROM
        promotion
    JOIN (SELECT 
        promotion.member_id,
            promotion.date,
            MAX(UNIX_TIMESTAMP(promotion.date)) AS pdate
    FROM
        promotion
    WHERE
        date <= '2016-08-07'
    GROUP BY member_id, promotion.date) AS current_rank ON (current_rank.member_id , current_rank.pdate) = (promotion.member_id , UNIX_TIMESTAMP(promotion.date))) AS current_rank_2 ON current_rank_2.member_id = acg_member.id
        LEFT JOIN
    rank ON (current_rank_2.rank_value , hist_unit.faction) = (rank.value , rank.faction)
        LEFT JOIN
    (SELECT 
        report.id, report.accepted, acg_member.callsign
    FROM
        report
    LEFT JOIN acg_member ON acg_member.id = report.accepted_by) AS adjutant ON adjutant.id = report.id
WHERE
    report.mission_id = 96
        AND deployed_unit.acg_unit_id = 2
ORDER BY rank.value DESC