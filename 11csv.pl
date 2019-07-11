#!/usr/bin/perl -w
use strict;
use File::Basename;
use Time::Piece;

#if( ( my @files = glob("garedetri/11csv/*") ) || !( my @files1 = glob("garedetri/10bestones/*.html") ) ){
#	print "arret\n";
#}else{
#	print "tout est correct\n";
	listing();
#} 

sub listing{
		#Recuperation des fichiers 
my @tablodefichiers = <garedetri/10bestones/*.html>;
	#Création du fichier contenant la liste des noms de fichier
my $datejour=localtime->dmy;
my $heure = localtime->hms;
#my $all = "$datejour"."-$heure";
open my $nouveaufichier, '>', "garedetri/11csv/$datejour-$heure.csv";

		#Parcours du tableau contant les fichiers
  foreach my $nomfichier (@tablodefichiers) {
	  
		#Recuperation du fichier avec extention
my $nomfichiersimple = basename("$nomfichier");

		#Suppression des extensions
$nomfichiersimple =~ s{\.[^.]+$}{};

		#Ecriture dans le fichier
print {$nouveaufichier} $nomfichiersimple . "\n";
#on suprime le fichier
unlink $nomfichier;
}

close $nouveaufichier;

}
