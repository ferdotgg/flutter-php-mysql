<?php

    require "conexion.php";

    $sql = "select pe.idPedido, pe.pagado, pr.nombre, pr.precio, pe.cantidad from pedidos pe inner join productos pr on pe.idProducto = pr.idProducto where pe.pagado = 'n'";

    $query = $mysqli->query($sql);

    $datos = array();

    while($resultado = $query->fetch_assoc()) {
        $datos[] = $resultado;
    }

    echo json_encode($datos);
    //echo json_encode(array($datos));
?>
