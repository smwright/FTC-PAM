<?php
/**
 * Created by IntelliJ IDEA.
 * User: rafaelg
 * Date: 6/6/18
 * Time: 11:19 PM
 */


/**
 * Created by IntelliJ IDEA.
 * User: rafaelg
 * Date: 11/03/19
 * Time: 12:07
 */

include_once(dirname(__FILE__).'/dbx.php');

$params = json_decode( file_get_contents( 'php://input' ), true );

function whitelist_table($name) {

    $available_tables = array(

        "acg_member" => array("username", "callsign", "admin"),
        "asset" => array("name", "faction", "controlable", "lft", "rgt"),
        "briefing" => array("mission_id", "faction", "text"),
        "campaign" => array("name", "is_primary", "platform", "campaign_status", "time", "open", "campaign_link",
            "description", "image"),
        "career_character" => array("personified_by", "first_name", "last_name"),
        "claim" => array("report_id", "asset_id", "description", "accepted", "accepted_by"),
        "claim_lw" => array("claim_id", "claim_time", "place", "opponent", "type_of_destruction", "type_of_impact",
            "fate_of_crew", "witness", "confirmed"),
        "claim_raf" => array("claim_id", "enemy_status", "shared"),
        "claim_vvs" => array("claim_id", "claim_time", "place", "witness", "confirmed", "group_claim"),
        "claim_ground" => array("claim_id", "amount"),
        "comment" => array("report_id", "member_id", "comment_date", "comment_text"),
        "decoration" => array("date", "comment", "awarded", "awarded_by"),
        "deployed_unit" => array("campaign_id", "acg_unit_id", "hist_unit_id", "asset_id", "report_type", "lft", "rgt"),
        "hist_unit" => array("name", "code", "faction", "type", "description", "image"),
        "member_status_log" => array("member_id", "member_status", "status_date_in", "status_date_out", "comment"),
        "mission" => array("name", "campaign_id", "real_date", "hist_date", "mission_status"),
        "promotion" => array("member_id", "rank_value", "promotion_date", "comment"),
        "report" => array("mission_id", "character_id", "deployed_unit_id", "base", "asset_id", "markings", "synopsis",
            "asset_status", "pilot_status", "date_submitted", "accepted", "accepted_by"),
        "report_detail_lw" => array("report_id", "swarm", "swarm_pos"),
        "report_detail_raf" => array("report_id", "flight", "section", "section_pos", "serial_no"),
        "transfer" => array("member_id", "acg_unit_id", "transfer_date_in", "transfer_date_out"),

    );


    if(array_key_exists($name, $available_tables)){
        return $available_tables[$name];
    } else {
        header('HTTP/1.1 403 Forbidden');
        echo("Table not white-listed: $name");
        exit();
    }
}

function filterVarType($value) {

    if(is_numeric($value)) {
        return "i";
    } else if(is_string($value)) {
        return "s";
    }
}

function updateQuerryString($value) {

    return "$value = ?";
}

////retrieving database connection
$dbx = getDBx();
mysqli_set_charset($dbx, "utf8");

//// creating sql querry
if(array_key_exists("table", $params)) {

    $table_name = filter_var($params["table"], FILTER_SANITIZE_STRING);
    $table_fields = whitelist_table($table_name);
    $payload = filter_var_array($params["payload"], FILTER_DEFAULT);

    $parcel = $payload[0];
    $filtered_array = array_intersect_key($parcel, array_flip($table_fields));
    $parcel_values = array_values($filtered_array);
    $parcel_types_insert = implode("", array_map(filterVarType, $parcel_values));
    $parcel_types_update = $parcel_types_insert."i";

    //Create insert prepared statement
    $parcel_keys = array_keys($filtered_array);
    $placeholder = array_fill(0, sizeof($filtered_array), "?");
    $insert_querry = "INSERT INTO $table_name " .
        "(" . implode(", ", $parcel_keys) . ") " .
        " VALUES (" . implode(", ", $placeholder) . ")";
    $insert_stmt = mysqli_prepare($dbx, $insert_querry);

    //Create update prepared statement
    $parcel_keys_insert = array_map(updateQuerryString, $parcel_keys);
    $update_querry = "UPDATE $table_name SET " .
        implode(", ", $parcel_keys_insert) .
        " WHERE id = ?";
    $update_stmt = mysqli_prepare($dbx, $update_querry);

    $insert_counter = 0;
    $insert_success = 0;
    $update_counter = 0;
    $update_success = 0;
    $insert_array = array();
    $error_str = "";
    foreach ($payload as $parcel) {

        $id = $parcel["id"];
        $filtered_array = array_intersect_key($parcel, array_flip($table_fields));
        $parcel_values_ref = array();
        for($i=0; $i<count($parcel_keys); $i++){

            if($filtered_array[$parcel_keys[$i]] == ""){
                $parcel_values_ref[] = NULL;
            } else {
                $parcel_values_ref[] = &$filtered_array[$parcel_keys[$i]];
            }
        }

        if ($id < 0) {
            //INSERTING
            $insert_counter++;
            $insert_bind_array = array_merge(array($insert_stmt, $parcel_types_insert), $parcel_values_ref);
            $func = 'mysqli_stmt_bind_param';
            $func(...$insert_bind_array);
//            call_user_func_array('mysqli_stmt_bind_param', $insert_bind_array);
            if (mysqli_stmt_execute($insert_stmt)) {
                $insert_success += mysqli_stmt_affected_rows($insert_stmt);
                $insert_array[] = array("old_id" => (int)$id, "new_id" => mysqli_stmt_insert_id($insert_stmt));
            } else {
                $error_str .= "id: $id ".mysqli_error($dbx).", ";
            }
        } else if ($id >= 0) {
            //UPDATING
            $update_counter++;
            $parcel_values_ref[] = &$id;
            $update_bind_array = array_merge(array($update_stmt, $parcel_types_update), $parcel_values_ref);
            $func = 'mysqli_stmt_bind_param';
            $func(...$update_bind_array);
//            call_user_func_array('mysqli_stmt_bind_param', $update_bind_array);
            if (mysqli_stmt_execute($update_stmt)) {
                $update_success += mysqli_stmt_affected_rows($update_stmt);
            } else {
                $error_str .= "id: $id ".mysqli_error($dbx).", ";
//                $error_str .= "id: $id , ";
            }
        }
    }

    $result_string = "";
    if($insert_counter > 0){
        $result_string .= "Inserted $insert_success of $insert_counter entries, ";
    }
    if($update_counter > 0){
        $result_string .= "Updated $update_success of $update_counter entries, ";
    }

    $result_array = array('message'=>$result_string, 'error'=>$error_str, 'insert_id'=>$insert_array);
    echo (json_encode($result_array));
}

mysqli_stmt_close($insert_stmt);
mysqli_stmt_close($update_stmt);
mysqli_close($dbx);
exit();