<?php

    require "conexion.php";

    $usuario = $_POST['usuario'];
    $password = $_POST['password'];

    $sql = "SELECT * FROM usuarios WHERE usuario='$usuario' AND password='$password'";
    $query = $mysqli->query($sql);

    if($query->num_rows > 0) {
        echo "CORRECTO";
    } else {
        echo "ERROR";
    }

?>