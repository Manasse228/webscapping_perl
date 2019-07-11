#!/usr/bin/perl -w
use strict;
use File::Basename;
use File::Copy;


	#Recuperation des fichiers d'extention .csv
my @tablodefichiers = <garedetri/atrier/*.csv>;


	#Parcours du tableau contant tous les fichiers
  foreach my $nomfichier (@tablodefichiers) {

	#Recuperation du fichier avec extention
my $nomfichiersimple = basename("$nomfichier");

print "nom $nomfichiersimple\n";

if ($nomfichiersimple =~ /\.net.csv$/i) {
	
   #Deplacement des fichiers vers le dosser spécifiques
	move( $nomfichier, 'garedetri/tri.net/' ) 
	or die "Echec de la copie du fichier ${nomfichiersimple}: $!";
   
}else{
	if ($nomfichiersimple =~ /\.com.csv$/i) {

   #Deplacement des fichiers vers le dosser spécifiques
	move( $nomfichier, 'garedetri/tri.com/' ) 
	or die "Echec de la copie du fichier ${nomfichiersimple}: $!";
   
}else{
	if ($nomfichiersimple =~ /\.eu.csv$/i) {
		
   #Deplacement des fichiers vers le dosser spécifiques
	move( $nomfichier, 'garedetri/tri.eu/' ) 
	or die "Echec de la copie du fichier ${nomfichiersimple}: $!";
   
}else{
	
	#Deplacement des fichiers vers le dosser spécifiques
	move( $nomfichier, 'garedetri/tri.autres/' ) 
	or die "Echec de la copie du fichier ${nomfichiersimple}: $!";
	
}
}
	
}
	
}
