SELECT 
    promotion.member_id,
    promotion.rank_value,
    promotion.date
FROM
    promotion
        JOIN
    (SELECT 
        promotion.member_id,
            MAX(UNIX_TIMESTAMP(promotion.date)) AS sdate
    FROM
        promotion
    GROUP BY member_id) AS current_rnk_tmp ON (current_rnk_tmp.member_id , current_rnk_tmp.sdate) = (promotion.member_id , UNIX_TIMESTAMP(promotion.date))