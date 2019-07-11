#!/usr/bin/perl -w
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

getDescription();
 
sub getDescription{
my $compteur=0;
my @tablodefichier = <garedetri/18description/*.html>;
foreach my $fichiers (@tablodefichier){
	my $description="";
if (open(FIC,"<$fichiers")){
 
 while(my $line = <FIC>){
			if( ($line =~ "<html>") || ($line=~ "</html>") || ($line =~ "<HTML>") || ($line=~ "</HTML>") 
			|| ($line =~ "<head>") || ($line =~ "</head>") || ($line =~ "<HEAD>") || ($line =~ "</HEAD>")){
				$compteur++;
			}
		}
 	
 	if($compteur >0){
my $p = HTML::TokeParser->new($fichiers) or die $!;

my $elements="";
my $ensemble="";

while (my $r = $p->get_token) {
    next unless $r->[0] eq 'S' && $r->[1] eq 'meta';
    #  hash ref containing attributes and values
    while (my ($attribut,$valeur) = each %{$r->[2]}) {
		
		my $element = $attribut."=".$valeur;
		if( $attribut ne "/" && $valeur ne "/"){
		$elements .= $element." ";
		
		if ( $elements =~ /name="description"/ ){
			 $description .= "<meta ".$elements." /> \n";
		}
		
	   }
    }
    $ensemble .= "<meta ".$elements." /> \n";
	$elements="";
}
print $ensemble;
	}
	
	$compteur=0;
	close(FIC);
}

if ( open(FIC,">$fichiers") ){
	print FIC "$description";
	close(FIC);
}

$description="";

}
}
