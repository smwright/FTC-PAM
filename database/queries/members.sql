SELECT 
    acg_member.id,
    acg_member.callsign,
    acg_member.admin,
    acg_member.map_viewer,
    acg_member.mission_builder,
    current_sts.member_status,
    current_rank.rank_value
FROM
    pam.acg_member
        LEFT JOIN
    (SELECT 
        member_status_log.member_id, member_status_log.member_status
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
