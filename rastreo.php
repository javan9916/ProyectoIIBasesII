<?php //require_once 'mapa/mapa.php'; ?>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Rastreo</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
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
            <input type="submit" name="submit" value="Ingresar">
        </form>
    </div>
    
</body>
</html>