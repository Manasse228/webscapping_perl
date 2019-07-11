#!/usr/bin/perl -w
use strict;
use File::Basename;
use DBI;    
use Time::Piece;
use File::Copy;
use File::Find;
use File::Path;

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
    
    
my $sth = $dbh->prepare('SELECT Mail,Adminemail,Techemail,id FROM datatest ');
$sth->execute();
my @data;
my $cpt=0;

while (@data = $sth->fetchrow_array()) {
            my $mail = $data[0];
            my $adminmail = $data[1];
            my $techmail = $data[2];
            my $id=$data[3];
            
            if( ($mail=~ "o-w-o") || ($mail=~ "1and1") ){
				 $mail ="anonymous"; $cpt=1;
			}
			
			if( ($adminmail=~ "o-w-o") || ($adminmail=~ "1and1") ){
				 $adminmail ="anonymous"; $cpt=1;
			}
			
			if( ($techmail=~ "o-w-o") || ($techmail=~ "1and1") ){
				 $techmail ="anonymous"; $cpt=1;
			}
			
			if($cpt==1){
			    my $sql = "UPDATE datatest SET Mail =?, Adminemail =?, Techemail =? WHERE id = ?";
                my $sth  = $dbh->prepare($sql);
                   $sth->bind_param(1,$mail);
                   $sth->bind_param(2,$adminmail);
                   $sth->bind_param(3,$techmail);
                   $sth->bind_param(4,$id);
                   $sth->execute();
			   }

}

if ($sth->rows == 0) {
  print "Pas de données dans la base";
}

$sth->finish;



# -effacement  en table "console" des données >15j   
my $sth1 = $dbh->prepare('SELECT Date,ID FROM console1 where Date > DATE_SUB(CURRENT_DATE, INTERVAL 15 DAY)');
$sth1->execute();
my @data1;
while (@data1 = $sth1->fetchrow_array()){
	my $dat = $data1[0];
	my $id = $data1[1];
	my $c = $dbh->do("DELETE FROM console1 WHERE id=$id");
}

$sth->finish;

#Deconection du serveur
 $dbh->disconnect();
 
 
 #- effacement dossiers >15j de 15traites  
 my @tablofichier = <garedetri/15supprim/*.csv>;
foreach my $fichiers (@tablofichier){
	my $age = int (-M $fichiers);
	
	if($age >= 15 ){
		unlink $fichiers;
	}
}
 #- effacement dossiers >15j de 15supprim
my @tablofichier1 = <garedetri/15traites/*>;
foreach my $fichiers (@tablofichier1){
	my $age = int (-M $fichiers);
	
	if( ($age >= 15 ) && (-d $fichiers) ){
		#print  "Mon âge est: ".$age." ".$fichiers."\n";
if(rmtree([$fichiers], 1, 1)!=0){
}else{
   print "Erreur lors de la suppression de $fichiers.\n";
}
	}	
}

 
 
 
 
