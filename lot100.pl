#!/usr/bin/perl -w
use strict;
use warnings;
use File::Copy;

		#Recuperation des fichiers peu importe leur nom
my @tablodefichiers = <garedetri/tri.com/stock/*.csv>;
my $compteur = 0;

		#Parcours du tableau contant les fichiers
  foreach my $nomfichier (@tablodefichiers) {
	  
	  $compteur++;
	  if($compteur <=100){
		  
		#Deplacement des fichiers vers le dosser spécifiques
	move( $nomfichier, 'garedetri/tri.com/lot100' ) 
	or die "Echec du déplacement du fichier: ${nomfichier}: $!";
	
 }else{
	 last;
 }
	
}




