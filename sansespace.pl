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
    

my $sth = $dbh->prepare('SELECT Nomdom,id FROM datadom ');
$sth->execute();
my @data;
my $cpt=0;

while (@data = $sth->fetchrow_array()) {
             my $nomdomaine = $data[0];
             my $id = $data[1];
             my $length = length($nomdomaine);

         $nomdomaine = sansEspace($nomdomaine);
         
         my $sql = "UPDATE datadom SET Nomdom =?  WHERE id = ?";
                my $sth  = $dbh->prepare($sql);
                   $sth->bind_param(1,$nomdomaine);
                   $sth->bind_param(2,$id);
                   $sth->execute();
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
