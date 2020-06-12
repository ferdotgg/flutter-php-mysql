<?php
    require "conexion.php";
    $sql = "UPDATE pedidos SET pagado = (case when pagado = 'n' then 's' end) WHERE pagado in ('n')";
    $query = $mysqli->query($sql);
    echo json_encode($query);
?>
