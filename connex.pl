#!/usr/bin/perl -w
use DBI;    
use Time::Piece;
use POSIX qw/strftime/;

			#Les paramètres de connexion à la base de données
my $bd          = 'r2d4_muta2'; 
my $host        = 'localhost';  
my $user        = 'root';       
my $password    = 'a48b59!'; 
my $port	    = '3306';
	
			#Connection à la base de données
	my $dbh = DBI->connect( "DBI:mysql:database=$bd;host=$host;port=$port", 
    $user, $password, { RaiseError => 1,}  ) 
    or die "Connection impossible à la base de données $bd !\n $! \n $@\n$DBI::errstr";
	
			#Requête paramétrée
	my $requete = "INSERT INTO `stock_tri.com` (heure,date,etat) VALUES ( ?, ?, ?)";
 

			#Recuperation de la date actuelle du serveur
my $t = localtime;
my $date = $t->dmy;

			#Recuperation de l'heure 
my $heure = localtime->hms;
 
			#Recuperation des fichiers peu importe leur nom
my @tablodefichiers = <garedetri/tri.com/stock/*.csv>;
my $nbrefichier = 0;
foreach my $nomfichier (@tablodefichiers) {
	$nbrefichier ++;
}
 
			#Insertion dans la base de données
 my $insc = $dbh->prepare($requete) or die $dbh->errstr; 
 $insc->execute( $heure, $date, $nbrefichier);
  
			#Deconnction du serveur
 $dbh->disconnect();
