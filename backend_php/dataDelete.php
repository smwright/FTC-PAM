<?php
/**
 * Created by IntelliJ IDEA.
 * User: rafaelg
 * Date: 14/03/19
 * Time: 10:38
 */

include_once(dirname(__FILE__).'/dbx.php');

$params = json_decode( file_get_contents( 'php://input' ), true );

function whitelist_table($name) {

    $available_tables = array(

        "asset" => array("id"),
        "career_character" => array("id"),
        "deployed_unit" => array("id"),
        "hist_unit" => array("id"),
        "mission" => array("id"),
        "briefing" => array("id"),
        "claim" => array("id"),
        "claim_lw" => array("id"),
        "claim_raf" => array("id"),
        "claim_vvs" => array("id"),
        "claim_ground" => array("id"),
        "comment" => array("id"),
        "member_status_log" => array("id"),
        "promotion" => array("id"),
        "transfer" => array("id")
    );


    if(array_key_exists($name, $available_tables)){
        return $available_tables[$name];
    } else {
        header('HTTP/1.1 403 Forbidden');
        echo("Table not white-listed: $name");
        exit();
    }
}

//retrieving database connection
$dbx = getDBx();
mysqli_set_charset($dbx, "utf8");

// creating sql querry
if(array_key_exists("table", $params)) {

    $table_name = filter_var($params["table"], FILTER_SANITIZE_STRING);
    $table_fields = whitelist_table($table_name);
    $payload = filter_var_array($params["payload"], FILTER_DEFAULT);

    //Create delete statement
    $delete_querry = "DELETE FROM $table_name WHERE id = ?";
    $delete_stmt = mysqli_prepare($dbx, $delete_querry);

    $delete_counter = 0;
    $delete_success = 0;
    $error_str = "";

    foreach ($payload as $parcel) {
        $id = &$parcel["id"];
        $filtered_array = array_intersect_key($parcel, array_flip($table_fields));
        $parcel_values = array_values($filtered_array);

        $delete_counter++;
        mysqli_stmt_bind_param($delete_stmt, "i", $id);
        if (mysqli_stmt_execute($delete_stmt)) {
            $delete_success += mysqli_stmt_affected_rows($delete_stmt);
        } else {
            $error_str .= mysqli_error($dbx).", ";
        }

    }

    $result_string = "";
    if($delete_counter > 0){
        $result_string .= "Deleted $delete_success of $delete_counter entries, ";
    }

    $result_array = array('message'=>$result_string, 'error'=>$error_str);
    echo json_encode($result_array);
}

mysqli_stmt_close($delete_stmt);
mysqli_close($dbx);
exit();