<?php
    //Obterner las variable
    $usuario;
    $vehiculo;
    $fechaI;
    $fechaF;
    if (isset($_POST['submit'])) {
        $usuario=$_POST['usuario'];
        $vehiculo=$_POST['ruta'];
        $fechaI=$_POST['fechaI'];
        $fechaF=$_POST['fechaF'];}
    // Mostar las variables
    echo " Nombre: $usuario";
    echo " Vehiculo: $vehiculo";
?>