SELECT
decoration.id,
decoration.character_id,
decoration.award_id,
decoration.awarded,
decoration.date,
decoration.recommendation_date,
career_character.first_name,
career_character.last_name,
career_character.personified_by,
acg_member.callsign,
award.name
-- transfer.member_id,
-- transfer.acg_unit_id
--  transfer.transfer_date_in,
--  transfer.transfer_date_out
FROM decoration
LEFT JOIN career_character ON decoration.character_id = career_character.id
LEFT JOIN transfer ON career_character.personified_by = transfer.member_id
LEFT JOIN acg_member ON acg_member.id = career_character.personified_by
LEFT JOIN award ON award.id = decoration.award_id
WHERE (transfer.transfer_date_in <= decoration.recommendation_date)
AND (decoration.recommendation_date < transfer.transfer_date_out OR transfer.transfer_date_out IS NULL)