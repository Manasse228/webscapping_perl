#!/usr/bin/perl -w
use strict;
use File::Basename;

		#Recuperation des fichiers d'extention .csv
my @tablodefichiers = <listing/source/*.csv>;

		#Création du fichier contenant la liste des noms de fichier
open my $nouveaufichier, '>', 'listing/sortie/csv.csv';

		#Parcours du tableau contant les fichiers
  foreach my $nomfichier (@tablodefichiers) {
	  
		#Recuperatiin du fichier avec extention
my $nomfichiersimple = basename("$nomfichier");

		#Suppression des extensions
$nomfichiersimple =~ s{\.[^.]+$}{};

#print "Nous avons comme fichier $nomfichiersimple\n";
		#Ecriture dans le fichier
print {$nouveaufichier} $nomfichiersimple . "\n";

}

close $nouveaufichier;



