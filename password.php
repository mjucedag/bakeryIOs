<?php
//insertar login y password codificado en la tabla member

//$link = mysqli_connect("sql203.byethost7.com", "b7_10356956", "*****");
function insertMember($user,$password){
    $encodedPassword = password_hash($password, PASSWORD_DEFAULT);
    mysqli_query($link, "INSERT INTO member VALUES (default, '".$user."', '".$encodedPassword."')");
}
insertMember("pepe","pepe");
insertMember("ana","ana");
insertMember("juan","juan");

?>