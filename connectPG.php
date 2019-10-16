<?php

$conn_string = "host=localhost port=5432 dbname=test user=postgres password=12345";
$dbconn = pg_connect($conn_string);

if(!$dbconn) {
    // Hacer las consultas o inserciones en los servidores
    echo "Error: No se ha podido conectar a la base de datos\n";
} else {
    echo "Conexión exitosa\n";
}

pg_close($dbconn);

?>