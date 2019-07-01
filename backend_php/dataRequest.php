<?php
/**
 * Created by IntelliJ IDEA.
 * User: rafaelg
 * Date: 9/13/18
 * Time: 3:00 PM
 */

include_once(dirname(__FILE__).'/dbx.php');


function whitelist_table($name) {

    $available_views = [
        "acg_unit",
        "asset_info",
        "asset_subtree",
        "briefing",
        "briefing_info",
        "campaign",
        "campaign_list",
        "campaign_info_unit",
        "campaign_member_latest_unit",
        "campaign_unit_member_info",
        "campaign_unit_plane_asset_status",
        "campaign_mission_info",
        "character_latest_report",
        "claim_raf_info",
        "claim_lw_info",
        "claim_vvs_info",
        "claim_ground_info",
        "comment_info",
        "current_unit_members",
        "member_info_with_last_status",
        "mission_report_nav_list",
        "mission_member_faction",
        "mission_member_rank",
        "random_first_name",
        "random_last_name",
        "report_info",
        "report_detail_raf",
        "report_detail_lw",
        "hist_unit_info",
        "depl_unit_info",
        "hist_unit",
        "report_submission_depl_units"
    ];

    if(in_array($name, $available_views)){
        return $name;
    } else {
        echo("Table not white-listed: $name");
        header('HTTP/1.1 403 Forbidden');
    }
}

//retrieving database connection
$dbx = getDBx();
mysqli_set_charset($dbx, "utf8");

// creating sql querry
if(filter_has_var(INPUT_GET, "view")) {

    $view_name = whitelist_table(filter_input(INPUT_GET, "view"));
    $query = "SELECT * FROM $view_name";
    $counter = 0;
    $var_types = "";
    $var_array = [];
    $order_string = "";
    $params = filter_input_array(INPUT_GET);
    foreach ($params as $var_name => $var_value) {
        $counter++;
        if($var_name == "view"){
            continue;
        }

        if($var_name == "order"){
            $order_string = $var_value;
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
    $query .= " ".$order_string;
    $stmt = mysqli_prepare($dbx, $query);
    $params = array_merge(array($stmt, $var_types), $var_array);
//    echo mysqli_character_set_name($dbx);
//    echo var_dump($query);
//    echo var_dump($var_types);
//    echo var_dump($var_array);
//    $func = 'mysqli_stmt_bind_param';
//    $func(...$params);
    call_user_func_array('mysqli_stmt_bind_param', $params);
//    echo var_dump($stmt);
    mysqli_stmt_execute($stmt);
//    echo var_dump($stmt);
    $result = mysqli_stmt_get_result($stmt);

    if (mysqli_num_rows($result)>0) {
        echo (json_encode(mysqli_fetch_all($result, MYSQLI_ASSOC),JSON_NUMERIC_CHECK));
    } else {
//        echo("Empty result: ".var_export($result, true));
        echo (json_encode([]));
    }
}
mysqli_stmt_close($stmt);
mysqli_close($dbx);
exit();