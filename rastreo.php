<?php //require_once 'mapa/mapa.php'; ?>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Rastreo</title>
    <link rel="stylesheet" href="styles.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
</head>
<body>
    <nav class="navbar navbar-inverse">  
        <div class="container-fluid">  
            <div class="navbar-header">  
            </div>  
            <ul class="nav navbar-nav">   
            <li class="active"><a href="index.php">Volver</a></li>
            </ul>  
        </div>  
    </nav>
    <div class="form">
        <div class="form-heading"><h1>Datos para el rastreo</h1></div>
        <form action="mapa/mapa.php" method="POST">
            <label>Nombre ruta: </label>
            <input name="ruta" class="form-input">
            <label>Tipo de vehiculo: </label>
            <select name="tipo" class="form-select">
                <option value="Bus">Bus</option>
                <option value="Taxi">Taxi</option>
                <option value="Tren">Tren</option>
            </select>
            <label>Usuario: </label>
            <input name="usuario" class="form-input">
            <br>
            <button type="submit" class="btn btn-primary">Consultar</button>
        </form>
    </div>
    
</body>
</html>