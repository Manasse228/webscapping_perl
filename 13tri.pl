#!/usr/bin/perl -w
use strict;
use File::Basename;
use File::Copy;


my @tablodefichier= <garedetri/12csvwhois/*>;

					#Verification si le dossier est vide
if(my @files = glob("garedetri/12csvwhois/*") ){
	
		foreach my $nomfichier (@tablodefichier) {
			
					#Recuperatiin du fichier avec extention
my $nomfichiersimple = basename("$nomfichier");

if ($nomfichiersimple =~ /\.com.csv$/i) {
         move $nomfichier, "garedetri/13whoiscom/"; 
    }else{
		if ($nomfichiersimple =~ /\.eu.csv$/i) {
        move $nomfichier, "garedetri/13whoiseu/"; 
    }else{
		if ($nomfichiersimple =~ /\.fr.csv$/i) {
        move $nomfichier, "garedetri/13whoisfr/"; 
    }else{
		if ($nomfichiersimple =~ /\.net.csv$/i) {
        move $nomfichier, "garedetri/13whoisnet/"; 
    }else{
		if ($nomfichiersimple =~ /\.org.csv$/i) {
        move $nomfichier, "garedetri/13whoisorg/"; 
    }else{
		unlink $nomfichier;
	}
	}
	}
	}
	}
}	
	}else{
		print "le repertoire est  vide \n";
	}




