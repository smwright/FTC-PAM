<?php
/**
 * Created by IntelliJ IDEA.
 * User: rafaelg
 * Date: 06/01/20
 * Time: 21:44
 */

include_once(dirname(__FILE__).'/dbx.php');

// Getting info from phpBB forum session
define('IN_PHPBB', true);
$phpbb_root_path = (defined('PHPBB_ROOT_PATH')) ? PHPBB_ROOT_PATH : dirname(dirname(__FILE__)).'/forum/';
$phpEx = substr(strrchr(__FILE__, '.'), 1);
include($phpbb_root_path . 'common.' . $phpEx);
$request->enable_super_globals();
// Start session management
$user->session_begin();
$auth->acl($user->data);
$user->setup();

//define('IN_PHPBB', true);
//$phpbb_root_path = (defined('PHPBB_ROOT_PATH')) ? PHPBB_ROOT_PATH : dirname(dirname(__FILE__)).'/forum/';
//$phpEx = substr(strrchr(__FILE__, '.'), 1);
global $phpbb_root_path, $phpEx;
include($phpbb_root_path . 'includes/functions_user.' . $phpEx);
$user->add_lang('acp/groups');

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
    updateMemberForumGroups($memberId, $dbx);
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

function updateMemberForumGroups($memberId, $dbx) {
    // This function adjusts the forum groups of the member to the current unit in the pam.

    $groups_to_be_in = array();
    $groups_to_not_be_in = array();

    $registered = 2;
    $newly_registered = 7;
    $acg_member = 36;
    $allies = 14;
    $axis = 15;

    $unit_forum_groups = array();
    $sql = "SELECT forum_group_id FROM acg_unit WHERE forum_group_id IS NOT NULL";
    $query = mysqli_query($dbx, $sql);
    while($row = mysqli_fetch_array($query)){
        $unit_forum_groups[] = (int)$row['forum_group_id'];
    }

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
    $user_unit_forum_group = (int)$result["forum_group_id"];
    $faction = $result["faction"];
//    //FOR DEVELOPMENT
    $image_filename = dirname(dirname(__FILE__)).$result["hist_unit_image"];
//    FOR DEPLOYMENT
//    $image_filename = "../frontend/src".$result["hist_unit_image"];

    $avatar_target_width = 50;
    list($width, $height) = getimagesize($image_filename);
    $image_info = getimagesize($image_filename);
    $scaling_factor = $avatar_target_width/$width;
    $scaled_width = (int)($width*$scaling_factor);
    $scaled_height = (int)($height*$scaling_factor);
    $image_filename = "http://aircombatgroup.co.uk".$result["hist_unit_image"];

    //Connect to forum database and get forum user_id of username.
    $dbxForum = getForumDBx();
    $sql = "SELECT phpbb_users.user_id FROM phpbb_users ".
        "WHERE phpbb_users.username_clean = '$username'";
    $query = mysqli_query($dbxForum, $sql);
    $result = mysqli_fetch_assoc($query);
    $forum_user_id = (int)$result["user_id"];

    $user_forum_groups = array();
    $sql = "SELECT group_id FROM phpbb_user_group ".
        "WHERE user_id = $forum_user_id";
    $query = mysqli_query($dbxForum, $sql);
    while($row = mysqli_fetch_array($query)){
        $user_forum_groups[] = (int)$row['group_id'];
    }

    // If active or on leave
    if($member_status != 1){

        // Faction group
        if($faction == 2){
            // Allies - RAF
            $own_faction_group = array(14);
            $opp_faction_group = array(15);
        } else if($faction == 3) {
            // Allies - VVS
            $own_faction_group = array(14);
            $opp_faction_group = array(15);
        } else if($faction == 1) {
            // Axis - LW
            $opp_faction_group = array(14);
            $own_faction_group = array(15);
        } else {
            // RESERVE UNITS
            if($user_unit_forum_group == 61){
                $own_faction_group = array(14);
                $opp_faction_group = array(15);
            } else if($user_unit_forum_group == 62){
                $opp_faction_group = array(14);
                $own_faction_group = array(15);
            } else {
                $own_faction_group = array();
                $opp_faction_group = array(14, 15);
            }
        }


        $groups_to_be_in = array($acg_member);
        if($user_unit_forum_group) array_push($groups_to_be_in, $user_unit_forum_group);
        $groups_to_be_in = array_merge($groups_to_be_in, $own_faction_group);

        $groups_to_not_be_in = array($registered, $newly_registered);
        $groups_to_not_be_in = array_merge($groups_to_not_be_in, $opp_faction_group);

        $unit_forum_groups_to_not_be_in = array_diff($unit_forum_groups, array($user_unit_forum_group));
        $groups_to_not_be_in = array_merge($groups_to_not_be_in, $unit_forum_groups_to_not_be_in);

        $groups_to_be_added = array_diff($groups_to_be_in, $user_forum_groups);
        $groups_to_be_removed = array_intersect($user_forum_groups, $groups_to_not_be_in);

        foreach ($groups_to_be_removed as $group_id) {
            echo "Removing $forum_user_id (".gettype($forum_user_id).") from group $group_id (".gettype($forum_user_id).") ";
            $result = group_user_del($group_id, array($forum_user_id));
            if(!$result){
                echo "Done ";
            } else {
                var_dump($result);
            }
        }

        foreach ($groups_to_be_added as $group_id) {
            echo "Adding $forum_user_id (".gettype($forum_user_id).") to group $group_id (".gettype($forum_user_id).") ";
            $result = group_user_add($group_id, array($forum_user_id), false, false, false);
            if(!$result){
                echo "Done ";
            } else {
                var_dump($result);
            }
        }


        group_set_user_default($user_unit_forum_group, array($forum_user_id));
        $sql = "UPDATE phpbb_users ".
            "SET ".
            "`user_avatar` = '$image_filename', ".
            "`user_avatar_type` = 'avatar.driver.remote', ".
            "`user_avatar_width` = $scaled_width, ".
            "`user_avatar_height` = $scaled_height ".
            "WHERE `user_id` = $forum_user_id";
        executeSQL($sql, $dbxForum);
        updateMemberForumRank($memberId, $dbx);

    } else {
        // If dismissed

        $groups_to_be_in = array($registered);
        $groups_to_not_be_in = array($newly_registered, $acg_member, $allies, $axis);
        $groups_to_not_be_in = array_merge($groups_to_not_be_in, $unit_forum_groups);

        $groups_to_be_added = array_diff($groups_to_be_in, $user_forum_groups);
        $groups_to_be_removed = array_intersect($user_forum_groups, $groups_to_not_be_in);

        foreach ($groups_to_be_added as $group_id) {
            echo "Adding $forum_user_id (".gettype($forum_user_id).") to group $group_id (".gettype($forum_user_id).") ";
            $result = group_user_add($group_id, array($forum_user_id), false, false, false);
            if(!$result){
                echo "Done ";
            } else {
                var_dump($result);
            }
        }

        foreach ($groups_to_be_removed as $group_id) {
            echo "Removing $forum_user_id (".gettype($forum_user_id).") from group $group_id (".gettype($forum_user_id).") ";
            $result = group_user_del($group_id, array($forum_user_id));
            if(!$result){
                echo "Done ";
            } else {
                var_dump($result);
            }
        }
        group_set_user_default($registered, array($forum_user_id));
        $sql = "UPDATE phpbb_users ".
            "SET ".
            "`user_avatar` = '', ".
            "`user_avatar_type` = '', ".
            "`user_avatar_width` = 0, ".
            "`user_avatar_height` = 0 ".
            "WHERE `user_id` = $forum_user_id";
        $result_array[] = executeSQL($sql, $dbxForum);

        $sql = "UPDATE phpbb_topics SET ".
            "`topic_first_poster_colour` = '228B22' ".
            "WHERE `topic_poster` = $forum_user_id";
        $result_array[] = executeSQL($sql, $dbxForum);

        $sql = "UPDATE phpbb_topics SET ".
            "`topic_last_poster_colour` = '228B22' ".
            "WHERE `topic_last_poster_id` = $forum_user_id";
        $result_array[] = executeSQL($sql, $dbxForum);

        deleteMemberForumRank($memberId, $dbx);
    }

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
//    $image_filename = "http://localhost:8080".$row["hist_unit_image"];
    //FOR DEPLOYMENT
    $image_filename = "../frontend/src".$row["hist_unit_image"];

    $avatar_target_width = 50;
    list($width, $height) = getimagesize($image_filename_sizecheck);
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

    $result = [];
    $sql = "SELECT user_id FROM phpbb_user_group WHERE group_id = $forum_group_id";
    $query = mysqli_query($dbxForum, $sql);
    while($row = mysqli_fetch_array($query)){
        $result[] = (int)$row['user_id'];
    }
    $unit_forum_user_id = implode (", ", $result);

    $sql = "UPDATE phpbb_user_group SET ".
        "`group_id` = $own_faction_group ".
        "WHERE `user_id` IN ($unit_forum_user_id)".
        "(SELECT user_id FROM phpbb_user_group WHERE group_id = $forum_group_id) ".
        "AND group_id = $opposing_faction_group";
//    $result = mysqli_query($dbxForum, $sql);
    $result_array[] = executeSQL($sql, $dbxForum);

    $sql = "UPDATE phpbb_topics SET ".
        "`topic_first_poster_colour` = '$colour' ".
        "WHERE `topic_poster` IN ".
        "(SELECT user_id FROM phpbb_user_group WHERE group_id = $forum_group_id) ";
    $result_array[] = executeSQL($sql, $dbxForum);

    $sql = "UPDATE phpbb_topics SET ".
        "`topic_last_poster_colour` = '$colour' ".
        "WHERE `topic_last_poster_id` IN ".
        "(SELECT user_id FROM phpbb_user_group WHERE group_id = $forum_group_id) ";
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
