<?php

function execCRUD($sql) {
    //   $mysqli = new mysqli("localhost", "cl45-acg-pam", "V^hjGnK-f", "cl45-acg-pam");
     $mysqli = new mysqli("localhost", "thaine", "", "c9");
    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }
    
    $out = array('error' => false);
 
    $crud = 'read';
 
    if(isset($_GET['crud'])){
    	$crud = $_GET['crud'];
    }
    
    if($crud = 'read'){
    	$query = $conn->query($sql);
    	$result = array();
     
    	while($row = $query->fetch_array()){
    		array_push($result, $row);
    	}
    }
 
 
    $conn->close();
     
    header("Content-type: application/json");
    echo json_encode($result);
    die();
}



 
 
