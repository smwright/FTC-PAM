CREATE DEFINER=`cl45-acg-pam`@`%` PROCEDURE `PAM_update_transfer_date_out`()
    NO SQL
BEGIN

DECLARE memberID_bfr INTEGER;
DECLARE transferDate_bfr DATE;
DECLARE finished INTEGER DEFAULT 0;

DECLARE update_cursor CURSOR FOR
	
	SELECT member_id, transfer_date_in FROM transfer;

DECLARE CONTINUE HANDLER
FOR NOT FOUND SET finished = 1;

OPEN update_cursor;

update_transfers: LOOP

	FETCH update_cursor INTO memberID_bfr, transferDate_bfr;
		

	IF finished = 1 THEN
		LEAVE update_transfers;
	END IF;
	
	
	UPDATE 
	transfer AS dest, 
	(SELECT transfer.transfer_date_in FROM transfer
	WHERE member_id = memberID_bfr AND transfer_date_in > transferDate_bfr
	ORDER BY transfer_date_in ASC LIMIT 1) AS src
	SET dest.transfer_date_out = src.transfer_date_in
	WHERE dest.member_id = memberID_bfr and dest.transfer_date_in = transferDate_bfr;

END LOOP update_transfers;

CLOSE update_cursor;

END