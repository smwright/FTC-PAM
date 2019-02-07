<?php
/**
 * Created by IntelliJ IDEA.
 * User: rafaelg
 * Date: 9/13/18
 * Time: 3:00 PM
 */

include_once(dirname(__FILE__).'/dbx.php');

function whitelist_table($name) {

    switch ($name){
        case "campaign_list":
            $result = $name;
            break;
        case "campaign_info_unit":
            $result = $name;
            break;
        case "campaign_unit_member_info":
            $result = $name;
            break;
        case "campaign_unit_plane_asset_status":
            $result = $name;
            break;
        default:
            header('HTTP/1.1 403 Forbidden');
            echo("Table not listed: $name");
    }
    return $result;
}

// retrieving parameter array
//$requestBody = file_get_contents("php://input");
//$param = json_decode($requestBody,true);

//retrieving database connection
$dbx = getDBx();

// creating sql querry
if(filter_has_var(INPUT_GET, "view")) {

    $view_name = whitelist_table(filter_input(INPUT_GET, "view"));
    $query = "SELECT * FROM $view_name";
    $counter = 0;
    $var_types = "";
    $var_array = [];
    $params = filter_input_array(INPUT_GET);
    foreach ($params as $var_name => $var_value) {
        $counter++;
        if($var_name == "view"){
            continue;
        }

        if($counter == 2){
            $query .= " WHERE";
        } else {
            $query .= " AND";
        }
        $query .= " $var_name = ?";
        if(is_numeric($var_value)) {
            $var_types .= "i";
        } else if(is_string($var_value)) {
            $var_types .= "s";
        }
        $var_array[$var_name] = &$params[$var_name];
    }
    $stmt = mysqli_prepare($dbx, $query);
    $params = array_merge(array($stmt, $var_types), $var_array);
    call_user_func_array('mysqli_stmt_bind_param', $params);
    mysqli_stmt_execute($stmt);
    $result = mysqli_stmt_get_result($stmt);

    if (mysqli_num_rows($result)>0) {
        echo(json_encode(mysqli_fetch_all($result, MYSQLI_ASSOC),JSON_NUMERIC_CHECK));
    } else {
//        echo("Empty result: ".var_export($result, true));
        echo(json_encode(array()));
    }
}
mysqli_stmt_close($stmt);
mysqli_close($dbx);
exit();