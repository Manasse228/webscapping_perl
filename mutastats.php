<?php
include 'connex.php';
	//$mysqlink = mysqli_connect("localhost", "root", "a48b59!", "r2d4_muta2");

    $result = $conn->query("SELECT COUNT(*) FROM datadom");
	$row = $result->fetch_row();
	$NbDom = $row[0];	


    //$result = $mysqlink->query("SELECT COUNT(*) FROM datadom WHERE 'Nomdom' LIKE '%fr'");
	//$row = $result->fetch_row();
	//$FrDom = $row[0];

	//$result = $mysqlink->query("SELECT COUNT(*) FROM datadom WHERE Nomdom LIKE '%com'");
	$result = $conn->query("SELECT Nomdom FROM datadom ");
	$ComDom=0;
	$FrDom=0;
	$AutreDom=0;
		
	while ( $row = $result->fetch_assoc() ){
		
	$subtri=implode('.', array_slice(explode('.', $row["Nomdom"]), -1));

	if (strcasecmp(trim($subtri), "com") == 0) {
       $ComDom++;
     }
     
     if (strcasecmp(trim($subtri), "fr") == 0) {
       $FrDom++;
     }
     
     if ( (strcasecmp(trim($subtri), "fr") != 0) && (strcasecmp(trim($subtri), "com") != 0)) {
       $AutreDom++;
     }
	}
	//echo "total com ".$ComDom."\n";
	//echo "total fr ".$FrDom."\n";
	//echo "total autre ".$AutreDom."\n";

	//$result = $mysqlink->query("SELECT COUNT(*) FROM datadom WHERE Nomdom NOT LIKE '%com' AND Nomdom NOT LIKE '%fr'");
	//$row = $result->fetch_row();
	//$AutreDom = $row[0];

	$date = date('d-m-Y',strtotime('-15 days'));
	$result = $conn->query("SELECT * FROM mutastats WHERE DateJour > ".$date);
	while ( $row = $result->fetch_assoc() ){
		echo "voila ".$row["DateJour"]."<br/>";
	}
	

	$result = $conn->query("SELECT COUNT(*) FROM datadom WHERE Type LIKE 'ORGANIZATION'");
	$row = $result->fetch_row();
	$CorpNumerus = $row[0];

    $result = $conn->query("SELECT COUNT(*) FROM datadom WHERE Type LIKE 'PERSON'");
	$row = $result->fetch_row();
	$PersNumerus = $row[0];



	$FrStat = $FrDom *100 / $NbDom;
	$ComStat = $ComDom *100/ $NbDom;
	$AutreStat = 100- $FrStat - $ComStat;
    $Corp = $CorpNumerus *100 / $NbDom;
    $Pers = $PersNumerus *100 / $NbDom;

	$today = date("d.m.y");
	
	$datefin=strtotime(date("Y")."-12-24");
    $today1 = date("Y-m-d"); 
    $now = strtotime($today1);
    $nbreDay = floor(abs($datefin - $now)/(60*60*24));
	
	$reponse=$conn->query("SELECT TotalDom FROM mutastats ORDER BY Id DESC LIMIT 7 ");
	$moy1=0;
	while($row = $reponse->fetch_assoc() ){
		$moy1 = $row["TotalDom"]; 
	}
		
	$moy = round(($NbDom-$moy1)/7); 
	//echo "nbdomaine ".$NbDom."<br/>";
	//echo "moyenne ".$moy."<br/>";


	$estim = $moy * $nbreDay;
	$moyj = $moy;
	//echo "estim ".$estim."<br/>";
	$conn->query("INSERT INTO mutastats (DateJour, TotalDom, FR, FR_stat, COM, COM_stat, Autres, Autres_stat,CORP, CORP_stat, PERSON,PERS_stat, ESTIM, moyj) VALUES ('$today', '$NbDom', '$FrDom', '$FrStat', '$ComDom', '$ComStat', '$AutreDom', '$AutreStat', '$CorpNumerus' , '$Corp','$PersNumerus','$Pers','$estim','$moyj')");



mysqli_close($conn);
?>
