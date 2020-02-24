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
    $result = mysqli_query($dbxForum, $sql);

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
    $image_filename = "../frontend/src".$row["hist_unit_image"];
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

    if($faction > 1){
        // Allies
        $own_faction_group = 14;
        $opposing_faction_group = 15;
        $colour = '990000';
    } else {
        // Axis
        $own_faction_group = 15;
        $opposing_faction_group = 14;
        $colour = '000066';
    }
    // colours: Axis = 000066
    // colours: Allies = 990000

    $dbxForum = getForumDBx();
    // Adjusting forum group
    $sql = "UPDATE phpbb_groups SET ".
        "`group_name` = '$hist_unit_name -- $acg_unit_name', ".
        "`group_desc` = '', ".
        "`group_colour` = $colour, ".
        "`group_avatar` = '$image_filename', ".
        "`group_avatar_type` = 'avatar.driver.remote', ".
        "`group_avatar_width` = $scaled_width, ".
        "`group_avatar_height` = $scaled_height ".
        "WHERE `group_id` = $forum_group_id";
    $result = mysqli_query($dbxForum, $sql);

    // Adjust forum users avatar and colour
    $sql = "UPDATE phpbb_users SET ".
        "`user_colour` = $colour, ".
        "`user_avatar` = '$image_filename', ".
        "`user_avatar_type` = 'avatar.driver.remote', ".
        "`user_avatar_width` = $scaled_width, ".
        "`user_avatar_height` = $scaled_height ".
        "WHERE `user_id` IN ".
        "(SELECT user_id FROM phpbb_user_group WHERE group_id = $forum_group_id)";
    $result = mysqli_query($dbxForum, $sql);

    // Adjust user faction groups
    // '14', 'Allies'
    // '15', 'Axis'
    $sql = "UPDATE phpbb_user_group` SET ".
        "`group_id` = $own_faction_group ".
        "WHERE `user_id` IN ".
        "(SELECT user_id FROM phpbb_user_group WHERE group_id = $forum_group_id) ".
        "AND group_id = $opposing_faction_group";
    $result = mysqli_query($dbxForum, $sql);

}

