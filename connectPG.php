<?php

if ($_POST["tipo"] == Tren) {

}

$conn_string = "host=localhost port=5432 dbname=$tipo user=postgres password=12345";
$dbconn = pg_connect($conn_string);

if(!$dbconn) {
    echo "Error: No se ha podido conectar a la base de datos\n";
} else {
    $result = pg_query($dbconn, "INSERT INTO trenes (ruta) VALUES (""))") 
    echo "Conexión exitosa\n";
}

pg_close($dbconn);

?>