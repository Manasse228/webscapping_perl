#!/usr/bin/perl -w
use strict;
use File::Basename;
use DBI;    
use Time::Piece;
use File::Copy;
use Date::Manip;
use DateTime::Format::Strptime;

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
    
    
    my $sth = $dbh->prepare('SELECT Date,ID FROM console where Date > DATE_SUB(CURRENT_DATE, INTERVAL 15 DAY)');
    $sth->execute();
my @data;
while (@data = $sth->fetchrow_array()){
	my $dat = $data[0];
	my $id = $data[1];
		my $c = $dbh->do("DELETE FROM console WHERE id=$id");

}

$sth->finish;

#Deconection du serveur
 $dbh->disconnect();
