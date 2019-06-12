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

        "asset" => array("name", "faction", "controlable", "lft", "rgt")
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
    $parcel_keys = array_map(updateQuerryString, $parcel_keys);
    $update_querry = "UPDATE $table_name SET " .
        implode(", ", $parcel_keys) .
        " WHERE id = ?";
    $update_stmt = mysqli_prepare($dbx, $update_querry);

    $insert_counter = 0;
    $insert_success = 0;
    $update_counter = 0;
    $update_success = 0;

    foreach ($payload as $parcel) {

        $id = $parcel["id"];
        $filtered_array = array_intersect_key($parcel, array_flip($table_fields));
        $parcel_values = array_values($filtered_array);
        $parcel_values_ref = array();
        for($i=0; $i<count($parcel_values); $i++){
            $parcel_values_ref[] = &$parcel_values[$i];
        }

        if ($id < 0) {
            //INSERTING
            $insert_counter++;
            $insert_bind_array = array_merge(array($insert_stmt, $parcel_types_insert), $parcel_values_ref);
            call_user_func_array('mysqli_stmt_bind_param', $insert_bind_array);
            if (mysqli_stmt_execute($insert_stmt)) {
                $insert_success++;
            } else {
                echo mysqli_error($insert_stmt);
            }
        } else if ($id >= 0) {
            //UPDATING
            $update_counter++;
            $parcel_values_ref[] = &$id;
            $update_bind_array = array_merge(array($update_stmt, $parcel_types_update), $parcel_values_ref);
            call_user_func_array('mysqli_stmt_bind_param', $update_bind_array);
            if (mysqli_stmt_execute($update_stmt)) {
                $update_success++;
            } else {
                echo mysqli_stmt_error($update_stmt);
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
    echo $result_string;
}

mysqli_stmt_close($insert_stmt);
mysqli_stmt_close($update_stmt);
mysqli_close($dbx);
exit();