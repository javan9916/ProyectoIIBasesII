<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <link rel="stylesheet" href="styles.css">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Consultas</title>
</head>
<body>
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
                <div class="card-body" style="width: 520px; text-align: center;">
                    <h5 class="card-title">Usuarios con mayor número de rastreos</h5>
                    <div class="col-md">
                        <div class="form-group">
                            <input type="date" id="start_cons2" name="start_cons2"
                                    value="2019-10-25"
                                    min="2010-01-01" max="2030-12-31">
                            <input type="date" id="end_cons2" name="end_cons2"
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
                                <tr scope="row">
                                    <td>Mark</td>
                                    <td>10</td>
                                </tr>
                                <tr scope="row">
                                    <td>Lucy</td>
                                    <td>9</td>
                                </tr>
                                <tr scope="row">
                                    <td>John</td>
                                    <td>5</td>
                                </tr>
                            </tbody>
                        </table>
                        <button type="button" class="btn btn-primary">Consultar</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>