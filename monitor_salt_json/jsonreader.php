<html>
<head>
  <meta charset="utf-8">
  <title>Salt Json Monitor</title>
  <link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
  <link rel="stylesheet" href="//cdn.datatables.net/1.10.11/css/jquery.dataTables.min.css">
  <link rel="stylesheet" href="css/jsonreader.css">
  <script src="//code.jquery.com/jquery-1.10.2.js"></script>
  <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
  <script src="//cdn.datatables.net/1.10.11/js/jquery.dataTables.min.js"></script>
<script>
$( document ).ready(function() {
<?php
    $curYYMMDD = date("Ymd");
    $curYYMM = date("Ym");
    if(isset($_POST["datechoose"]) && isset($_POST["data"])) {
        $dateChoosen = $_POST["datechoose"];
        $data = $_POST["data"];
        $filename = "./" . $curYYMM . "/" . $dateChoosen . $data . ".json";
        $string = file_get_contents($filename);
        $json = json_decode($string, true);
        switch (json_last_error()) {
            //check json content
            case JSON_ERROR_NONE:
                echo 'console.log("Aucune erreur");'."\n";
            break;
            case JSON_ERROR_DEPTH:
                echo 'console.log("Profondeur maximale atteinte");'."\n";
            break;
            case JSON_ERROR_STATE_MISMATCH:
                echo 'console.log("Inadéquation des modes ou underflow");'."\n";
            break;
            case JSON_ERROR_CTRL_CHAR:
                echo 'console.log("Erreur lors du contrôle des caractères");'."\n";
            break;
            case JSON_ERROR_SYNTAX:
                echo 'console.log("Erreur de syntaxe ; JSON malformé");'."\n";
            break;
            case JSON_ERROR_UTF8:
                echo 'console.log("Caractères UTF-8 malformés, probablement une erreur d\'encodage");'."\n";
            break;
            default:
                echo 'console.log("Erreur inconnue");'."\n";
            break;
        }
        //var_dump($json);

        $disks = false;
        //thead
        echo "var thead = $('thead');"."\n";
        if($data == "_hosts_status") {
            echo "thead.append('<tr><th>Server</th><th>Status</th></tr>')"."\n";
        }
        elseif($data == "_services") {
            //echo "thead.append('<tr><th>Server</th><th>Servicename</th><th>Status</th><th>Comment</th><th>Start</th></tr>')"."\n";
            echo "thead.append('<tr><th>Server</th><th>Command Result</th><th>Service</th><th>Status</th></tr>')"."\n";
        }
        elseif($data == "_disks") {
            echo "thead.append('<tr><th>Server</th><th>Mountpoint</th><th>Usage [%]</th></tr>')"."\n";
        }
        else {
            echo "console.log('Data type unknown.');"."\n";
        }


        // tbody
        echo "var tbody = $('tbody');"."\n";
        foreach ($json as $name => $val) {
            if(!is_array($json[$name])) {
                /* hosts state */
                echo 'var tr = $("<tr>");'."\n";
                echo "$('<td>').html('".$name."').appendTo(tr);"."\n";
                if ( $val ==  null) {
                    $val = "0";
                }
                echo "$('<td>').html('".$val."').appendTo(tr);"."\n";
                echo 'tbody.append(tr);'."\n";
            } else {
                $hostArray = $json[$name];
                foreach ($hostArray as $subname => $subval) {
                    if(is_array($hostArray[$subname]) && isset($hostArray[$subname])) {
                        /* service / daemon state */
                        $servArray = $hostArray[$subname];
                        echo 'var tr = $("<tr>");'."\n";
                        echo "$('<td>').html('".$name."').appendTo(tr);"."\n";

                        foreach ($servArray as $daemon_type => $daemonval) {
                            /*if($daemon_type == "name") {
                                $html_str_name = "<td>".$daemonval."</td>";
                            }
                            elseif($daemon_type == "result") {*/
                            if($daemon_type == "result") {
                                if ( $daemonval ==  null) {
                                    $daemonval = "0";
                                }
                                $html_str_result = "<td>".$daemonval."</td>";
                            }
                            /*elseif($daemon_type == "comment") {
                                $html_str_comment = "<td>".$daemonval."</td>";
                            }*/
                            elseif($daemon_type == "changes") {
                                $ret_daemonval = $daemonval["ret"];
                                $html_str_start = "<td>".$ret_daemonval[0]."</td>";
                                $html_str_start .= "<td>".$ret_daemonval[1]."</td>";
                            }
                            else {  }
                        }
                        $tdhtml = $html_str_name.$html_str_result.$html_str_comment.$html_str_start;
                        echo 'tr.append("'.$tdhtml.'");'."\n";
                        echo 'tbody.append(tr);'."\n";
                        //reinitialize
                        $tdhtml = "";
                        $html_str_name = "";
                        $html_str_result = "";
                        $html_str_comment = "";
                        $html_str_start = "";
                    }
                    else {
                        echo 'var tr = $("<tr>");'."\n";
                        echo "$('<td>').html('".$name."').appendTo(tr);"."\n";
                        echo "$('<td>').html('".$subname."').appendTo(tr);"."\n";
                        echo "$('<td>').html('".$subval."').appendTo(tr);"."\n";
                        echo 'tbody.append(tr);'."\n";
                    }
                }
            }
        }
        echo "\n";
        echo "$('#datechoose').val('".$dateChoosen."');"."\n";

    }
    else {
        echo '$("#datechoose").datepicker({dateFormat: "yymmdd"}).datepicker("setDate", new Date());'."\n";
    }
?>

    $( "#datechoose" ).datepicker({
        dateFormat: "yymmdd",
        defaultDate: null,
    });

    $('#myTable').DataTable({
        //"lengthChange": false,
        "lengthMenu": [ [10, 25, 50, -1], [10, 25, 50, "All"] ],
        <?php if($data == "_hosts_status") { ?>
            "pageLength": -1,
            "order": [[ 1, "desc" ], [0, "asc"]],
            "createdRow": function( row, data, dataIndex ) {
            if ( data[1] == "1" ) {
                /* Server status */
                $('td', row).eq(0).addClass('true');
                $('td', row).eq(1).addClass('true');
            }
            else {
                /* Server is down or does not respond ! */
                $('td', row).eq(0).addClass('false');
                $('td', row).eq(1).addClass('false');
            }
        }
        <?php } elseif($data == "_services") { ?>
            "pageLength": -1,
            "order": [[ 3, "asc" ], [0, "asc"], [2, "asc"]],
            "createdRow": function( row, data, dataIndex ) {
            if ( data[3] == "1" ) {
                /* Service / daemon status is ok */
                $('td', row).addClass('true');
            }
            else {
                /* Service / daemon status is down */
                $('td', row).addClass('false');
                /*    
                    if ( data[3].indexOf("has been enabled") != -1 ) {
                        $('td', row).eq(3).addClass('warning');
                    } else {
                        $('td', row).eq(3).addClass('true');
                    }
                */
            }
        }
        <?php } elseif($data == "_disks") { ?>
            "pageLength": 25,
            "order": [[ 2, "desc" ], [0, "asc"]],
            "createdRow": function( row, data, dataIndex ) {
                var x = data[2].replace(/%/, "");
                x = parseFloat(x);
                if ( x > "90" ) {
                    /* Service / daemon status is ok */
                    $('td', row).eq(0).addClass('false');
                    $('td', row).eq(1).addClass('false');
                    $('td', row).eq(2).addClass('false');
                }
                else {
                    /* Service / daemon status is down */
                    $('td', row).eq(0).addClass('true');
                    $('td', row).eq(1).addClass('true');
                    $('td', row).eq(2).addClass('true');
                }
            }
        <?php } else {} ?>
        });
});
</script>

</head>

<body>
<form method='POST'>
<br />
    <br />
    Select date [YYYYMMDD] : <input type="text" id="datechoose" name="datechoose" />
    <br />
    <br />
    Select Data :
    <input type="radio" name="data" value="_hosts_status" checked /> Server status
    &nbsp;
    &nbsp;
    &nbsp;
    <input type="radio" name="data" value="_services" /> Daemon status
    &nbsp;
    &nbsp;
    &nbsp;
    <input type="radio" name="data" value="_disks" /> Disk usage
    <br />
    <br />
<input type='submit' value='ok' id='subm' />
</form>

<div id="results">
<table id="myTable" class="perso compact cell-border">
<thead>
</thead>
<tbody></tbody>
</table>
</div>

</body>
</html>
