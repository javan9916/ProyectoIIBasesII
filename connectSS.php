<?php

$serverName = "localhost"; //serverName\instanceName
$connectionInfo = array( "Database"=>"prueba", "UID"=>"sa", "PWD"=>"2018107560", "CharacterSet"=>"UTF-8");
$conn = sqlsrv_connect($serverName, $connectionInfo);

if( $conn ) {
    // Hacer las consultas o inserciones en los servidores
     echo "Conexión establecida.<br />";
} else {
     echo "Conexión no se pudo establecer.<br />";
     die( print_r( sqlsrv_errors(), true));
}

?>