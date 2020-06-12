<?php

require "conexion.php";

if (isset($_POST['idProducto'])) {
    $idProducto = $_POST['idProducto'];
    echo $idProducto;
} else {
    $idProducto = null;
}

if (isset($_POST['cantidad'])) {
    $Cantidad = $_POST['cantidad'];
    echo $Cantidad;
} else {
    $Cantidad = null;
}

$sql = "INSERT INTO pedidos(cantidad, pagado, idProducto) VALUES('$Cantidad', 'n', '$idProducto')";

$query = $mysqli->query($sql);

?>