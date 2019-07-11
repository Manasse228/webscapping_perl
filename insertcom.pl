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
    $user, $password, { RaiseError => 1, mysql_enable_utf8 => 1}  ) 
    or die "Connection impossible à la base de données $bd !\n $! \n $@\n$DBI::errstr";
    
				#Requête paramétrée
	my $requete = "INSERT INTO datadom (Nomdom,Registrar,Type,Organisation,Nom,Prenom,Adresse,CP,Ville,Tel,Mail,Adminemail,Techemail,IP,NS1,NA_Answer,Expiration,Creation,Miseajour,DateInsert) 
	VALUES ( ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,? )";
	

my @tablodefichier= <garedetri/14comfr/*.csv>;

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
if(my @files = glob("garedetri/14comfr/*.csv") ){
	
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

			if (open(FIC, "<$nomfichier")){

			while(my $line = <FIC>){

				   #Recuperation du nom de domaine
				    if( ($line =~ "Domain Name:") ){
				    my @values = split(':', $line);
					foreach my $val (@values) {
							$nomdomaine=$val;
                       }
				}
					#Recuperation du registrar
					if( ($line =~ "Registrar:") ){
					my @values = split(':', $line);
					foreach my $val (@values) {
							$registrar=$val;
                       }
				}
					#Recuperation de expirate date
				    if( ($line =~ "Expiration Date:") ){
					my @values = split(':', $line);
					my $cpt=0;
					foreach my $val (@values) {
						$cpt++;
						if($cpt==2 && $expiration eq ""){
							$expiration=$val;
						}
                       }
				}
					#Recuperation de la date de creation
				    if( ($line =~ "Creation Date:") ){
					my @values = split(':', $line);
					my $cpt=0;
					foreach my $val (@values) {
							$cpt++;
						if($cpt==2 && $creationdate eq ""){
							$creationdate=$val;
						}
                       }
				}
					#Recuperation de la date de mise à jour
				    if( ($line =~ "Updated Date:") ){
					my @values = split(':', $line);
					my $cpt=0;
					foreach my $val (@values) {
								$cpt++;
						if($cpt==2 && $updatedate eq ""){
							$updatedate=$val;
						}
                       }
				}
					#Recuperation de l'organisation
				    if( ($line =~ "Registrant Organization:") ){
					my @values = split(':', $line);
					my $cpt=0;
					foreach my $val (@values) {
									$cpt++;
						if($cpt==2 && $organisation eq ""){
							$organisation=$val;
						}
							
                       }
				}
				   #Recuperation du nom
				    if( ($line =~ "Registrant Name:") ){
					my @values = split(':', $line);
					foreach my $val (@values) {
							$nom=$val;
                       }
				}
				  #Recuperation de l'adresse
				    if( ($line =~ "Registrant Street:") ){
					my @values = split(':', $line);
					foreach my $val (@values) {
							$adresse=$val;
                       }
				} 
				 #Recuperation du code postal
				    if( ($line =~ "Registrant Postal Code:") ){
					my @values = split(':', $line);
					foreach my $val (@values) {
							$codepostal=$val;
                       }
				}
				 #Recuperation de la ville
				    if( ($line =~ "Registrant City:") ){
					my @values = split(':', $line);
					foreach my $val (@values) {
							$ville=$val;
                       }
				}
				 #Recuperation du numero de telephone
				    if( ($line =~ "Registrant Phone:") ){
					my @values = split(':', $line);
					foreach my $val (@values) {
							$telephone=$val;
                       }
				}
				#Recuperation de ladresse mail
				    if( ($line =~ "Registrant Email:") ){
					my @values = split(':', $line);
					foreach my $val (@values) {
							$mail=$val;
                       }
				}
				#Recuperation de ladresse mail de l'admin
				    if( ($line =~ "Admin Email:") ){
					my @values = split(':', $line);
					foreach my $val (@values) {
							$admineamil=$val;
                       }
				}
				#Recuperation de ladresse mail de tech
				    if( ($line =~ "Tech Email:") ){
					my @values = split(':', $line);
					foreach my $val (@values) {
							$techemail=$val;
                       }
				}
				
			}
			close(FIC);
$prenom="0";
$IP = "0";
$NS1= "0";
$NA_Answer= "0";
$dateinsert=localtime->ymd;
#Recuperation du type
$type="ORGANIZATION";
$nomdomaine = sansEspace($nomdomaine);

#$nomdomaine =~ s/^\s+//; #Supprimer les espaces en début de mot
#$nomdomaine =~ s/\s+$//; #Supprime les espaces en fin de mot
#$nomdomaine =~ s/\s+//; #Supprime tous les espaces

if( $organisation =~ m /^$/ ){$type="PERSON";}

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
		print "le repertoire est  vide \n";
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




