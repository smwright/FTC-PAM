<?php
/**
 * Created by IntelliJ IDEA.
 * User: rafaelg
 * Date: 16/10/19
 * Time: 00:19
 */


//retrieving database connection
include_once(dirname(__FILE__).'/dbx.php');



$params = json_decode( file_get_contents( 'php://input' ), true );



$dbx = getDBx();
mysqli_set_charset($dbx, "utf8");
if(array_key_exists("character_id", $params)) {


    $characterID = filter_var($params["character_id"], FILTER_SANITIZE_STRING);
    $faction = filter_var($params["faction"], FILTER_SANITIZE_STRING);
    checkDecorations($characterID, $faction, $dbx);
}



mysqli_close($dbx);
exit();


function checkDecorations($characterID, $faction, $dbx){

    $sql = "SELECT MAX(report.mission_id) AS mxmid, MIN(report.mission_id) AS mnmid ".
        "FROM report WHERE report.character_id = $characterID";
    $result = mysqli_query($dbx, $sql);
    $row = mysqli_fetch_assoc($result);
    $mxmid = $row["mxmid"];
    $mnmid = $row["mnmid"];


    if($faction == 2){
        for($missionID = $mnmid; $missionID <= $mxmid; $missionID++){
            checkRAFDecorations($characterID, $missionID, $dbx);
        }
    } else if($faction == 1){
        for($missionID = $mnmid; $missionID <= $mxmid; $missionID++){
            checkLWDecorations($characterID, $missionID, $dbx);
        }
    } else if($faction == 3){
        for($missionID = $mnmid; $missionID <= $mxmid; $missionID++){
            checkVVSDecorations($characterID, $missionID, $dbx);
        }
    } else if($faction == 4){
        for($missionID = $mnmid; $missionID <= $mxmid; $missionID++){
            checkVVSDecorations($characterID, $missionID, $dbx);
        }
    }


}

function checkRAFDecorations($characterID, $missionID, $dbx){


    //Get date of mission
    $sql = "SELECT mission.real_date FROM mission WHERE mission.id = $missionID";
    $result = mysqli_query($dbx, $sql);
    $row = mysqli_fetch_assoc($result);
    $missionDate = $row["real_date"];


    //Get all decorations of the character
    $sql = "SELECT award.abreviation, decoration.id, decoration.awarded FROM award ".
        "LEFT JOIN decoration ON decoration.award_id = award.id ".
        "WHERE decoration.character_id = $characterID";
    $result = mysqli_query($dbx, $sql);
    $decorationsArray = array();
    $awardedArray = array();
    while($row = mysqli_fetch_array($result)){
        $decorationsArray[] = $row[0];
        $awardedArray[$row[0]]["id"] = $row[1];
        $awardedArray[$row[0]]["awarded"] = $row[2];
    }

    //Get all awards
    $sql = "SELECT id, abreviation FROM award ".
        "WHERE faction = 2";
    $result = mysqli_query($dbx, $sql);
    while($row = mysqli_fetch_array($result)){
        $awardArray["$row[1]"] = $row[0];
    }

    //Get stats for character of non-Battle of Britain missions
    $sql = "SELECT COUNT(report.id) AS sorties, SUM(report.pilot_status = 0) AS pilotOK, ".
        "SUM(report.pilot_status = 1) AS pilotWND, SUM(report.asset_status = 2) AS aeroLST ".
        "FROM report LEFT JOIN mission ON report.mission_id = mission.id ".
        "WHERE report.character_id = $characterID AND report.accepted = 1 AND mission.id <= $missionID ".
        "AND (hist_date < '1940-06-10 00:00:00' OR hist_date > '1940-10-31 23:59:59')";
    $result = mysqli_query($dbx, $sql);
    $row = mysqli_fetch_assoc($result);

    $sortiesNonBOB = $row["sorties"];
    $aeroLostNonBOB = $row["aeroLST"];
    $pilotOKNonBOB = $row["pilotOK"];
    $pilotWoundedNonBOB = $row["pilotWND"];

    //Get stats for character of Battle of Britain missions
    $sql = "SELECT COUNT(report.id) AS sorties, SUM(report.pilot_status = 0) AS pilotOK, ".
        "SUM(report.pilot_status = 1) AS pilotWND, SUM(report.asset_status = 2) AS aeroLST ".
        "FROM report LEFT JOIN mission ON report.mission_id = mission.id ".
        "WHERE report.character_id = $characterID AND report.accepted = 1 AND mission.id <= $missionID ".
        "AND (hist_date >= '1940-06-10 00:00:00' AND hist_date <= '1940-10-31 23:59:59')";
    $result = mysqli_query($dbx, $sql);
    $row = mysqli_fetch_assoc($result);


    $sortiesBOB = $row["sorties"];
    $aeroLostBOB = $row["aeroLST"];
    $pilotOKBOB = $row["pilotOK"];
    $pilotWoundedBOB = $row["pilotWND"];

    $sorties = $sortiesNonBOB + $sortiesBOB;
    $aeroLost = $aeroLostNonBOB + $aeroLostBOB;
    $pilotOK = $pilotOKNonBOB + $pilotOKBOB;
    $pilotWounded = $pilotWoundedNonBOB + $pilotWoundedBOB;

    $sql = "SELECT career_character.personified_by FROM career_character ".
        "WHERE career_character.id = $characterID";
    $querry = mysqli_query($dbx, $sql);
    $result = mysqli_fetch_assoc($querry);
    $memberID = $result["personified_by"];
    $rankValue = getRankValueAtMission($memberID, $missionID, $dbx);

    $sql = "SELECT SUM(destrtable.pointsdestr) AS destr FROM report ".
        "LEFT JOIN (SELECT claim.report_id, (1-claim_raf.shared*0.5) AS pointsdestr FROM claim
            LEFT JOIN claim_raf ON claim.id = claim_raf.claim_id WHERE enemy_status = 0 AND claim.accepted = 1) AS destrtable ON destrtable.report_id = report.id ".
        "WHERE report.accepted = 1  AND character_id = $characterID AND report.mission_id <= $missionID";

    $result = mysqli_query($dbx, $sql);
    $row = mysqli_fetch_assoc($result);
    $destroyed = $row["destr"];

    $sql = "SELECT SUM(probtable.pointsprob) AS prob FROM report ".
        "LEFT JOIN (SELECT claim.report_id, (1-claim_raf.shared*0.5) AS pointsprob FROM claim
           LEFT JOIN claim_raf ON claim.id = claim_raf.claim_id WHERE enemy_status = 1 AND claim.accepted = 1) AS probtable ON probtable.report_id = report.id ".
        "WHERE report.accepted = 1 AND character_id = $characterID AND report.mission_id <= $missionID";

    $result = mysqli_query($dbx, $sql);
    $row = mysqli_fetch_assoc($result);
    $probable = $row["prob"];

    $sql = "SELECT COUNT(dmgtable.pointsdmg) AS dmg FROM report ".
        "LEFT JOIN (SELECT claim.report_id, (1-claim_raf.shared*0.5) AS pointsdmg FROM claim
             LEFT JOIN claim_raf ON claim.id = claim_raf.claim_id WHERE enemy_status = 2 AND claim.accepted = 1) AS dmgtable ON dmgtable.report_id = report.id ".
        "WHERE report.accepted = 1 AND character_id = $characterID AND report.mission_id <= $missionID";
//    echo $sql;
    $result = mysqli_query($dbx, $sql);
    $row = mysqli_fetch_assoc($result);
    $damaged = $row["dmg"];

    $succesfulReturnsNonBOB = $pilotOKNonBOB + $pilotWoundedNonBOB;
    $succesfulReturnsBOB = $pilotOKBOB + $pilotWoundedBOB;
    $succesfulReturns = $pilotOK + $pilotWounded;
    $points = $destroyed*10 + $probable*5 + $damaged*2;
    if($sorties > 0){
        $rtbRatio = 1 - $aeroLost/$sorties;
    } else {
        $rtbRatio = 0;
    }

    //Check for RAF Pilot Brevet
    $medalAbr = "AB";
    $criteria = $succesfulReturns > 1;
    $msg = "succesfulReturns $succesfulReturns > 1";
    addRemoveDecoration($medalAbr, $criteria, $decorationsArray, $awardedArray,
        $awardArray, $characterID, $missionDate, $dbx, $msg);

    //Victory Medal
    $medalAbr = "VM";
    $criteria = $succesfulReturnsNonBOB > 3;
    $msg = "succesfulReturns not BoB $succesfulReturns > 3";
    addRemoveDecoration($medalAbr, $criteria, $decorationsArray, $awardedArray,
        $awardArray, $characterID, $missionDate, $dbx, $msg);

    //Victory Medal with Battle of Britain Clasp
    $medalAbr = "VMBOB";
    $criteria = $succesfulReturnsBOB > 3;
    $msg = "succesfulReturns BoB $succesfulReturns > 3";
    addRemoveDecoration($medalAbr, $criteria, $decorationsArray, $awardedArray,
        $awardArray, $characterID, $missionDate, $dbx, $msg);


    //Mentioned in Dispatches
    $medalAbr = "MiD";
    $criteria = $destroyed > 4;
    $msg = "dest $destroyed > 4";
    addRemoveDecoration($medalAbr, $criteria, $decorationsArray, $awardedArray,
        $awardArray, $characterID, $missionDate, $dbx, $msg);


    //Distinguished Flying Medal
    $medalAbr = "DFM";
    $criteria = ($destroyed > 7 | $points > 119) & $rankValue < 8;
    $msg = "(dest $destroyed > 7 | points $points > 119) & rank value $rankValue < 8";
    addRemoveDecoration($medalAbr, $criteria, $decorationsArray, $awardedArray,
        $awardArray, $characterID, $missionDate, $dbx, $msg);


    //Distinguished Flying Medal with Bar
    $medalAbr = "DFM*";
    $criteriaA = $destroyed > 15;
    $criteriaB = $points > 199;
    $criteria = ($criteriaA | $criteriaB) & $rankValue < 8;
    $msg = "(dest $destroyed > 15 | points $points > 199) & rank value $rankValue < 8";
    addRemoveDecoration($medalAbr, $criteria, $decorationsArray, $awardedArray,
        $awardArray, $characterID, $missionDate, $dbx, $msg);


    //Distinguished Flying Cross
    $medalAbr = "DFC";
    $criteria = ($destroyed > 7 | $points > 119) & $rankValue >= 8;
    $msg = "(dest $destroyed > 7 | points $points > 119) & rank value $rankValue >= 8";
    addRemoveDecoration($medalAbr, $criteria, $decorationsArray, $awardedArray,
        $awardArray, $characterID, $missionDate, $dbx, $msg);


    //Distinguished Flying Cross with Bar
    $medalAbr = "DFC*";
    $criteria = ($destroyed > 15 | $points > 199) & $rankValue >= 8;
    $msg = "(dest $destroyed > 15 | points $points > 199) & rank value $rankValue >= 8";
    addRemoveDecoration($medalAbr, $criteria, $decorationsArray, $awardedArray,
        $awardArray, $characterID, $missionDate, $dbx, $msg);


    //Distinguished Flying Cross with two Bars
    $medalAbr = "DFC**";
    $criteria = $points > 499 & $rankValue >= 8;
    $msg = "points $points > 499 & rank value $rankValue >= 8";
    addRemoveDecoration($medalAbr, $criteria, $decorationsArray, $awardedArray,
        $awardArray, $characterID, $missionDate, $dbx, $msg);


    //Distinguished Service Order
    $medalAbr = "DSO";
    $criteria = $succesfulReturns > 9 & $destroyed > 6 & $rtbRatio >= 0.6 & $rankValue >= 8;
    $msg = "successful returns $succesfulReturns > 9 & dest $destroyed > 6 & RTB ratio$rtbRatio >= 0.6 & rank value $rankValue >= 8";
    addRemoveDecoration($medalAbr, $criteria, $decorationsArray, $awardedArray,
        $awardArray, $characterID, $missionDate, $dbx, $msg);


    //Distinguished Service Order with Bar
    $medalAbr = "DSO*";
    $criteria = $succesfulReturns > 19 & $destroyed > 14 & $rtbRatio >= 0.85 & $rankValue >= 8;
    $msg = "successful returns $succesfulReturns > 19 & dest $destroyed > 14 & RTB ratio $rtbRatio >= 0.85 & rank value $rankValue >= 8";
    addRemoveDecoration($medalAbr, $criteria, $decorationsArray, $awardedArray,
        $awardArray, $characterID, $missionDate, $dbx, $msg);

}

function checkLWDecorations($characterID, $missionID, $dbx){

    //Get date of mission
    $sql = "SELECT mission.real_date FROM mission WHERE mission.id = $missionID";
    $result = mysqli_query($dbx, $sql);
    $row = mysqli_fetch_assoc($result);
    $missionDate = $row["real_date"];


    //Get all decorations of the character
    $sql = "SELECT award.abreviation, decoration.id, decoration.awarded FROM award ".
        "LEFT JOIN decoration ON decoration.award_id = award.id ".
        "WHERE decoration.character_id = $characterID";
    $result = mysqli_query($dbx, $sql);
    $decorationsArray = array();
    $awardedArray = array();
    while($row = mysqli_fetch_array($result)){
        $decorationsArray[] = $row[0];
        $awardedArray[$row[0]]["id"] = $row[1];
        $awardedArray[$row[0]]["awarded"] = $row[2];
    }

    //Get all award
    $sql = "SELECT id, abreviation FROM award ".
        "WHERE faction = 1";
    $result = mysqli_query($dbx, $sql);
    while($row = mysqli_fetch_array($result)){
        $awardArray["$row[1]"] = $row[0];
    }

    //Get stats for character
//    $sql = "SELECT report.character_id, COUNT(report.id) AS sorties, SUM(report.pilot_status = 0) AS pilotOK, ".
//        "SUM(report.pilot_status = 1) AS pilotWND, SUM(report.asset_status = 2) AS aeroLST ".
//        "FROM report LEFT JOIN mission ON report.mission_id = mission.id ".
//        "WHERE report.character_id = $characterID AND report.accepted = 1 AND mission.id <= $missionID";
//    $result = mysqli_query($dbx, $sql);
//    $row = mysqli_fetch_assoc($result);
//
//    $sorties = $row["sorties"];
//    $aeroLost = $row["aeroLST"];
//    $pilotOK = $row["pilotOK"];
//    $pilotWounded = $row["pilotWND"];

    $sql = "SELECT SUM(claim_lw.confirmed=1) AS conf, SUM(claim_lw.confirmed=0) AS unconf ".
        "FROM claim LEFT JOIN report ON claim.report_id = report.id ".
        "LEFT JOIN claim_lw ON claim.id = claim_lw.claim_id ".
        "WHERE character_id = $characterID AND report.accepted=1 AND claim.accepted = 1 ".
        "AND report.mission_id <= $missionID";
    $result = mysqli_query($dbx, $sql);
    $row = mysqli_fetch_assoc($result);

    $conf = $row["conf"];
    $unconf = $row["unconf"];

    //Get stats for character of Battle of Moscow missions
    $sql = "SELECT COUNT(report.id) AS sorties, SUM(report.pilot_status = 0) AS pilotOK, ".
        "SUM(report.pilot_status = 1) AS pilotWND, SUM(report.asset_status = 2) AS aeroLST ".
        "FROM report LEFT JOIN mission ON report.mission_id = mission.id ".
        "WHERE report.character_id = $characterID AND report.accepted = 1 AND mission.id <= $missionID ".
        "AND (hist_date >= '1941-10-15 00:00:00' AND hist_date <= '1942-04-15 23:59:59')";
    $result = mysqli_query($dbx, $sql);
    $row = mysqli_fetch_assoc($result);


    $sortiesBOM = $row["sorties"];
    $aeroLostBOM = $row["aeroLST"];
    $pilotOKBOM = $row["pilotOK"];
    $pilotWoundedBOM = $row["pilotWND"];

    //Get stats for character of non Battle of Moscow missions
    $sql = "SELECT COUNT(report.id) AS sorties, SUM(report.pilot_status = 0) AS pilotOK, ".
        "SUM(report.pilot_status = 1) AS pilotWND, SUM(report.asset_status = 2) AS aeroLST ".
        "FROM report LEFT JOIN mission ON report.mission_id = mission.id ".
        "WHERE report.character_id = $characterID AND report.accepted = 1 AND mission.id <= $missionID ".
        "AND (hist_date < '1941-10-15 00:00:00' OR hist_date > '1942-04-15 23:59:59')";
    $result = mysqli_query($dbx, $sql);
    $row = mysqli_fetch_assoc($result);


    $sortiesnonBOM = $row["sorties"];
    $aeroLostnonBOM = $row["aeroLST"];
    $pilotOKnonBOM = $row["pilotOK"];
    $pilotWoundednonBOM = $row["pilotWND"];

    $sorties = $sortiesBOM + $sortiesnonBOM;
    $aeroLost = $aeroLostBOM + $aeroLostnonBOM;
    $pilotOK = $pilotOKBOM + $pilotOKnonBOM;
    $pilotWounded = $pilotWoundedBOM + $pilotWoundednonBOM;

    //Get days survived on the front
    $sql = "SELECT frontdays FROM character_mission_frontdays WHERE author_id = $characterID AND mission_id = $missionID";
    $result = mysqli_query($dbx, $sql);
    $row = mysqli_fetch_assoc($result);

    $daysSurvivedOnTheFrontBoM = $row["frontdays"];

    $sql = "SELECT COUNT(DISTINCT report.id) AS swgv ".
        "FROM report LEFT JOIN claim ON claim.report_id = report.id ".
        "LEFT JOIN claim_ground ON claim.id = claim_ground.claim_id ".
        "WHERE character_id = $characterID AND report.accepted=1 AND claim.accepted = 1 ".
        "AND claim_ground.id IS NOT NULL AND report.mission_id <= $missionID";
    $result = mysqli_query($dbx, $sql);
    $row = mysqli_fetch_assoc($result);

    $sortiesWithGroundVictories = $row["swgv"];

    $succesfulReturns = $pilotOK + $pilotWounded;
    $points = $conf + 0.5*$unconf;
    if($succesfulReturns > 0){
        $rtbRatio = 1 - $aeroLost/$succesfulReturns;
    } else {
        $rtbRatio = 0;
    }

    //Sorties in Platzschutzstaffel Pitomnik
    $sql = "SELECT COUNT(report.id) AS sorties ".
        "FROM report ".
        "LEFT JOIN deployed_unit ON deployed_unit.id = report.deployed_unit_id ".
        "LEFT JOIN hist_unit ON hist_unit.id = deployed_unit.hist_unit_id ".
        "WHERE hist_unit.id = 96 AND character_id = $characterID AND report.accepted=1 ".
        "AND report.mission_id <= $missionID";
    $result = mysqli_query($dbx, $sql);
    $row = mysqli_fetch_assoc($result);
    $sortiesPSSP = $row["sorties"];

    //Check for Flugzeugführer und Beobachterabzeichen
    $medalAbr = "FBA";
    $criteria = $succesfulReturns > 1;
    $msg = "succesful returns $succesfulReturns > 1";
    addRemoveDecoration($medalAbr, $criteria, $decorationsArray, $awardedArray,
        $awardArray, $characterID, $missionDate, $dbx, $msg);


    //Check for Verwundetenabzeichen in schwarz
    $medalAbr = "VA II";
    $criteria = $pilotWounded > 0;
    $msg = "Pilot wounded $pilotWounded > 0";
    addRemoveDecoration($medalAbr, $criteria, $decorationsArray, $awardedArray,
        $awardArray, $characterID, $missionDate, $dbx, $msg);


    //Check for Verwundetenabzeichen in silber
    $medalAbr = "VA I";
    $criteria = $pilotWounded > 1;
    $msg = "Pilot wounded $pilotWounded > 1";
    addRemoveDecoration($medalAbr, $criteria, $decorationsArray, $awardedArray,
        $awardArray, $characterID, $missionDate, $dbx, $msg);


    //Mentioned in Wehrmachtsbericht
    $medalAbr = "WB";
    $criteria = $succesfulReturns > 9 & $rtbRatio >= 0.8;
    $msg = "Successful returns $succesfulReturns > 9 & RTB-ratio $rtbRatio >= 0.8";
    addRemoveDecoration($medalAbr, $criteria, $decorationsArray, $awardedArray,
        $awardArray, $characterID, $missionDate, $dbx, $msg);


    //Eisernes Kreuz 2. Klasse
    $medalAbr = "EK II";
    $criteriaA = $conf > 2;
    $criteriaB = $pilotWounded > 1;
    $criteriaC = $succesfulReturns > 9 & $rtbRatio >= 0.8;
    $criteria = ($criteriaA | $criteriaB | $criteriaC);
    $msg = "conf $conf > 2 | pilot wounded $pilotWounded > 1 | (Successful returns $succesfulReturns > 9 & RTB-ratio $rtbRatio >= 0.8";
    addRemoveDecoration($medalAbr, $criteria, $decorationsArray, $awardedArray,
        $awardArray, $characterID, $missionDate, $dbx, $msg);


    //Eisernes Kreuz 1. Klasse
    $medalAbr = "EK I";
    $criteria = $conf > 5;
    $msg = "conf $conf > 5";
    addRemoveDecoration($medalAbr, $criteria, $decorationsArray, $awardedArray,
        $awardArray, $characterID, $missionDate, $dbx, $msg);


    //Ritterkreuz des Eisernen Kreuzes
    $medalAbr = "RK II";
    $criteria = $points >= 15;
    $msg = "points $points >= 15";
    addRemoveDecoration($medalAbr, $criteria, $decorationsArray, $awardedArray,
        $awardArray, $characterID, $missionDate, $dbx, $msg);


    //Ritterkreuz des Eisernen Kreuzes mit Eichenlaub
    $medalAbr = "RK I";
    $criteria = $points >= 20;
    $msg = "points $points >= 20";
    addRemoveDecoration($medalAbr, $criteria, $decorationsArray, $awardedArray,
        $awardArray, $characterID, $missionDate, $dbx, $msg);


    //Ehrenpokal der Luftwaffe
    $medalAbr = "EP";
    $criteria = $points >= 25;
    $msg = "points $points >= 25";
    addRemoveDecoration($medalAbr, $criteria, $decorationsArray, $awardedArray,
        $awardArray, $characterID, $missionDate, $dbx, $msg);


    //Check for Flugzeugführer und Beobachterabzeichen in Gold mit Brillianten
    $medalAbr = "FBAgd";
    $criteria = $succesfulReturns > 29 & $conf > 19;
    $msg = "Successful returns $succesfulReturns > 29 & conf $conf > 19";
    addRemoveDecoration($medalAbr, $criteria, $decorationsArray, $awardedArray,
        $awardArray, $characterID, $missionDate, $dbx, $msg);

    //Frontflugspange für Kampf- und Sturzkampfflieger in Bronze
    $medalAbr = "FFS-KSKb";
    $criteria = $sortiesWithGroundVictories > 2;
    $msg = "Sorties with ground victories $sortiesWithGroundVictories > 2";
    addRemoveDecoration($medalAbr, $criteria, $decorationsArray, $awardedArray,
        $awardArray, $characterID, $missionDate, $dbx, $msg);

    //Frontflugspange für Kampf- und Sturzkampfflieger in Silber
    $medalAbr = "FFS-KSKs";
    $criteria = $sortiesWithGroundVictories > 5;
    $msg = "Sorties with ground victories $sortiesWithGroundVictories > 5";
    addRemoveDecoration($medalAbr, $criteria, $decorationsArray, $awardedArray,
        $awardArray, $characterID, $missionDate, $dbx, $msg);

    //Frontflugspange für Kampf- und Sturzkampfflieger in Gold
    $medalAbr = "FFS-KSKg";
    $criteria = $sortiesWithGroundVictories > 11;
    $msg = "Sorties with ground victories $sortiesWithGroundVictories > 11";
    addRemoveDecoration($medalAbr, $criteria, $decorationsArray, $awardedArray,
        $awardArray, $characterID, $missionDate, $dbx, $msg);

    //Medaille Winterschlacht im Osten
    $medalAbr = "OFM";
    $criteriaA = $sortiesBOM > 14;
    $criteriaB = $pilotWoundedBOM == 1;
    $criteriaC = $daysSurvivedOnTheFrontBoM > 29;
    $criteria = ($criteriaA | $criteriaB | $criteriaC);
    $msg = "Sorties BoM $sortiesBOM > 14 | pilot wounded BoM $pilotWoundedBOM == 1 | days survived on front BoM $daysSurvivedOnTheFrontBoM > 29";
    addRemoveDecoration($medalAbr, $criteria, $decorationsArray, $awardedArray,
        $awardArray, $characterID, $missionDate, $dbx, $msg);

    //Ärmelband Platzschutzstaffel Pitomnik
    $medalAbr = "SR PSSP";
    $criteria = $sortiesPSSP > 0;
    $msg = "Sorties with Platzschutzstfl Pitomnik $sortiesPSSP > 0";
    addRemoveDecoration($medalAbr, $criteria, $decorationsArray, $awardedArray,
        $awardArray, $characterID, $missionDate, $dbx, $msg);

}

function checkVVSDecorations($characterID, $missionID, $dbx){


    //Get date of mission
    $sql = "SELECT mission.real_date FROM mission WHERE mission.id = $missionID";
    $result = mysqli_query($dbx, $sql);
    $row = mysqli_fetch_assoc($result);
    $missionDate = $row["real_date"];


    //Get all decorations of the character
    $sql = "SELECT award.abreviation, decoration.id, decoration.awarded FROM award ".
        "LEFT JOIN decoration ON decoration.award_id = award.id ".
        "WHERE decoration.character_id = $characterID";
    $result = mysqli_query($dbx, $sql);
    $decorationsArray = array();
    $awardedArray = array();
    while($row = mysqli_fetch_array($result)){
        $decorationsArray[] = $row[0];
        $awardedArray[$row[0]]["id"] = $row[1];
        $awardedArray[$row[0]]["awarded"] = $row[2];
    }

    //Get all awards
    $sql = "SELECT id, abreviation FROM award ".
        "WHERE faction = 3";
    $result = mysqli_query($dbx, $sql);
    while($row = mysqli_fetch_array($result)){
        $awardArray["$row[1]"] = $row[0];
    }

    //Get stats for character
//    $sql = "SELECT report.character_id, COUNT(report.id) AS sorties, SUM(report.pilot_status = 0) AS pilotOK, ".
//        "SUM(report.pilot_status = 1) AS pilotWND, SUM(report.asset_status = 2) AS aeroLST ".
//        "FROM report LEFT JOIN mission ON report.mission_id = mission.id ".
//        "WHERE report.character_id = $characterID AND report.accepted = 1 AND mission.id <= $missionID";
//    $result = mysqli_query($dbx, $sql);
//    $row = mysqli_fetch_assoc($result);
//
//    $sorties = $row["sorties"];
//    $aeroLost = $row["aeroLST"];
//    $pilotOK = $row["pilotOK"];
//    $pilotWounded = $row["pilotWND"];

    //Get stats for character of Battle of Moscow missions
    $sql = "SELECT COUNT(report.id) AS sorties, SUM(report.pilot_status = 0) AS pilotOK, ".
        "SUM(report.pilot_status = 1) AS pilotWND, SUM(report.asset_status = 2) AS aeroLST ".
        "FROM report LEFT JOIN mission ON report.mission_id = mission.id ".
        "WHERE report.character_id = $characterID AND report.accepted = 1 AND mission.id <= $missionID ".
        "AND (hist_date >= '1941-10-15 00:00:00' AND hist_date <= '1942-04-15 23:59:59')";
    $result = mysqli_query($dbx, $sql);
    $row = mysqli_fetch_assoc($result);


    $sortiesBOM = $row["sorties"];
    $aeroLostBOM = $row["aeroLST"];
    $pilotOKBOM = $row["pilotOK"];
    $pilotWoundedBOM = $row["pilotWND"];

    //Get stats for character of non Battle of Moscow missions
    $sql = "SELECT COUNT(report.id) AS sorties, SUM(report.pilot_status = 0) AS pilotOK, ".
        "SUM(report.pilot_status = 1) AS pilotWND, SUM(report.asset_status = 2) AS aeroLST ".
        "FROM report LEFT JOIN mission ON report.mission_id = mission.id ".
        "WHERE report.character_id = $characterID AND report.accepted = 1 AND mission.id <= $missionID ".
        "AND (hist_date < '1941-10-15 00:00:00' OR hist_date > '1942-04-15 23:59:59')";
    $result = mysqli_query($dbx, $sql);
    $row = mysqli_fetch_assoc($result);


    $sortiesnonBOM = $row["sorties"];
    $aeroLostnonBOM = $row["aeroLST"];
    $pilotOKnonBOM = $row["pilotOK"];
    $pilotWoundednonBOM = $row["pilotWND"];

    $sorties = $sortiesBOM + $sortiesnonBOM;
    $aeroLost = $aeroLostBOM + $aeroLostnonBOM;
    $pilotOK = $pilotOKBOM + $pilotOKnonBOM;
    $pilotWounded = $pilotWoundedBOM + $pilotWoundednonBOM;

    //Get days survived on the front
    $sql = "SELECT frontdays FROM character_mission_frontdays WHERE author_id = $characterID AND mission_id = $missionID";
    $result = mysqli_query($dbx, $sql);
    $row = mysqli_fetch_assoc($result);

    $daysSurvivedOnTheFrontBoM = $row["frontdays"];

    $sql = "SELECT SUM(claim_vvs.confirmed=1) AS conf, SUM(claim_vvs.confirmed=0) AS unconf ".
        "FROM claim LEFT JOIN report ON claim.report_id = report.id ".
        "LEFT JOIN claim_vvs ON claim.id = claim_vvs.claim_id ".
        "WHERE character_id = $characterID AND report.accepted=1 AND claim.accepted = 1 ".
        "AND claim_vvs.group_claim = 0 AND report.mission_id <= $missionID";
    $result = mysqli_query($dbx, $sql);
    $row = mysqli_fetch_assoc($result);

    $conf = $row["conf"];
    $unconf = $row["unconf"];

    $sql = "SELECT SUM(character_claim_vvs_group.conf) AS conf, SUM(character_claim_vvs_group.unconf) AS unconf ".
        "FROM character_claim_vvs_group WHERE character_id = $characterID ".
        "AND mission_id <= $missionID ";
    $result = mysqli_query($dbx, $sql);
    $row = mysqli_fetch_assoc($result);

    $gconf = $row["conf"];
    $gunconf = $row["unconf"];

    $sql = "SELECT MAX(x.conf) AS maxConf, MAX(x.unconf) AS maxUnconf ".
        "FROM ( ".
        "SELECT SUM(claim_vvs.confirmed=1) AS conf, SUM(claim_vvs.confirmed=0) AS unconf ".
        "FROM claim LEFT JOIN claim_vvs ON claim.id = claim_vvs.claim_id ".
        "LEFT JOIN report ON claim.report_id = report.id ".
        "WHERE character_id = $characterID AND report.accepted=1 AND claim.accepted = 1 ".
        "AND claim_vvs.group_claim = 0 AND report.mission_id <= $missionID ".
        "GROUP BY mission_id ) AS x ";
    $result = mysqli_query($dbx, $sql);
    $row = mysqli_fetch_assoc($result);

    $maxConfPerSortie = $row["maxConf"];
    $maxUnconfPerSortie = $row["maxUnconf"];

    $succesfulReturns = $pilotOK + $pilotWounded;

//    $sql = "SELECT IFNULL(MAX(criteriaclaims),0) AS criteria FROM merit_stats ".
//        "WHERE character_id = $characterID AND mission_id <= $missionID";
//    $result = mysqli_query($dbx, $sql);
//    $row = mysqli_fetch_assoc($result);

    $maxConfPerSortieAllSurvive = $row["criteria"];

    //Aviation Badge
    $medalAbr = "AB_VVS";
    $criteria = $succesfulReturns > 1;
    $msg = "Successful Returns: $succesfulReturns > 1";
    addRemoveDecoration($medalAbr, $criteria, $decorationsArray, $awardedArray,
        $awardArray, $characterID, $missionDate, $dbx, $msg);

    //Order of the Red Star
    $medalAbr = "OOTRS_VVS";
    $criteria = $conf > 2;
    $msg = "conf: $conf > 2";
    addRemoveDecoration($medalAbr, $criteria, $decorationsArray, $awardedArray,
        $awardArray, $characterID, $missionDate, $dbx, $msg);

    //Order of the Red Banner
    $medalAbr = "OOTRB_VVS";
    $criteria = $conf > 5;
    $msg = "conf: $conf > 5";
    addRemoveDecoration($medalAbr, $criteria, $decorationsArray, $awardedArray,
        $awardArray, $characterID, $missionDate, $dbx, $msg);

    //Medal "For Courage"
    $medalAbr = "MFC_VVS";
    $criteria = $maxConfPerSortie > 2;
    $msg = "max. conf per sortie $maxConfPerSortie > 2";
    addRemoveDecoration($medalAbr, $criteria, $decorationsArray, $awardedArray,
        $awardArray, $characterID, $missionDate, $dbx, $msg);

    //Medal "For Battle Merit"
//    $medalAbr = "FBM_VVS";
//    $criteria = $maxConfPerSortieAllSurvive > 6;
//    addRemoveDecoration($medalAbr, $criteria, $decorationsArray, $awardedArray,
//        $awardArray, $characterID, $missionDate, $dbx);

    //Order of Lenin
    $medalAbr = "OOL_VVS";
    $criteria = ($conf + $gconf) > 9 & $sorties > 20;
    $msg = "(conf: $conf + gconf: $gconf) > 9 & sorties $sorties > 20";
    addRemoveDecoration($medalAbr, $criteria, $decorationsArray, $awardedArray,
        $awardArray, $characterID, $missionDate, $dbx, $msg);

    //Aircraft Kill Bonus
    $medalAbr = "AKB_VVS";
    $criteria = $conf > 0;
    $msg = "conf: $conf > 0";
    addRemoveDecoration($medalAbr, $criteria, $decorationsArray, $awardedArray,
        $awardArray, $characterID, $missionDate, $dbx, $msg);

    //5 Combat Sortie Bonus
    $medalAbr = "5CSB_VVS";
    $criteria = $succesfulReturns > 4;
    $msg = "Successful returns: $succesfulReturns > 4";
    addRemoveDecoration($medalAbr, $criteria, $decorationsArray, $awardedArray,
        $awardArray, $characterID, $missionDate, $dbx, $msg);

    //15 Combat Sortie Bonus
    $medalAbr = "15CSB_VVS";
    $criteria = $succesfulReturns > 14;
    $msg = "Successful returns: $succesfulReturns > 14";
    addRemoveDecoration($medalAbr, $criteria, $decorationsArray, $awardedArray,
        $awardArray, $characterID, $missionDate, $dbx, $msg);

    //25 Combat Sortie Bonus
    $medalAbr = "25CSB_VVS";
    $criteria = $succesfulReturns > 24;
    $msg = "Successful returns: $succesfulReturns > 24";
    addRemoveDecoration($medalAbr, $criteria, $decorationsArray, $awardedArray,
        $awardArray, $characterID, $missionDate, $dbx, $msg);

    //40 Combat Sortie Bonus
    $medalAbr = "40CSB_VVS";
    $criteria = $succesfulReturns > 39;
    $msg = "Successful returns: $succesfulReturns > 39";
    addRemoveDecoration($medalAbr, $criteria, $decorationsArray, $awardedArray,
        $awardArray, $characterID, $missionDate, $dbx, $msg);

    //Medal "For the Defence of Moscow"
    $medalAbr = "MFTDOM_VVS";
    $criteriaA = $sortiesBOM > 14;
    $criteriaB = $daysSurvivedOnTheFrontBoM > 30;
    $criteria = ($criteriaA | $criteriaB);
    $msg = "(sorties BM $sortiesBOM > 14 |  days survived at front BoM $daysSurvivedOnTheFrontBoM > 30)";
    addRemoveDecoration($medalAbr, $criteria, $decorationsArray, $awardedArray,
        $awardArray, $characterID, $missionDate, $dbx, $msg);


}

function checkRADecorations($characterID, $missionID, $dbx){


    //Get date of mission
    $sql = "SELECT mission.real_date FROM mission WHERE mission.id = $missionID";
    $result = mysqli_query($dbx, $sql);
    $row = mysqli_fetch_assoc($result);
    $missionDate = $row["real_date"];


    //Get all decorations of the character
    $sql = "SELECT award.abreviation, decoration.id, decoration.awarded FROM award ".
        "LEFT JOIN decoration ON decoration.award_id = award.id ".
        "WHERE decoration.character_id = $characterID";
    $result = mysqli_query($dbx, $sql);
    $decorationsArray = array();
    $awardedArray = array();
    while($row = mysqli_fetch_array($result)){
        $decorationsArray[] = $row[0];
        $awardedArray[$row[0]]["id"] = $row[1];
        $awardedArray[$row[0]]["awarded"] = $row[2];
    }

    //Get all awards
    $sql = "SELECT id, abreviation FROM award ".
        "WHERE faction = 2";
    $result = mysqli_query($dbx, $sql);
    while($row = mysqli_fetch_array($result)){
        $awardArray["$row[1]"] = $row[0];
    }

    //Get stats for character of non-Battle of Britain missions
    $sql = "SELECT COUNT(report.id) AS sorties, SUM(report.pilot_status = 0) AS pilotOK, ".
        "SUM(report.pilot_status = 1) AS pilotWND, SUM(report.asset_status = 2) AS aeroLST ".
        "FROM report LEFT JOIN mission ON report.mission_id = mission.id ".
        "WHERE report.character_id = $characterID AND report.accepted = 1 AND mission.id <= $missionID ".
        "AND (hist_date < '1940-06-10 00:00:00' OR hist_date > '1940-10-31 23:59:59')";
    $result = mysqli_query($dbx, $sql);
    $row = mysqli_fetch_assoc($result);

    $sortiesNonBOB = $row["sorties"];
    $aeroLostNonBOB = $row["aeroLST"];
    $pilotOKNonBOB = $row["pilotOK"];
    $pilotWoundedNonBOB = $row["pilotWND"];

    //Get stats for character of Battle of Britain missions
    $sql = "SELECT COUNT(report.id) AS sorties, SUM(report.pilot_status = 0) AS pilotOK, ".
        "SUM(report.pilot_status = 1) AS pilotWND, SUM(report.asset_status = 2) AS aeroLST ".
        "FROM report LEFT JOIN mission ON report.mission_id = mission.id ".
        "WHERE report.character_id = $characterID AND report.accepted = 1 AND mission.id <= $missionID ".
        "AND (hist_date >= '1940-06-10 00:00:00' AND hist_date <= '1940-10-31 23:59:59')";
    $result = mysqli_query($dbx, $sql);
    $row = mysqli_fetch_assoc($result);


    $sortiesBOB = $row["sorties"];
    $aeroLostBOB = $row["aeroLST"];
    $pilotOKBOB = $row["pilotOK"];
    $pilotWoundedBOB = $row["pilotWND"];

    $sorties = $sortiesNonBOB + $sortiesBOB;
    $aeroLost = $aeroLostNonBOB + $aeroLostBOB;
    $pilotOK = $pilotOKNonBOB + $pilotOKBOB;
    $pilotWounded = $pilotWoundedNonBOB + $pilotWoundedBOB;

    $sql = "SELECT career_character.personified_by FROM career_character ".
        "WHERE career_character.id = $characterID";
    $querry = mysqli_query($dbx, $sql);
    $result = mysqli_fetch_assoc($querry);
    $memberID = $result["personified_by"];
    $rankValue = getRankValueAtMission($memberID, $missionID, $dbx);

    $sql = "SELECT SUM(destrtable.pointsdestr) AS destr FROM report ".
        "LEFT JOIN (SELECT claim.report_id, (1-claim_raf.shared*0.5) AS pointsdestr FROM claim
            LEFT JOIN claim_raf ON claim.id = claim_raf.claim_id WHERE enemy_status = 0 AND claim.accepted = 1) AS destrtable ON destrtable.report_id = report.id ".
        "WHERE report.accepted = 1  AND character_id = $characterID AND report.mission_id <= $missionID";

    $result = mysqli_query($dbx, $sql);
    $row = mysqli_fetch_assoc($result);
    $destroyed = $row["destr"];

    $sql = "SELECT SUM(probtable.pointsprob) AS prob FROM report ".
        "LEFT JOIN (SELECT claim.report_id, (1-claim_raf.shared*0.5) AS pointsprob FROM claim
           LEFT JOIN claim_raf ON claim.id = claim_raf.claim_id WHERE enemy_status = 1 AND claim.accepted = 1) AS probtable ON probtable.report_id = report.id ".
        "WHERE report.accepted = 1 AND character_id = $characterID AND report.mission_id <= $missionID";

    $result = mysqli_query($dbx, $sql);
    $row = mysqli_fetch_assoc($result);
    $probable = $row["prob"];

    $sql = "SELECT COUNT(dmgtable.pointsdmg) AS dmg FROM report ".
        "LEFT JOIN (SELECT claim.report_id, (1-claim_raf.shared*0.5) AS pointsdmg FROM claim
             LEFT JOIN claim_raf ON claim.id = claim_raf.claim_id WHERE enemy_status = 2 AND claim.accepted = 1) AS dmgtable ON dmgtable.report_id = report.id ".
        "WHERE report.accepted = 1 AND character_id = $characterID AND report.mission_id <= $missionID";
//    echo $sql;
    $result = mysqli_query($dbx, $sql);
    $row = mysqli_fetch_assoc($result);
    $damaged = $row["dmg"];

    $succesfulReturnsNonBOB = $pilotOKNonBOB + $pilotWoundedNonBOB;
    $succesfulReturnsBOB = $pilotOKBOB + $pilotWoundedBOB;
    $succesfulReturns = $pilotOK + $pilotWounded;
    $points = $destroyed*10 + $probable*5 + $damaged*2;
    if($sorties > 0){
        $rtbRatio = 1 - $aeroLost/$sorties;
    } else {
        $rtbRatio = 0;
    }

    //Check for RA Pilot Badge
    $medalAbr = "BPM";
    $criteria = $succesfulReturns > 1;
    $msg = "succesfulReturns $succesfulReturns > 1";
    addRemoveDecoration($medalAbr, $criteria, $decorationsArray, $awardedArray,
        $awardArray, $characterID, $missionDate, $dbx, $msg);

    //Medaglia di bronzo al valor Militare
    $medalAbr = "VMB";
    $criteria = ($destroyed >= 2 | $points > 30);
    $msg = "(dest $destroyed >= 2 | points $points > 30)";
    addRemoveDecoration($medalAbr, $criteria, $decorationsArray, $awardedArray,
        $awardArray, $characterID, $missionDate, $dbx, $msg);


    //Medaglia d' argento al valor Militare
    $medalAbr = "VMA";
    $criteria = ($destroyed >= 5 | $points > 100);
    $msg = "(dest $destroyed >= 5 | points $points > 100)";
    addRemoveDecoration($medalAbr, $criteria, $decorationsArray, $awardedArray,
        $awardArray, $characterID, $missionDate, $dbx, $msg);

    //Croce al Merito di Guerra
    $medalAbr = "CMG";
    $criteria = $succesfulReturns > 5 & ($destroyed >= 2 | $points > 30);
    $msg = "succesfulReturns $succesfulReturns > 5 & (dest $destroyed >= 2 | points $points > 30)";
    addRemoveDecoration($medalAbr, $criteria, $decorationsArray, $awardedArray,
        $awardArray, $characterID, $missionDate, $dbx, $msg);

    //Croce al Valore Militare
    $medalAbr = "CVM";
    $criteria = $succesfulReturns > 10 & ($destroyed >= 5 | $points > 100);
    $msg = "succesfulReturns $succesfulReturns > 10 & (dest $destroyed >= 5 | points $points > 100)";
    addRemoveDecoration($medalAbr, $criteria, $decorationsArray, $awardedArray,
        $awardArray, $characterID, $missionDate, $dbx, $msg);

    //Croce di Ferro 2a Classe
    $medalAbr = "CF II";
    $criteria = ($destroyed >= 8 | $points > 150);
    $msg = "(dest $destroyed >= 8 | points $points > 150)";
    addRemoveDecoration($medalAbr, $criteria, $decorationsArray, $awardedArray,
        $awardArray, $characterID, $missionDate, $dbx, $msg);

}

function addRemoveDecoration($medalAbr, $criteria, $decorationsArray, $awardedArray, $awardArray,
                             $characterID, $missionDate, $dbx, $msg){
    echo "Checking: $medalAbr for character $characterID after mission $missionDate --";
    echo "$msg -- ";
    if(!in_array($medalAbr, $decorationsArray)){

        if($criteria){
            echo " criteria fulfilled ";
            $awardID = $awardArray[$medalAbr];
            $sql = "INSERT INTO decoration (character_id, award_id, date, awarded, recommendation_date) VALUES ".
                "($characterID, $awardID, '$missionDate', false, '$missionDate')";
            mysqli_query($dbx, $sql);
            echo " awarded ";
        }
    } else if(!$awardedArray[$medalAbr]["awarded"]){

        if(!$criteria){
            $decorationID = $awardedArray[$medalAbr]["id"];
            $sql = "DELETE FROM decoration WHERE id=$decorationID";
            mysqli_query($dbx, $sql);
            echo " revoked ";
        }
    }
    echo " ============ ";
}

function getRankValueAtMission($memberID, $missionID, $dbx){

    $sql = "SELECT disp_value FROM mission_member_rank WHERE member_id = $memberID AND mission_id = $missionID";
    $querry = mysqli_query($dbx, $sql);
    $numrow = mysqli_num_rows($querry);
    if($numrow>0){
        $result = mysqli_fetch_assoc($querry);
        return $result["disp_value"];
    } else {
        return FALSE;
    }
}
