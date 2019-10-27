<?php
$vehiculo=$_GET["vehiculo"];
$usuario=$_GET["usuario"];
$x=$_GET["x"];
$y=$_GET["y"];
$tipo=$_GET["tipo"];


$sql="select agregar_ruta('$tipo','$usuario','$vehiculo',$y,$x);";  
$con = pg_connect("host=localhost port=5432 dbname='$tipo' user=postgres password=12345");
$result=pg_query($con,$sql);
//RECUERDEN CAMBIAR LOS DATOS DEL SERVIDOR Y PUERTO AQUI