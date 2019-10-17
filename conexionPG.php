<?php
    function connectPG(){
        $host="host=localhost";
        $port="port=5432";
        $dbname="dbname=Transporte";
        $user="user=postgres";
        $password="password=2018100294";

        $db = pg_connect("$host $port $dbname $user $password");

        if (!$db){
            echo "Error: " .pg_last_error;
        } else {
            echo "Conexion exitosa";
            return $db;
        }
    }
?>