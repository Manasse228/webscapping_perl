#!/usr/bin/perl -w
use strict;
use File::Basename;
use DBI;    
use Time::Piece;
use File::Copy;

				#Les paramètres de connexion à la base de données
my $bd          = 'r2d4_muta2'; 
my $host        = 'localhost';
my $user        = 'root';       
my $password    = 'a48b59!'; 
my $port	    = '3306';

				#Connection à la base de données
	my $dbh = DBI->connect( "DBI:mysql:database=$bd;host=$host;port=$port", 
    $user, $password, {RaiseError => 1, mysql_enable_utf8 => 1}  ) 
    or die "Connection impossible à la base de données $bd !\n $! \n $@\n$DBI::errstr";
    
				#Requête paramétrée
	my $requete = "INSERT INTO datadom (Nomdom,Registrar,Type,Organisation,Nom,Prenom,Adresse,CP,Ville,Tel,Mail,Adminemail,Techemail,IP,NS1,NA_Answer,Expiration,Creation,Miseajour,DateInsert) 
	VALUES ( ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,? )";
	

my @tablodefichier= <garedetri/13whoisfr/*.csv>;

my $nomdomaine="";
my $registrar="";	
my $expiration="";
my $creationdate="";
my $updatedate="";
my $type="";
my $organisation="";
my $nom="";
my $prenom="";
my $adresse="";
my $codepostal="";
my $ville="";
my $telephone="";
my $mail="";
my $dateinsert="";
my $admineamil="";
my $techemail="";
my $IP;
my $NS1;
my $NA_Answer;

#Verification si le dossier est vide
if(my @files = glob("garedetri/13whoisfr/*.csv") ){
	
		foreach my $nomfichier (@tablodefichier) {
$nomdomaine="";
$registrar="";	
$expiration="";
$creationdate="";
$updatedate="";
$type="";
$organisation="";
$nom="";
$prenom="";
$adresse="";
$codepostal="";
$ville="";
$telephone="";
$mail="";
$admineamil="";
$techemail="";
my $stop=0;
my $stop1=0;
my $pointeur=0;

			if (open(FIC, "<$nomfichier")){

			while(my $line = <FIC>){

				   #Recuperation du nom de domaine
				    if( ($line =~ "domain:") ){
				    my @values = split(':', $line);
					foreach my $val (@values) {
							$nomdomaine=$val;
                       }
				}
					#Recuperation du registrar
					if( ($line =~ "registrar:") ){
					my @values = split(':', $line);
					foreach my $val (@values) {
							$registrar=$val;
                       }
				}
					#Recuperation de expirate date
				    if( ($line =~ "anniversary:") ){
					my @values = split(':', $line);
					foreach my $val (@values) {
							$expiration=$val;
                       }
				}
					#Recuperation de la date de creation
				    if( ($line =~ "created:") ){
					my @values = split(':', $line);
					foreach my $val (@values) {
							$creationdate=$val;
				}
			}
					#Recuperation de la date de mise à jour
				    if( ($line =~ "last-update:") ){
					my @values = split(':', $line);
					foreach my $val (@values) {
							$updatedate=$val;
                       }
				}
				
				#Recuperation du type et le mail, adminlail, techmail, telephone, phone, ville
				    if( ($line =~ "nic-hdl:") ){
						if($stop == 0){
						   my $compt=$.;
						   my $cap=0;
					       $pointeur=$.;
						while(my $ligne = <FIC>){
							if ( ($. >=$compt ) && ($cap==0) ){
								$pointeur++;
							if( $ligne =~ m /^$/ ){ $cap=1; }
							if( ($ligne =~ "type:") ){
					        my @values = split(':', $ligne);
					        foreach my $val (@values) {
							$type=$val;
                               }
				             }
				
				            if( ($ligne =~ "e-mail:") ){
				          	my @values = split(':', $ligne);
					        foreach my $val (@values) {
							$mail=$val;
                               }
				            }
				            
				            if( ($ligne =~ "contact:") ){
				          	my @values = split(':', $ligne);
					        foreach my $val (@values) {
							$nom=$val;
                               }
				            }
				            
				            if( ($ligne =~ "phone:") ){
				          	my @values = split(':', $ligne);
					        foreach my $val (@values) {
							$telephone=$val;
                               }
				            }
				            
				             if( ($ligne =~ "address:") ){
							 my $temp="";
					         my @values = split(':', $ligne);
					         foreach my $val (@values) {
							  $temp=$val;
                               }
                              $adresse .= $temp ;
                              }
				            	
						}						   
						}
						
						(open(FICH, "<$nomfichier"));
						while(my $lignes = <FICH>){
						my $toparret=0;
							if( $. > $pointeur ){
								if( ($lignes =~ "e-mail:") && ( $admineamil =~ m /^$/) ){
					            my @values = split(':', $lignes);
					            foreach my $val (@values) {
							    $admineamil=$val;
                               }
                               $toparret=$.;
				             }
				             
				             if( ($lignes =~ "e-mail:") && ($. > $toparret) && ( $techemail =~ m /^$/ ) ){
					            my @values = split(':', $lignes);
					            foreach my $val (@values) {
							    $techemail=$val;
                               }
				             }
				             
							}
						} close(FICH);

						$stop++; 
				 }
				}
				
			}
			close(FIC);
$prenom="0";
$IP = "0";
$NS1= "0";
$NA_Answer= "0";
$dateinsert=localtime->dmy;
if( $mail =~ m /^$/ ){$mail="anonymous";}
if( $admineamil =~ m /^$/ ){$mail="0";}
if( $techemail =~ m /^$/ ){$mail="0";}
if( $nom =~ m /^$/ ){$mail="anonymous";}
if( $telephone =~ m /^$/ ){$mail="anonymous";}
$nomdomaine = sansEspace($nomdomaine);

#print "*********************$nomfichier********************* \n";

#print "Domaine: $nomdomaine \n";
#print "Registrar: $registrar \n";
#print "Anniversary: $expiration \n";
#print "Creation date: $creationdate \n";
#print "Update date: $updatedate \n";
#print "Nom: $nom \n";
#print "Telephone: $telephone \n";
#print "Ville: $ville \n";
#print "le type: $type \n";
#print "lemail: $mail \n";
#print "lemail admin: $admineamil \n";
#print "lemail tech: $techemail \n";
#print "Adresse : $adresse \n";

my $code="";
my $i=0;
my $j=0;
my @values = split('\n', $adresse);
foreach my $val (@values) {$code=$val; }

 #print "Adresse $code \n";
 
my @values1 = split(' ', $code);
foreach my $val1 (@values1) {
$codepostal=$val1; 
last;}

foreach my $val11 (@values1) { $i++; }
if ( $i == 2 ){ foreach my $val11 (@values1) { $ville=$val11; } }
else{
	my $temp="";
	foreach my $val11 (@values1) { 
		$j++;
		if ( $j > 1 ){
			$temp = $val11;
			$ville .= " ".$temp;
		}	
  }
}
 
  #print "Code postal $codepostal \n";
  #print "Ville $ville \n";

#print "*********************$nomfichier********************* \n";

my $insc = $dbh->prepare($requete) or die $dbh->errstr; 
$insc->execute($nomdomaine,$registrar,$type,$organisation,$nom,$prenom,$adresse,$codepostal,$ville,$telephone,$mail,
$admineamil,$techemail,$IP,$NS1,$NA_Answer,$expiration,$creationdate,$updatedate,$dateinsert) or die $dbh->errstr; 

						#Deplacement
my $dossierdestination = "garedetri/15traites/$dateinsert";
(-e $dossierdestination)  or  mkdir $dossierdestination;
move $nomfichier, "$dossierdestination/";

						#Suppression de doublons
my $sth = $dbh->prepare('SELECT MAX(id) AS id FROM datadom GROUP BY Nomdom HAVING COUNT(*) >1');
my $results = $dbh->selectall_hashref('SELECT MAX(id) AS id1 FROM datadom GROUP BY Nomdom HAVING COUNT(*) >1', 'id1');
foreach my $id (keys %$results) {
	#print "id $id\n";
 my $c = $dbh->do("DELETE FROM datadom WHERE id=$id");
}
			}else{
						#Ouverture impossible du fichier
die("Ouverture impossible du fichier: $!\n");
			}
			

}	
	}else{
		print "le repertoire est  vide humm\n";
	}
	
	sub sansEspace{
	my (@args)=@_;
	my $nom = "@args";
	 $nom =~ s/^\s+//; #Supprimer les espaces en début de mot
	 $nom =~ s/\s+$//; #Supprime les espaces en fin de motpaces
	return $nom;
}

#Deconection du serveur
 $dbh->disconnect();
