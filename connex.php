<?php

$host = "localhost";
$username = "root";
$password = "a48b59!";
$database = "r2d4_muta2";
$port = "3306";

// Creation de la connection
$conn = mysqli_connect($host, $username, $password, $database, $port);

// Verification de la connection
if (mysqli_connect_errno()){
 // echo "Echec de la connection " . mysqli_connect_error();
  }else{
//	 echo "Connection avec succes ";
  }
  


?> 
