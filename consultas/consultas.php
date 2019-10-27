<!DOCTYPE html>
<html lang="en">
<head>
    <title>Consultas</title>
    <link rel="stylesheet" href="consulta.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" 
          integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" 
          crossorigin="anonymous">
</head>
<body>
<nav class="navbar navbar-dark bg-dark">>
  <a class="navbar-brand" href="../index.php">
    Volver
  </a>
</nav>
<div class="card ">
    <div class="card margin">
        <form action="consultas1.php" method="POST">
            <div class="card-body">
                <h5 class="card-title">Promedio de distancia diaria recorrida por un Bus.</h5>
                <div class="form-group col-mb-16">
                    <a class="card-subtitle mb-2 text-muted">Fecha inicio: </a> 
                    <input type="date" id="start" name="trip-start"
                        value="2019-10-26"
                        min="1999-01-01" max="2020-12-31">
                    <a class="card-subtitle mb-2 text-muted">Fecha final: </a> 
                    <input type="date" id="start" name="trip-start"
                        value="2019-10-26"
                        min="1999-01-01" max="2020-12-31">
                </div>
                <div class="form-row">
                    <div class="form-group col-md-6">
                        <input name="usuario" class="form-control" id="usuario" placeholder="Nombre de Usuario">
                    </div>

                    <div class="form-group col-md-6">
                        <input name="ruta" class="form-control" id="ruta" placeholder="Nombre de Ruta">
                    </div>
                </div>
                <div class="col-mb-12">
                    <button href="#" type="submit" class="btn btn-primary consultar" onclick="iniciar_indicaciones()" >Consultar</button>
                </div>
            </div>
        </form>
    </div>

    <div class="card margin">
        <form action="consultas1.php" method="POST">
            <div class="card-body">
                <h5 class="card-title">Usuarios con mayor número de rastreos.</h5>
                <div class="form-group col-mb-16">
                    <a class="card-subtitle mb-2 text-muted">Fecha inicio: </a> 
                    <input type="date" id="start" name="trip-start"
                        value="2019-10-26"
                        min="1999-01-01" max="2020-12-31">
                    <a class="card-subtitle mb-2 text-muted">Fecha final: </a> 
                    <input type="date" id="start" name="trip-start"
                        value="2019-10-26"
                        min="1999-01-01" max="2020-12-31">
                </div>
                <div class="col-mb-12">
                    <button href="#" type="submit" class="btn btn-primary consultar" onclick="iniciar_indicaciones()" >Consultar</button>
                </div>
            </div>
        </form>
    </div>
</div>
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
</body>
</html>



<!-- <a class="card-subtitle mb-2 text-muted">Tipo: </a>  
    <button class="btn btn-secondary dropdown-toggle" type="button" 
            id="dropdownMenuButton" data-toggle="dropdown" 
            aria-haspopup="true" aria-expanded="false">
        Vehiculo
    </button>
    <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
        <a class="dropdown-item">Bus</a>
        <a class="dropdown-item">Taxi</a>
        <a class="dropdown-item">Tren</a>
    </div>  -->