#!/usr/bin/perl -w
use Time::Piece;
use File::Copy;
use strict;
use File::Basename;
use File::Copy::Recursive qw (fcopy rcopy dircopy fmove rmove dirmove);
use HTML::TagParser;
use HTML::TokeParser;
use File::Path;
use File::stat;
use URI::URL; 
use LWP::Simple;
use DBI;
use utf8;
use diagnostics;
use Data::Dumper;
use LWP::Simple;
use LWP::UserAgent;
use Text::Iconv;
use open qw(:std :utf8);
use diagnostics;

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
    
    
    my @tabloDeFichiers = <garedetri/18keywords/*>;
    foreach my $fichier (@tabloDeFichiers){
		
my $nomfichier = basename("$fichier");
$nomfichier =~ s{\.[^.]+$}{};

my $sth = $dbh->prepare("SELECT Nomdom,id FROM datatest WHERE Nomdom =?");
my $sthUpdate = $dbh->prepare("UPDATE datatest SET Keywords =? WHERE id = ? ");
$sth->execute($nomfichier);

my @data;
while (@data = $sth->fetchrow_array()) {
      #  my $keywords = $data[0];
      my $contenu="";

open(my $file, "<:utf8", $fichier);
my $p = HTML::TokeParser->new($file) or die $!;   
while (my $r = $p->get_token) {
    next unless $r->[0] eq 'S' && $r->[1] eq 'meta';
    #  hash ref containing attributes and values
    while (my ($attribut,$valeur) = each %{$r->[2]}) {
        
		my $element = $attribut."=".'"'.$valeur.'"';
		if($attribut eq "content" ){
			$contenu = $valeur;
		}

    }
    
}
       
       
       if( $contenu =~ m /^$/ ){
		   $contenu=0;
	   }
        $sthUpdate->execute($contenu,$data[1]);
      
		
}
  
          
	}
    

    
    
#Deconection du serveur
 $dbh->disconnect();

