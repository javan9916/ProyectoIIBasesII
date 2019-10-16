<!DOCTYPE html>
<html lang="en">
<head>
    <title>Bases de datos II</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <?php require_once 'connectPG.php';?>
    <div class="form">
        <div class="form-heading"><h1>Base de datos distribuida para rastreo</h1></div>
        <div class="form-heading"><h1>de servicios públicos de transporte</h1></div>
        <form action="connectPG.php" method="POST">
            <label>Vehiculo: </label>
            <input name="vehiculo" class="form-input">
            <label>Tipo de vehiculo: </label>
            <select name="tipo" class="form-select">
                <option value="bus">Bus</option>
                <option value="taxi">Taxi</option>
                <option value="tren">Tren</option>
            </select>
            <label>Usuario: </label>
            <input name="usuario" class="form-input">
            <br>
            <input type="submit" name="submit" value="Ingresar">
        </form>
    </div>
    
</body>
</html>