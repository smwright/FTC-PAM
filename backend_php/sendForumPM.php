<?php
/**
 * Created by IntelliJ IDEA.
 * User: rafaelg
 * Date: 08/06/19
 * Time: 00:14
 */

include_once(dirname(__FILE__).'/dbx.php');
include_once(dirname(__FILE__)."phpbbx.php");
//$phpbb_root_path = (defined('PHPBB_ROOT_PATH')) ? PHPBB_ROOT_PATH : dirname(dirname(dirname(__FILE__))).'/forum/';
//$phpEx = substr(strrchr(__FILE__, '.'), 1);

$params = json_decode( file_get_contents( 'php://input' ), true );
echo "sendForumPM.php received -> ".$params["message"];


// NEED TO WRITE ROUTINES TO SEND MESSAGE!!!

function getForumUserIdFromID($memberId){

    $dbx = getDBx();
    $sql = "SELECT acg_member.username FROM acg_member ".
        "WHERE acg_member.id = $memberId";
    $query = mysqli_query($dbx, $sql);
    $result = mysqli_fetch_assoc($query);
    $username = strtolower($result["username"]);

    //Connect to forum database and get forum user_id of username.
    $dbxForum = getForumDBx();
    $sql = "SELECT phpbb_users.user_id FROM phpbb_users ".
        "WHERE phpbb_users.username_clean = '$username'";
    $query = mysqli_query($dbxForum, $sql);
    $result = mysqli_fetch_assoc($query);
    return $result["user_id"];
}

function sendphpbbpm_fromID($pmmessage, $pamuserid_sender, $pamuserid_receiver, $pmsubject) {

    $dbx = getDBx();
    $sql = "SELECT acg_member.username FROM acg_member ".
        "WHERE acg_member.id = $pamuserid_sender";

    $query = mysqli_query($dbx, $sql);
    $result = mysqli_fetch_assoc($query);
    $username_sender = strtolower($result["username"]);

    define('IN_PHPBB', true);
    include_once(dirname(dirname(dirname(__FILE__))).'/forum/includes/functions_privmsgs.php');
//    include_once(dirname(dirname(dirname(__FILE__))).'/forum/includes/functions_content.php');
//    include_once(dirname(dirname(dirname(__FILE__))).'/forum/includes/utf/utf_tools.php');

    $userid_sender = getForumUserIdFromID($pamuserid_sender);
    $userid_receiver = getForumUserIdFromID($pamuserid_receiver);

    $message = utf8_normalize_nfc($pmmessage);
    $uid = $bitfield = $options = ''; // will be modified by generate_text_for_storage
    $allow_bbcode = $allow_smilies = true;
    $allow_urls = true;


//    $result = generate_text_for_storage($message, $uid, $bitfield, $options, $allow_bbcode, $allow_urls, $allow_smilies);

    $pm_data = array(
        'from_user_id'       => $userid_sender,
        'from_user_ip'       => "127.0.0.1",
        'from_username'      => $username_sender,
        'enable_sig'         => true,
        'enable_bbcode'      => false,
        'enable_smilies'     => false,
        'enable_urls'        => true,
        'icon_id'            => 0,
        'bbcode_bitfield'    => $bitfield,
        'bbcode_uid'         => $uid,
        'message'            => $message,
        'address_list'       => array('u' => array($userid_receiver => 'to')),
    );

    //Now We Have All Data Lets Send The PM!!
    submit_pm('post', $pmsubject, $pm_data, false, false);

}