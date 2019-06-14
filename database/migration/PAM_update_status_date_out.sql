CREATE DEFINER=`cl45-acg-pam`@`%` PROCEDURE `PAM_update_status_date_out`()
    NO SQL
BEGIN

DECLARE memberID_bfr INTEGER;
DECLARE statusDate_bfr DATE;
DECLARE finished INTEGER DEFAULT 0;

DECLARE update_cursor CURSOR FOR
	
	SELECT member_id, status_date_in FROM member_status_log;

DECLARE CONTINUE HANDLER
FOR NOT FOUND SET finished = 1;

OPEN update_cursor;

update_status: LOOP

	FETCH update_cursor INTO memberID_bfr, statusDate_bfr;
		

	IF finished = 1 THEN
		LEAVE update_status;
	END IF;
	
	
	UPDATE 
	member_status_log AS dest, 
	(SELECT member_status_log.status_date_in FROM member_status_log
	WHERE member_id = memberID_bfr AND status_date_in > statusDate_bfr
	ORDER BY status_date_in ASC LIMIT 1) AS src
	SET dest.status_date_out = src.status_date_in
	WHERE dest.member_id = memberID_bfr and dest.status_date_in = statusDate_bfr;

END LOOP update_status;

CLOSE update_cursor;

END