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
use Text::Iconv;
use open qw(:std :utf8);
use diagnostics;


my $namefile="";
my @tabloDeRepertoire = <garedetri/17wget/*>;
foreach my $repertoire (@tabloDeRepertoire){
	if( -d $repertoire){
		if (my @files = glob("$repertoire/*") ){
			my @tabloDeFichiers = <$repertoire/*.html>;
			foreach my $fichier (@tabloDeFichiers){
				
				 my @values = split("/", $repertoire);
				 for my $rep (@values){ $namefile=$rep; }
				 
				 getKeyWords($fichier);
				 
				  
				
				
			}
			
		}
		
	}
}
 
sub getKeyWords{
my(@args)=@_;
my $compteur=0;	
my $keywords="";
my $description="";

if (open(FIC,"<@args")){
 while(my $line = <FIC>){
	#  my $line = $converter->convert($ligne); 
			if( ($line =~ "<html>") || ($line=~ "</html>") || ($line =~ "<HTML>") || ($line=~ "</HTML>") 
			|| ($line =~ "<head>") || ($line =~ "</head>") || ($line =~ "<HEAD>") || ($line =~ "</HEAD>")){
				$compteur++;
			}
		}
 	
 	if($compteur >0){
my $p = HTML::TokeParser->new("@args") or die $!;

my $elements="";
my $ensemble="";

while (my $r = $p->get_token) {
    next unless $r->[0] eq 'S' && $r->[1] eq 'meta';
    #  hash ref containing attributes and values
    while (my ($attribut,$valeur) = each %{$r->[2]}) {
        
		my $element = $attribut."=".'"'.$valeur.'"';
		if($attribut eq "name" && $valeur eq "keywords"){
	      
		}
	
		if( $attribut ne "/" && $valeur ne "/"){
		$elements .= $element." ";
		
		if ( $elements =~ /name="keywords"/ ){
			# $keywords .= "<meta ".$elements." /> \n";
			 $keywords .= $elements."\n";
		}
		if ( $elements =~ /name="description"/ ){
			 $description .= $elements."\n";
		}
		
	   }
    }
    
    $ensemble .= "<meta ".$elements." /> \n";
	$elements="";
}

	}
	
	$compteur=0;
	close(FIC);
	
}

#print "######################################### \n";
#print $description;
#print "######################################### \n";

#print "######################################### \n";
#print $keywords;
#print "######################################### \n";

open my $nouveaufichier1, '>', "garedetri/18description/".$namefile.".html";
print {$nouveaufichier1} $description . "\n";
close $nouveaufichier1;

open my $nouveaufichier, '>', "garedetri/18keywords/".$namefile.".html";
print {$nouveaufichier} $keywords . "\n";
close $nouveaufichier;

$namefile="";
}





 
 
