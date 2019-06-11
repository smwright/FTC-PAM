CREATE DEFINER=`cl45-acg-pam`@`%` PROCEDURE `PAM_update_transfers_date_out`()
    NO SQL
BEGIN

DECLARE memberID_bfr INTEGER;
DECLARE transferDate_bfr DATE;
DECLARE finished INTEGER DEFAULT 0;

DECLARE update_cursor CURSOR FOR
	
	SELECT memberID, transferDate FROM transfers;

DECLARE CONTINUE HANDLER
FOR NOT FOUND SET finished = 1;

OPEN update_cursor;

update_transfers: LOOP

	FETCH update_cursor INTO memberID_bfr, transferDate_bfr;
		

	IF finished = 1 THEN
		LEAVE update_transfers;
	END IF;
	
	
	UPDATE 
	transfers AS dest, 
	(SELECT transfers.transferDate FROM transfers
	WHERE memberID = memberID_bfr AND transferDate > transferDate_bfr
	ORDER BY transferDate ASC LIMIT 1) AS src
	SET dest.transferDateOut = src.transferDate
	WHERE dest.memberID = memberID_bfr and dest.transferDate = transferDate_bfr;

END LOOP update_transfers;

CLOSE update_cursor;

END