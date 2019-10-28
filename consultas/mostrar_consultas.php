<?php
    $serverName = "localhost"; //serverName\instanceName
    $connectionInfo = array( "Database"=>"Nodo_Central", "UID"=>"sa", "PWD"=>"2018107560", "CharacterSet"=>"UTF-8");
                                        
    $fechaI; 
    $fechaF; 
    $tipo;
    $vehiculo;

    if (isset($_POST['sub1'])) {
        $fechaI=date_create($_POST['fechaI']);
        $fechaF=date_create($_POST['fechaF']);
        $fechaInicio=$fechaI->format('m-d-Y H:i:s');
        $fechaFinal=$fechaF->format('m-d-Y H:i:s');
        $tipo=$_POST['tipo'];

        $myparams['i'] = $fechaInicio;
        $myparams['f'] = $fechaFinal;
        $myparams['t'] = $tipo;

        $procedure_params = array(
            array(&$myparams['i'], SQLSRV_PARAM_IN),
            array(&$myparams['f'], SQLSRV_PARAM_IN),
            array(&$myparams['t'], SQLSRV_PARAM_IN)
        );

        $conn = sqlsrv_connect($serverName, $connectionInfo);
        $sql = "exec dbo.rutas_tipo @fechaI = ?, @fechaF = ?, @tipo = ?";
        $result = sqlsrv_prepare($conn, $sql, $procedure_params);

        echo '<table>';
        echo '<tr>';
        echo '<th>Nombre vehiculo</th>';
        echo '<th>Ruta</th>';
        echo '<th>Tipo de vehiculo</th>';
        echo '</tr>';

        if($result === false) {
            die(FormatErrors(sqlsrv_errors()));
        }
        if (sqlsrv_execute($result)) {
            echo 'entro';
            while ($row = sqlsrv_fetch_array($result, SQLSRV_FETCH_NUMERIC)) {
                print_r($row);
            }
        } else{
            die( print_r( sqlsrv_errors(), true));
        }
        echo '</table>';
        sqlsrv_free_stmt($result);
    }

    if (isset($_POST['sub2'])) {
        $vehiculo=$_POST['vehiculo'];

        $myparams['v'] = $vehiculo;

        $procedure_params = array(
            array(&$myparams['v'], SQLSRV_PARAM_IN),
        );

        $conn = sqlsrv_connect($serverName, $connectionInfo);
        $sql = "exec dbo.promedio_distancia @nombre_vehiculo = ?";
        $result = sqlsrv_prepare($conn, $sql, $procedure_params);

        echo '<table>';
        echo '<tr>';
        echo '<th>Promedio distancia</th>';
        echo '</tr>';

        if($result === false) {
            die(FormatErrors(sqlsrv_errors()));
        }
        if (sqlsrv_execute($result)) {
            while ($row = sqlsrv_fetch_array($result, SQLSRV_FETCH_ASSOC)) {
                echo $row['promedio'];
            }
        } else {
            die( print_r( sqlsrv_errors(), true));
        }
        echo '</table>';
        sqlsrv_free_stmt($result);
    }

    if (isset($_POST['sub4'])) {
        $fechaI=date_create($_POST['fechaI']);
        $fechaF=date_create($_POST['fechaF']);
        $fechaInicio=$fechaI->format('m-d-Y H:i:s');
        $fechaFinal=$fechaF->format('m-d-Y H:i:s');
                                
        $conn = sqlsrv_connect($serverName, $connectionInfo);
        $sql = "exec dbo.usuarios_mayor_rastreos '$fechaInicio', '$fechaFinal'";
        $result = sqlsrv_query($conn, $sql);

        echo '<table>';
        echo '<tr>';
        echo '<th>Usuario</th>';
        echo '<th>Numero de rastreos</th>';
        echo '</tr>';

        if($result === false) {
            die(FormatErrors(sqlsrv_errors()));
        }
        else {
            echo $result;
            while ($row = sqlsrv_fetch_array($result, SQLSRV_FETCH_NUMERIC)) {
                echo $row[0].", ".$row[1]."<br />";
            }
        }
        echo '</table>';

        sqlsrv_free_stmt($result);
    }

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
?>