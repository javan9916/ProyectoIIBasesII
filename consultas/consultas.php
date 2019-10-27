<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Consultas</title>
</head>
<body>
    <nav class="navbar navbar-dark bg-dark">>
    <a class="navbar-brand" href="../index.php">
        Volver
    </a>
    <a class="navbar-brand" href="../index.php">
        Actualizar información
    </a>
    </nav>
    <div class="container">
    <br>
    <br>
        <div class="row">
            <div class="card" style="margin-right: 20px;">

                <div class="card-body" style="width: 520px; text-align: center;">
                    <h5 class="card-title">Detalle de rutas de vehículos por tipo de servicio de transporte</h5>
                    <div class="col-md">
                        <div class="form-group">
                            <input type="date" id="start_cons1" name="start_cons1"
                                    value="2019-10-25"
                                    min="2010-01-01" max="2030-12-31">
                            <input type="date" id="end_cons1" name="end_cons1"
                                    value="2019-10-25"
                                    min="2010-01-01" max="2030-12-31">
                            <select class="select-type">
                                <option value="bus">Bus</option>
                                <option value="taxi">Taxi</option>
                                <option value="tren">Tren</option>
                            </select>
                        </div>
                        <table class="table">
                            <thead class="thead-light">
                                <tr>
                                <th scope="col">Ruta</th>
                                <th scope="col">Tipo de vehículo</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr scope="row">
                                    <td>12452351</td>
                                    <td>Bus</td>
                                </tr>
                                <tr scope="row">
                                    <td>12565431</td>
                                    <td>Taxi</td>
                                </tr>
                                <tr scope="row">
                                    <td>12456541</td>
                                    <td>Tren</td>
                                </tr>
                            </tbody>
                        </table>
                        <button type="button" class="btn btn-primary">Consultar</button>
                    </div>
                </div>
            </div>
            <div class="card" >
            <br>
                <div class="card-body" style="width: 520px; text-align: center;">
                    <h5 class="card-title">Promedio de distancia diaria recorrida por bus</h5>
                    <div class="col-md">
                        <table class="table">
                            <thead class="thead-light">
                                <tr>
                                <th scope="col">Bus</th>
                                <th scope="col">Promedio distancia diaria recorrida</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr scope="row">
                                    <td>Limón-Shangai</td>
                                    <td>10km</td>
                                </tr>
                                <tr scope="row">
                                    <td>CQ-Parrita</td>
                                    <td>14km</td>
                                </tr>
                                <tr scope="row">
                                    <td>Puerto Viejo-Disneylandia</td>
                                    <td>16km</td>
                                </tr>
                            </tbody>
                        </table>
                        <button type="button" class="btn btn-primary">Consultar</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="card" style="top: 20px; margin-right: 20px;">
                <div class="card-body" style="width: 520px; text-align: center;">
                    <h5 class="card-title">Tiempos totales anuales de rastreo para un vehículo determinado</h5>
                    <div class="col-md">
                        <div class="form-group">
                            <input type="email" class="form-control" id="exampleInputEmail1" placeholder="Nombre del vehiculo">
                        </div>
                        <button type="button" class="btn btn-primary">Consultar</button>
                    </div>
                </div>
            </div>
            
            <div class="card" style="top: 20px;">
                <form action="" method="POST">
                    <div class="card-body" style="width: 520px; text-align: center;">
                        <h5 class="card-title">Usuarios con mayor número de rastreos</h5>
                        <div class="col-md">
                            <div class="form-group">
                                <input type="date" id="fechaI" name="fechaI"
                                        value="2019-10-25"
                                        min="2010-01-01" max="2030-12-31">
                                <input type="date" id="fechaF" name="fechaF"
                                        value="2019-10-25"
                                        min="2010-01-01" max="2030-12-31">
                            </div>
                            <table class="table">
                                <thead class="thead-light">
                                    <tr>
                                        <th scope="col">Usuario</th>
                                        <th scope="col">Número de rastreos</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php
                                        $serverName = "localhost"; //serverName\instanceName
                                        $connectionInfo = array( "Database"=>"Nodo_Central", "UID"=>"sa", "PWD"=>"2018107560", "CharacterSet"=>"UTF-8");
                                        
                                        $fechaI;
                                        $fechaF;

                                        if (isset($_POST['sub4'])) {
                                            $fechaI=date_create($_POST['fechaI']);
                                            $fechaF=date_create($_POST['fechaF']);
                                            $fechaI=date_format($fechaI, 'm-d-Y H:i:s');
                                            $fechaF=date_format($fechaF,'m-d-Y H:i:s');
                                
                                            $conn = sqlsrv_connect($serverName, $connectionInfo);
                                            $sql = "exec usuarios_mayor_rastreos '$fechaI', '$fechaF'";
                                            $result = sqlsrv_query($conn, $sql);

                                            if($result == FALSE)
                                                die(FormatErrors(sqlsrv_errors()));
                                            while ($row = sqlsrv_fetch_array($result, SQLSRV_FETCH_ASSOC)) {
                                                echo '<tr scope="row">';
                                                echo '<td>'. $row['usuario'] .'</td>';
                                                echo '<td>'. $row['cantidad'] . '</td>';
                                                echo '</tr>';
                                            }
                                        }
                                    ?>
                                </tbody>
                            </table>
                            <button type="submit" class="btn btn-primary" name="sub4" href="#">Consultar</button>
                        </div>
                    </div>
                </form>   
            </div>
        </div>
    </div>

    <?php
        //$serverName = "localhost"; //serverName\instanceName
        //$connectionInfo = array( "Database"=>"Nodo_Central", "UID"=>"sa", "PWD"=>"2018107560", "CharacterSet"=>"UTF-8");

        
        $nombre;
        $vehiculo;
        $tipo;

        function FormatErrors( $errors ){
            /* Display errors. */
            echo "Error information: ";

            foreach ( $errors as $error )
            {
                echo "SQLSTATE: ".$error['SQLSTATE']."";
                echo "Code: ".$error['code']."";
                echo "Message: ".$error['message']."";
            }
        }

        /*if (isset($_POST['sub4'])) {
            $fechaI=$_POST['fechaI'];
            $fechaF=$_POST['fechaF'];

            $conn = sqlsrv_connect($serverName, $connectionInfo);
            $sql = "exec usuariosMayorNumeroRastreos '$fechaI', '$fechaF'";
        }*/
        
    ?>


    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
</body>
</html>