#!/usr/bin/perl -w
use strict;
use File::Basename;
use DBI;    
use Time::Piece;

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

my $domaine = 'bebloom.com';

   my $sql = " SELECT count(*) from datadom WHERE nomdom = ? ";
   
    my $sth = $dbh->prepare($sql);
    $sth->execute($domaine);
    my $rows = $sth->fetchrow_arrayref->[0];
    $sth->finish;


print"le nombre $rows\n";

#Deconection du serveur
 $dbh->disconnect();




	
