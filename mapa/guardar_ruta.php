<?php
$bus=$_GET["vehiculo"];
$usuario=$_GET["usuario"];
$x=$_GET["x"];
$y=$_GET["y"];
$y=$_GET["tipo"];
$y=$_GET["database"];
$y=$_GET["puerto"];
$y=$_GET["usuariodb"];
$y=$_GET["password"];


$sql="insert into '$tipo'(bus,usuario,geom) values ('$bus','$usuario',ST_SetSRID(ST_MakePoint($y,$x),4326));";  
$con = pg_connect("host=localhost port='$puerto' dbname='$database' user='$usuariodb' password='$password'");
$result=pg_query($con,$sql);
