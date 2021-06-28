UPDATE 
member_roster_asset AS mra,
(SELECT
ra.id,
du.campaign_id,
du.acg_unit_id
FROM roster_asset ra
LEFT JOIN deployed_unit du ON du.hist_unit_id = ra.hist_unit_id) AS src
SET
mra.acg_unit_id = src.acg_unit_id
WHERE mra.roster_asset_id = src.id AND mra.campaign_id = src.campaign_id;


SELECT
ra.id,
du.campaign_id,
du.acg_unit_id
FROM roster_asset ra
LEFT JOIN deployed_unit du ON du.hist_unit_id = ra.hist_unit_id