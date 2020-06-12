<?php

    require "conexion.php";

    $idPedido = $_POST['idPedido'];
    $cantidad = $_POST['cantidad'];

    $sql = "UPDATE pedidos SET cantidad='$cantidad' WHERE idPedido='$idPedido'";

    $query = $mysqli->query($sql);

    echo($query);

?>