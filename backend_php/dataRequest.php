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
        default:
            echo "Table not listed: $name";
            exit;
    }
    return $result;
}

// retrieving parameter array
//$requestBody = file_get_contents("php://input");
//$param = json_decode($requestBody,true);

//retrieving database connection
$dbx = getDBx();

// creating sql querry
//if (array_key_exists("view", $param)) {
if(filter_has_var(INPUT_GET, "view")) {

    $view_name = whitelist_table(filter_input(INPUT_GET, "view"));
    if(filter_has_var(INPUT_GET, "id")){
        $query = "SELECT * FROM $view_name WHERE id = ?";
        $id = filter_input(INPUT_GET, "id");
        $stmt = mysqli_prepare($dbx, $query);
        mysqli_stmt_bind_param($stmt, "i",$id);
    } if(filter_has_var(INPUT_GET, "campaign_id")){
        $query = "SELECT * FROM $view_name WHERE campaign_id = ?";
        $id = filter_input(INPUT_GET, "campaign_id");
        $stmt = mysqli_prepare($dbx, $query);
        mysqli_stmt_bind_param($stmt, "i",$id);
    } else {
        $query = "SELECT * FROM $view_name";
        $stmt = mysqli_prepare($dbx, $query);
    }
    mysqli_stmt_execute($stmt);
    $result = mysqli_stmt_get_result($stmt);


//    $sql = "SELECT * FROM ".filter_input(INPUT_GET, "view");
//    $result = mysqli_query($dbx, $sql);
    if (mysqli_num_rows($result)>0) {
        echo(json_encode(mysqli_fetch_all($result, MYSQLI_ASSOC),JSON_NUMERIC_CHECK));
    } else {
        echo("Empty result: ".var_export($result, true));
    }
}
mysqli_stmt_close($stmt);
mysqli_close($dbx);
exit();