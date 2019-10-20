<!DOCTYPE html>
<html lang="en">
<head>
    <title>Login</title>
    <link rel="stylesheet" href="login.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />
</head>
<body onload="main()">
    <div class="form">
        <div class="form-heading"><h1>Inicio Sesion</h1></div>
        <form action="mapa/mapa.php" method="POST">
        <div class="form-group">
            <div class="form-inputs">
                <label for="input_usuario">Usuario</label>
                <input type="user" class="form-control" id="user" placeholder="usuario">
            </div>
        </div>
            <a href="../menu.php" class="btn btn-success">Iniciar Sesion</a>
        </form>
    </div>

    <?php
        $user = $_POST['user'];
        $query = "select verificar_usuario($user)";
        $resultado = pg_query();
        
    ?>
</body>
</html>