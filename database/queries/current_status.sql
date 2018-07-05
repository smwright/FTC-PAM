SELECT 
    member_status_log.member_id,
    member_status_log.member_status,
    member_status_log.date
FROM
    member_status_log
        JOIN
    (SELECT 
        member_status_log.member_id,
            MAX(UNIX_TIMESTAMP(member_status_log.date)) AS sdate
    FROM
        member_status_log
    GROUP BY member_id) AS current_sts_tmp ON (current_sts_tmp.member_id , current_sts_tmp.sdate) = (member_status_log.member_id , UNIX_TIMESTAMP(member_status_log.date))