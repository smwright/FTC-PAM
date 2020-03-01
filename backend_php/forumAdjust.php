<?php
/**
 * Created by IntelliJ IDEA.
 * User: rafaelg
 * Date: 06/01/20
 * Time: 21:44
 */

include_once(dirname(__FILE__).'/dbx.php');

$params = json_decode( file_get_contents( 'php://input' ), true );
$dbx = getDBx();
mysqli_set_charset($dbx, "utf8");
if(array_key_exists("updateForumRank", $params)) {

    $memberId = filter_var($params["updateForumRank"], FILTER_SANITIZE_STRING);
    updateMemberForumRank($memberId, $dbx);
}

if(array_key_exists("synchronizeForumToCampaign", $params)) {

    $campaignID = filter_var($params["synchronizeForumToCampaign"], FILTER_SANITIZE_STRING);
    synchronizeForumToCampaign($campaignID, $dbx);
}

if(array_key_exists("updateForumGroup", $params)) {

    $memberId = filter_var($params["updateForumGroup"], FILTER_SANITIZE_STRING);
    updateMemberForumGroup($memberId, $dbx);
}

mysqli_close($dbx);
exit();

function updateMemberForumRank($memberId, $dbx){
    // This function adjusts the forum rank of the member to the current rank in the pam.
    // That is the most recent rank in the faction of the members current unit in the primary
    // and active campaign.

    $sql = "SELECT member_current_rank.username, rank.forum_id ".
        "FROM member_current_rank ".
        "LEFT JOIN rank ON member_current_rank.member_rank_id = rank.id ".
        "WHERE member_current_rank.member_id = $memberId";
    $query = mysqli_query($dbx, $sql);
    $result = mysqli_fetch_assoc($query);
    $username = strtolower($result["username"]);
    $forum_rankID = $result["forum_id"];

    //Connect to forum database and get forum user_id of username.
    $dbxForum = getForumDBx();
    $sql = "SELECT phpbb_users.user_id FROM phpbb_users ".
        "WHERE phpbb_users.username_clean = '$username'";
    $query = mysqli_query($dbxForum, $sql);
    $result = mysqli_fetch_assoc($query);
    $forum_user_id = $result["user_id"];

    //Change rank_id in forum database
    $sql = "UPDATE phpbb_users SET user_rank=$forum_rankID WHERE user_id=$forum_user_id";
    $result_array = executeSQL($sql, $dbxForum);
    echo (json_encode($result_array));
    mysqli_close($dbxForum);

}

function deleteMemberForumRank($memberId, $dbx){

    $sql = "SELECT username ".
        "FROM acg_member ".
        "WHERE acg_member.id = $memberId";
    $query = mysqli_query($dbx, $sql);
    $result = mysqli_fetch_assoc($query);
    $username = strtolower($result["username"]);
    $forum_rankID = $result["forum_id"];

    //Connect to forum database and get forum user_id of username.
    $dbxForum = getForumDBx();
    $sql = "SELECT phpbb_users.user_id FROM phpbb_users ".
        "WHERE phpbb_users.username_clean = '$username'";
    $query = mysqli_query($dbxForum, $sql);
    $result = mysqli_fetch_assoc($query);
    $forum_user_id = $result["user_id"];

    //Change rank_id in forum database
    $sql = "UPDATE phpbb_users SET user_rank='' WHERE user_id=$forum_user_id";
    $result_array = executeSQL($sql, $dbxForum);
    echo (json_encode($result_array));
    mysqli_close($dbxForum);
}

function updateMemberForumGroup($memberId, $dbx){
    // This function adjusts the forum groups of the member to the current unit in the pam.

    $sql = "SELECT username, member_status, member_info_with_last_status.acg_unit_id, ".
        "hist_unit.faction, acg_unit.forum_group_id, hist_unit.image AS hist_unit_image ".
        "FROM member_info_with_last_status ".
        "LEFT JOIN deployed_unit ON deployed_unit.acg_unit_id = member_info_with_last_status.acg_unit_id ".
        "LEFT JOIN hist_unit ON deployed_unit.hist_unit_id = hist_unit.id ".
        "LEFT JOIN campaign ON deployed_unit.campaign_id = campaign.id ".
        "LEFT JOIN acg_unit ON acg_unit.id = member_info_with_last_status.acg_unit_id ".
        "WHERE ((campaign.campaign_status = 1 AND campaign.is_primary = 1) OR deployed_unit.id IS NULL ) AND ".
        "member_id = $memberId";
    $query = mysqli_query($dbx, $sql);
    $result = mysqli_fetch_assoc($query);
    $username = strtolower($result["username"]);
    $member_status = $result["member_status"];
    $acg_unit_id = $result["username"];
    $forum_group_id = $result["forum_group_id"];
    $faction = $result["faction"];
    //FOR DEVELOPMENT
    $image_filename = "http://localhost:8080".$result["hist_unit_image"];
    //FOR DEPLOYMENT
//    $image_filename = "../frontend/src".$row["hist_unit_image"];

    $avatar_target_width = 50;
    list($width, $height) = getimagesize($image_filename);
    $scaling_factor = $avatar_target_width/$width;
    $scaled_width = (int)($width*$scaling_factor);
    $scaled_height = (int)($height*$scaling_factor);

    $result = [];
    $sql = "SELECT forum_group_id FROM acg_unit WHERE forum_group_id IS NOT NULL";
    $query = mysqli_query($dbx, $sql);
    while($row = mysqli_fetch_array($query)){
        $result[] = (int)$row['forum_group_id'];
    }
    $unit_forum_groups = implode (", ", $result);


    //Connect to forum database and get forum user_id of username.
    $dbxForum = getForumDBx();
    $sql = "SELECT phpbb_users.user_id FROM phpbb_users ".
        "WHERE phpbb_users.username_clean = '$username'";
    $query = mysqli_query($dbxForum, $sql);
    $result = mysqli_fetch_assoc($query);
    $forum_user_id = $result["user_id"];

    $result_array = [];

    // Remove member from all groups
    // Unit groups
    $sql = "DELETE FROM phpbb_user_group ".
        "WHERE user_id = $forum_user_id ".
        "AND group_id IN ($unit_forum_groups)";
    $result_array[] = executeSQL($sql, $dbxForum);

    // Faction groups, registered users, newly registered users, acg_member
    $sql = "DELETE FROM phpbb_user_group ".
        "WHERE user_id = $forum_user_id ".
        "AND group_id IN (14, 15, 2, 7, 36)";
    $result_array[] = executeSQL($sql, $dbxForum);

    // If active or on leave
    if($member_status != 1){

        // Unit group
        $sql = "INSERT INTO phpbb_user_group ".
            "(`group_id`, `user_id`, `group_leader`, `user_pending`) ".
            "VALUES ($forum_group_id, $forum_user_id, 0, 0)";
        $result_array[] = executeSQL($sql, $dbxForum);

        // acg member
        $sql = "INSERT INTO phpbb_user_group ".
            "(`group_id`, `user_id`, `group_leader`, `user_pending`) ".
            "VALUES (36, $forum_user_id, 0, 0)";
        $result_array[] = executeSQL($sql, $dbxForum);

        // Faction group
        if($faction == 2){
            // Allies - RAF
            $own_faction_group = 14;
            $colour = '990000';
        } else if($faction == 3) {
            // Allies - VVS
            $own_faction_group = 14;
            $colour = '990000';
        } else if($faction == 1) {
            // Axis - LW
            $own_faction_group = 15;
            $colour = '000066';
        } else {
            // RESERVE UNITS
            if($forum_group_id == 61){
                $own_faction_group = 14;
                $colour = '990000';
            } else if($forum_group_id == 62){
                $own_faction_group = 15;
                $colour = '000066';
            }
        }

        // Faction group
        $sql = "INSERT INTO phpbb_user_group ".
            "(`group_id`, `user_id`, `group_leader`, `user_pending`) ".
            "VALUES ($own_faction_group, $forum_user_id, 0, 0)";
        $result_array[] = executeSQL($sql, $dbxForum);

        $sql = "UPDATE phpbb_users ".
            "SET ".
            "`group_id` = $forum_group_id, ".
            "`user_colour` = '$colour', ".
            "`user_avatar` = '$image_filename', ".
            "`user_avatar_type` = 'avatar.driver.remote', ".
            "`user_avatar_width` = $scaled_width, ".
            "`user_avatar_height` = $scaled_height ".
            "WHERE `user_id` = $forum_user_id";
        $result_array[] = executeSQL($sql, $dbxForum);
        updateMemberForumRank($memberId, $dbx);

    } else {
        // If dismissed
        // registered user
        $sql = "INSERT INTO phpbb_user_group ".
            "(`group_id`, `user_id`, `group_leader`, `user_pending`) ".
            "VALUES (2, $forum_user_id, 0, 0)";
        $result_array[] = executeSQL($sql, $dbxForum);

        $sql = "UPDATE phpbb_users ".
            "SET ".
            "`group_id` = 2, ".
            "`user_colour` = '228B22', ".
            "`user_avatar` = '', ".
            "`user_avatar_type` = '', ".
            "`user_avatar_width` = 0, ".
            "`user_avatar_height` = 0 ".
            "WHERE `user_id` = $forum_user_id";
        $result_array[] = executeSQL($sql, $dbxForum);
        deleteMemberForumRank($memberId, $dbx);
    }

    echo (json_encode($result_array));


}

function synchronizeForumToCampaign($campaignId, $dbx){
    // This function adjust the forum groups and user avatars to correspond with the pam campaign

    $sql = "SELECT acg_unit_id, forum_group_id, acg_unit.name AS acg_unit_name, hist_unit.name AS hist_unit_name, ".
        "hist_unit.faction AS hist_unit_faction, hist_unit.image AS hist_unit_image ".
        "FROM deployed_unit ".
        "LEFT JOIN hist_unit ON deployed_unit.hist_unit_id = hist_unit.id ".
        "LEFT JOIN acg_unit ON deployed_unit.acg_unit_id = acg_unit.id ".
        "WHERE campaign_id = $campaignId";
    $query = mysqli_query($dbx, $sql);
    while($row = mysqli_fetch_array($query)){
//        if($row["acg_unit_id"] != NULL) echo var_dump($row);
        if($row["acg_unit_id"] != NULL) adjustForumGroup($row, $dbx);
    }

//    arrangeUnitForums($campaignId, $dbx);

    // Update ranks for each member
    $sql = "SELECT member_id FROM member_status_log_info ".
        "WHERE status_date_out IS NULL ".
        "AND (member_status = 0 OR member_status = 2 OR member_status = 3)";
    $query = mysqli_query($dbx, $sql);
    while($row = mysqli_fetch_array($query)){
        updateMemberForumRank($row['member_id'], $dbx);
    }
}

function adjustForumGroup($row, $dbx){

    //FOR DEVELOPMENT
    $image_filename = "http://localhost:8080".$row["hist_unit_image"];
    //FOR DEPLOYMENT
//    $image_filename = "../frontend/src".$row["hist_unit_image"];

    $avatar_target_width = 50;
    list($width, $height) = getimagesize($image_filename);
    $scaling_factor = $avatar_target_width/$width;
    $scaled_width = (int)($width*$scaling_factor);
    $scaled_height = (int)($height*$scaling_factor);

    $hist_unit_name = $row['hist_unit_name'];
    $acg_unit_name = $row['acg_unit_name'];
    $faction = $row['hist_unit_faction'];

    $forum_group_id = $row['forum_group_id'];

    if($faction == 2){
        // Allies - RAF
        $own_faction_group = 14;
        $opposing_faction_group = 15;
        $colour = '990000';
    } else if($faction == 3) {
        // Allies - VVS
        $own_faction_group = 14;
        $opposing_faction_group = 15;
        $colour = '990000';
    } else if($faction == 1) {
        // Axis - LW
        $own_faction_group = 15;
        $opposing_faction_group = 14;
        $colour = '000066';
    }
    // colours: Axis = 000066
    // colours: Allies = 990000

    $dbxForum = getForumDBx();
    $result_array = [];
    // Adjusting forum group
    $sql = "UPDATE phpbb_groups SET ".
        "`group_name` = '$hist_unit_name -- $acg_unit_name', ".
        "`group_desc` = '', ".
        "`group_colour` = '$colour', ".
        "`group_avatar` = '$image_filename', ".
        "`group_avatar_type` = 'avatar.driver.remote', ".
        "`group_avatar_width` = $scaled_width, ".
        "`group_avatar_height` = $scaled_height ".
        "WHERE `group_id` = $forum_group_id";
//    $result = mysqli_query($dbxForum, $sql);
    $result_array[] = executeSQL($sql, $dbxForum);

    // Adjust forum users avatar and colour
    $sql = "UPDATE phpbb_users SET ".
        "`user_colour` = '$colour', ".
        "`user_avatar` = '$image_filename', ".
        "`user_avatar_type` = 'avatar.driver.remote', ".
        "`user_avatar_width` = $scaled_width, ".
        "`user_avatar_height` = $scaled_height ".
        "WHERE `user_id` IN ".
        "(SELECT user_id FROM phpbb_user_group WHERE group_id = $forum_group_id)";
//    $result = mysqli_query($dbxForum, $sql);
    $result_array[] = executeSQL($sql, $dbxForum);

    // Adjust user faction groups
    // '14', 'Allies'
    // '15', 'Axis'
    $sql = "UPDATE phpbb_user_group` SET ".
        "`group_id` = $own_faction_group ".
        "WHERE `user_id` IN ".
        "(SELECT user_id FROM phpbb_user_group WHERE group_id = $forum_group_id) ".
        "AND group_id = $opposing_faction_group";
//    $result = mysqli_query($dbxForum, $sql);
    $result_array[] = executeSQL($sql, $dbxForum);
    echo (json_encode($result_array));
    mysqli_close($dbxForum);
}

function arrangeUnitForums($campaignId, $dbx){

}

function moveForumToArchive($forumId, $dbxForum){


}


function executeSQL($sql, $dbx_connection){

    $error_str = "";
    $affected_rows = "";
    if (mysqli_query($dbx_connection, $sql)) {
        $affected_rows = mysqli_affected_rows($dbx_connection);
    } else {
        $error_str = mysqli_error($dbx_connection);
    }
    $result_array = array('sql'=>$sql, 'affected_rows'=>$affected_rows, 'error'=>$error_str);
    return $result_array;

}
