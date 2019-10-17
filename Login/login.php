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
        <form>
        <div class="form-group">
            <div class="form-inputs">
                <label for="input_usuario">Email</label>
                <input type="email" class="form-control" id="input_usuario" placeholder="ejemplo@correo.com">
            </div>
            <div class="form-inputs">
                <label for="input_contraseña">Contrasña</label>
                <input type="password" class="form-control" id="input_contraseña" placeholder="ejemplo123">
            </div>
        </div>
            <a href="../menu.php" class="btn btn-success">Iniciar Sesion</a>
        </form>
    </div>
</body>
</html>