<?php
/**
 * Created by IntelliJ IDEA.
 * User: rafaelg
 * Date: 9/12/18
 * Time: 9:42 AM
 */

function getDBx () {
    $servername = "localhost";
    $username = "root";
    $password = "root";
    $database = "pam";

    // Create connection
    $conn = mysqli_connect($servername, $username, $password, $database);

    // Check connection
    if (!$conn) {
        die("Connection failed: " . mysqli_connect_error());
    } else {
        return $conn;
    }
}
