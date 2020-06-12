<?php

    require "conexion.php";

    $sql = "select pr.idProducto, pr.nombre as NombreProducto, pr.precio, cat.nombre as NombreCategoria from productos pr inner join categorias cat on pr.idCategoria = cat.idCategoria order by cat.idCategoria";

    $query = $mysqli->query($sql);

    $datos = array();

    while($resultado = $query->fetch_assoc()) {
        $datos[] = $resultado;
    }

    echo json_encode($datos);
    //echo json_encode(array($datos));
?>
