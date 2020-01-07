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