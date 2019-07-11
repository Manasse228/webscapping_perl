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
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
#Deconection du serveur
 $dbh->disconnect();

