<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Mapa</title>
    <link rel="stylesheet" href="../leaflet/leaflet.css" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css"> 
    <link rel="stylesheet" href="mapa.css"> 
    <script src="../leaflet/leaflet.js"></script>
    <script src="geojson.js"></script>
    <script src="mapa.js"></script>
    <style>
        #mapid { height: 100vh; }
        body {margin: 0px;}
        #log{
            overflow: auto;
            height: 100vh;
            width:100vh;
            position: static;}
        #controles{
            visibility: hidden;
            display: none;
            height: 20vh;
            width:100vw;
            position: relative;
            padding: 5px;
            text-align: center;}
        #controles div{
            border: 0px solid red;
            border-radius: 15px;
            display: none;
            margin: 0;
            width: 45vw;
            height: 100%;
            opacity: 0.5;}
        #controles div:first-child{background-color: chartreuse;}
        #controles div:last-child{background-color: crimson;}
    </style>
</head>
<?php
    //Obterner las variable
    $tipo;
    $usuario;
    $vehiculo;
    $tipo=$_POST['tipo'];
    $usuario=$_POST['usuario'];
    $vehiculo=$_POST['ruta'];
    // Mostar las variables
    echo " Tipo: $tipo";
    echo " Nombre: $usuario";
    echo " Vehiculo: $vehiculo";
?>

<script type="text/javascript">
var tipo = "<?php echo $tipo ?>"; 
var usuario = "<?php echo $usuario ?>";
var vehiculo = "<?php echo $vehiculo ?>";
</script>

<body onload='mapa(tipo,usuario,vehiculo)'>

    <nav class="navbar navbar-inverse">  
    <div class="container-fluid">  
        <div class="navbar-header">  
        <a class="navbar-brand">Rastreo</a>  
        </div>  
        <ul class="nav navbar-nav">  
        <li class="active"><a href="../index.php">Menu Principal</a></li>  
        <li class="active"><a href="../rastreo.php">Volver a rastreo</a></li>
        </ul>  
    </div>  
    </nav>  

    <div id="controles">
        <div id="iniciar" onclick="iniciar_indicaciones()">Iniciar</div>
        <div id="terminar" onclick="terminar_indicaciones()">Terminar</div>
    </div>
    <div id="mapid"></div>
    <!-- <div id="log" onclick="repetir_indicaciones()"></div> -->
</body>
</html>