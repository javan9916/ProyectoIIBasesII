<?php
    function connectPG(){
        $host="host=localhost";
        $port="port=5433";
        $dbname="dbname=Bus";
        $user="user=postgres";
        $password="password=24604763";

        $db = pg_connect("$host $port $dbname $user $password");

        if (!$db){
            echo "Error: " .pg_last_error;
        } else {
            echo "Conexion exitosa";
            return $db;
        }
    }
?>