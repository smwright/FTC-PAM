CREATE DEFINER=`cl45-acg-pam`@`%` PROCEDURE `PAM_update_status_date_out`()
    NO SQL
BEGIN

DECLARE memberID_bfr INTEGER;
DECLARE statusDate_bfr DATE;
DECLARE finished INTEGER DEFAULT 0;

DECLARE update_cursor CURSOR FOR
	
	SELECT memberID, date FROM memberstatuslog;

DECLARE CONTINUE HANDLER
FOR NOT FOUND SET finished = 1;

OPEN update_cursor;

update_status: LOOP

	FETCH update_cursor INTO memberID_bfr, statusDate_bfr;
		

	IF finished = 1 THEN
		LEAVE update_status;
	END IF;
	
	
	UPDATE 
	memberstatuslog AS dest, 
	(SELECT memberstatuslog.date FROM memberstatuslog
	WHERE memberID = memberID_bfr AND date > statusDate_bfr
	ORDER BY date ASC LIMIT 1) AS src
	SET dest.dateOut = src.date
	WHERE dest.memberID = memberID_bfr and dest.date = statusDate_bfr;

END LOOP update_status;

CLOSE update_cursor;

END