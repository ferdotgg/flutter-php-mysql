<?php

    require "conexion.php";

    $idPedido = $_POST['idPedido'];

    $sql = "DELETE FROM pedidos WHERE idPedido='$idPedido'";
    $query = $mysqli->query($sql);

?>
