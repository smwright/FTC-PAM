<?php
include_once(dirname(__FILE__).'/dbx.php');

//Set true if developing.
$dev = true;
$dev_user = "Ben";

if(!$dev){
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
}


$params = json_decode( file_get_contents( 'php://input' ), true );
//echo("USER: ".$user->data['username_clean']);

switch ($params['action']){
    case 'syncSession':
        getForumSessionInfo($user);
        break;
    default:
        header('HTTP/1.1 403 Forbidden');
        echo("Action not listed: ".filter_input(INPUT_POST, 'action'));

}

 function getForumSessionInfo($user) {
 /* *****************************************************************************
     Login via phpBB forum. Code from:
     http://www.3cc.org/blog/2010/03/integrating-your-existing-site-into-phpbb3/
     I hope this will work but have no chance to test it on my system.
   *****************************************************************************
  */

    global $dev, $dev_user;

    $res_array['username'] = 'Visitor';
    $res_array['userID'] = 0;
    $res_array['callsign'] = 'Visitor';
    $res_array['admin'] = FALSE;

    if($dev){
        if($dev_user != 'Visitor'){
            $username = $dev_user;
        }
    } else {
//        include_once(dirname(dirname(__FILE__)).'/phpbbx.php');
        $username = $user->data['username_clean'];
    }

    if($username != 'anonymous'){
        $newUserInfo = getUserInfo($username);
        if($newUserInfo != null){
            $res_array['username'] = $newUserInfo['username'];
            $res_array['userID'] = $newUserInfo['member_id'];
            $res_array['callsign'] = $newUserInfo['callsign'];
            if($newUserInfo['member_status'] == 0){
               $res_array['admin'] = $newUserInfo['admin'];
            } else {
               $res_array['admin'] = 0;
            }

        }
    }
    echo(json_encode($res_array,JSON_NUMERIC_CHECK));
    exit;
}

function getUserInfo($username) {


    $dbx = getDBx();
    $sql = "SELECT member_id, username, callsign, admin, member_status FROM member_info_with_last_status WHERE username = '$username'";
    $result = mysqli_query($dbx, $sql);
    if (mysqli_num_rows($result)>0) {
        $res_array = mysqli_fetch_all($result, MYSQLI_ASSOC);
    } else {
        $res_array = null;
    }
    mysqli_close($dbx);
    return $res_array[0];
}