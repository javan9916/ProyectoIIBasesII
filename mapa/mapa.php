<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Mapa</title>
    <link rel="stylesheet" href="../leaflet/leaflet.css" />
    <script src="../leaflet/leaflet.js"></script>
    <script src="geojson.js"></script>
    <script src="mapa.js"></script>
    <style>
        #mapid 
        { 
            height: 100vh; 
        }
        body 
        {
            margin: 0px;
        }
        #log
        {
            overflow: auto;
            height: 100vh;
            width:100vh;
            position: static;
        }
        #controles
        {
            visibility: hidden;
            display: none;

            height: 20vh;
            width:100vw;
            position: relative;
            padding: 5px;
            text-align: center;
        }
        #controles div
        {
            border: 0px solid red;
            border-radius: 15px;
            display: none;
            margin: 0;
            width: 45vw;
            height: 100%;
            opacity: 0.5;
        }
        #controles div:first-child
        {
            background-color: chartreuse;
        }

        #controles div:last-child
        {
            background-color: crimson;
        }

    </style>
</head>
<body onload="mapa()">
    <div id="controles">
        <div id="iniciar" onclick="iniciar_indicaciones()">Iniciar</div>
        <div id="terminar" onclick="terminar_indicaciones()">Terminar</div>
    </div>
    <div id="mapid"></div>
    <!-- <div id="log" onclick="repetir_indicaciones()"></div> -->
</body>
</html>