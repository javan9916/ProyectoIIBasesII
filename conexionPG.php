<?php
    echo 'Current PHP version: ' . phpversion();

    if (isset($_POST['submit'])) {
        $host="host=localhost";
        $port="port=5432";
        $dbname="dbname='$_POST[tipo]'";
        $user="user=postgres";
        $password="password=12345";

        $db = pg_connect("$host $port $dbname $user $password");

        if (!$db){
            echo "Error: ".pg_last_error; 
        } else {
            //$query = "SELECT agregar_rastreo('$_POST[ruta]', '$_POST[tipo]', '$_POST[usuario]');"
            /*$result = pg_query($db, $query);
            if (!$result) {
                echo "Error".pg_last_error;
            } else {
                echo "Dato ingresado";
            }*/
        }
    }
?>