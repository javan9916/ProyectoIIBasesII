<?php
    //Obtener las variable
    $usuario;
    $vehiculo;
    $fechaI;
    $fechaF;
    function obtenerFechas() {
        if (isset($_POST['submit'])) {
            $fechaI=$_POST['fechaI'];
            $fechaF=$_POST['fechaF'];
        }
        echo " Fecha I: $fechaI";
        echo " Fecha F: $fechaF";
    }
    // Mostrar las variables
    
?>