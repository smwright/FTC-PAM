<?php
/**
 * Created by IntelliJ IDEA.
 * User: rafaelg
 * Date: 19/04/20
 * Time: 12:12
 */


    $result_string = "";
    $error_str = "";
    ini_set('display_errors',1);


    if (is_uploaded_file($_FILES['file']['tmp_name'])) {


        //DEVELOPMENT ONLY !!!! ADJUST PROD UPLOADDIR BEFORE DEPLOYMENT !!!
        $uploaddir = dirname(dirname(__FILE__))."/frontend/src";
        $uploadfile = $_POST['path']. basename($_FILES['file']['name']);
        $targert = $uploaddir . $uploadfile ;

        if (move_uploaded_file($_FILES['file']['tmp_name'], $targert)) {
            $result_string = "File ".basename($_FILES['file']['name'])." is valid, and was successfully uploaded.";
        } else {
            $error_str = "Possible file upload attack!";
            $error_str .= "filename '". $_FILES['file']['tmp_name'] . "'.";
        }

    } else {
        $error_str = "Possible file upload attack: ";
        $error_str .= "filename '". $_FILES['file']['tmp_name'] . "'.";
    }

    $result_array = array('message'=>$result_string, 'error'=>$error_str, 'path'=>$uploadfile);
    echo (json_encode($result_array));
    exit();
