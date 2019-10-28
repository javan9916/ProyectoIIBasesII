<?php
    $serverName = "localhost"; //serverName\instanceName
    $connectionInfo = array( "Database"=>"Nodo_Central", "UID"=>"sa", "PWD"=>"2018107560", "CharacterSet"=>"UTF-8");
                                        
    $fechaI; 
    $fechaF; 
    $tipo;

    

    if (isset($_POST['sub1'])) {
        $fechaI=date_create($_POST['fechaI']);
        $fechaF=date_create($_POST['fechaF']);
        $fechaInicio=$fechaI->format('m-d-Y H:i:s');
        $fechaFinal=$fechaF->format('m-d-Y H:i:s');
        $tipo=$_POST['tipo'];

        $conn = sqlsrv_connect($serverName, $connectionInfo);
        $sql = "exec rutas_tipo '$fechaInicio', '$fechaFinal', '$tipo'";
        $result = sqlsrv_query($conn, $sql);

        echo '<table>';
        echo '<tr>';
        echo '<th>Nombre vehiculo</th>';
        echo '<th>Ruta</th>';
        echo '<th>Tipo de vehiculo</th>';
        echo '</tr>';

        if($result === false) {
            die(FormatErrors(sqlsrv_errors()));
        }
        else {
            while ($row = sqlsrv_fetch_array($result, SQLSRV_FETCH_NUMERIC)) {
                echo 'entro la jugada';
                echo $row[0].", ".$row[1]. ", ".$row[2]. "<br />";
            }
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
        $sql = "exec usuarios_mayor_rastreos '$fechaInicio', '$fechaFinal'";
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
            while ($row = sqlsrv_fetch_array($result, SQLSRV_FETCH_NUMERIC)) {
                echo 'entro la jugada';
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